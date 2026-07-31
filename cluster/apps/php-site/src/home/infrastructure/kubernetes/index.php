<?php
$pageTitle = "inkku - infrastructure/kubernetes";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>

<!-- Documentation Sidebar Navigation -->
<nav class="sidebar-nav" id="sidebarNav" aria-label="Infrastructure sections">
    <div class="sidebar-title">Infrastructure Docs</div>
    <a href="/infrastructure/" class="sidebar-link">Overview</a>
    <a href="/infrastructure/terraform" class="sidebar-link">Terraform</a>
    <a href="/infrastructure/ansible" class="sidebar-link">Ansible</a>
    <a href="/infrastructure/gitops" class="sidebar-link">GitOps pipeline</a>
    <a href="/infrastructure/kubernetes" class="sidebar-link active">Kubernetes</a>
    <a href="/infrastructure/networking" class="sidebar-link">Networking</a>
    <a href="/infrastructure/monitoring" class="sidebar-link">Monitoring & Observability</a>
</nav>


<div id="main-container">
<div id="content">
<div class="main-header-box">
  Kubernetes
</div>
<div class="site-content-box">
<h3 class="subheading">Summary</h3>
The cluster runs as k3s (server + 2 workers), with all application workloads living in the <code>apps</code> namespace.
Every manifest on this page is applied by Argo CD, driven by the GitOps loop.
While the cluster hosts a full observability stack, analytics, and stateful game servers, this page uses <code>php-site</code> as an architectural case study for 
stateless web services demonstrating container decoupling, FastCGI routing, and hybrid-cloud egress proxying.

<h3>Workload Design (StatefulSets vs. Deployments)</h3>
A common anti-pattern in homelabs is treating every workload as a generic Deployment. 
In this cluster, workload primitives are chosen based on state boundaries and identity requirements:
<ul>
  <li><b>Stateless Deployments (php-site, Grafana)</b> - Used where pod instances are completely disposable and hold no unique local data. 
  Scaling or replacing a pod carries zero risk of data loss.</li>
  <li><b>StatefulSets (PaperMC Minecraft, MariaDB)</b> - Reserved for workloads requiring stable network identifiers and persistent storage bindings (PersistentVolumeClaims). 
  PaperMC requires deterministic disk writes for world files, and MariaDB requires strict volume binding to prevent database corruption on pod rescheduling.</li>
</ul>
<h3 class="subheading">Why two Deployments</h3>
<code>php-site</code> is split into a <code>php-deployment</code> (PHP-FPM) and an <code>nginx-deployment</code>, each with its own Service. 
nginx serves static content, routes PHP requests to <code>php-service:9000</code> over FastCGI, 
and proxies one specific path to an entirely separate hosting platform.


<div class="infostack">
<h4>php-deployment.yaml</h4>
<pre><code>spec:
replicas: 1
template:
spec:
imagePullSecrets:
- name: ghcr-secret
containers:
- name: php
image: ghcr.io/inkku3/primergy-lab-php:latest
ports:
- containerPort: 9000</code></pre>
</div>

Decoupling nginx and PHP-FPM into separate Deployments (rather than a single multi-container pod) allows independent scaling and image rollouts. 
A frontend CSS/template change built by GitHub Actions updates the nginx Deployment instantly without terminating or interrupting running PHP process workers.


<h3 class="subheading">nginx config</h3>
<code>home.conf</code> handles the <code>inkku.xyz</code> virtual host, and it's doing more than serving PHP. 
Three distinct routing behaviors live in the same server block:

<div class="infostack">
<h4>home.conf</h4>
<pre><code>location / {
  try_files $uri $uri/ /index.php?$query_string;
}
location /projects/kaatokanni400/ {
  proxy_pass https://kaatokanni-app-frfgfrhcgkcwcsgp.swedencentral-01.azurewebsites.net/;
  proxy_set_header Host kaatokanni-app-frfgfrhcgkcwcsgp.swedencentral-01.azurewebsites.net;
  proxy_set_header X-Forwarded-Proto https;
}
location ~ \.php$ {
  fastcgi_pass php-service:9000;
  fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
}</code></pre>
</div>

<ul>
<li><b>Static + PHP routing</b> - <code>try_files</code> falls through to <code>index.php</code> for anything not a static file</li>
<li><b>Internal FastCGI</b> - <code>.php</code> requests are handed to <code>php-service:9000</code>, resolved via k3s's in-cluster DNS, never leaving the cluster</li>
<li><b>External reverse proxy</b> - <code>/projects/kaatokanni400/</code> is proxied straight through to an Azure App Service URL, with <code>proxy_set_header Host</code> rewritten so Azure's routing accepts the request</li>
</ul>

This is the actual mechanism behind running one workload on Azure App Service while it still appears to live under <code>inkku.xyz</code><br>
From a visitor's perspective there's one site.
Under the hood, nginx routes standard traffic to local K3s pods while silently reverse-proxying <code>/projects/kaatokanni400/</code>
to an external Azure App Service instance in Sweden, rewriting Host and X-Forwarded-Proto headers on the fly.
<code>minecraft.conf</code> handles the second vhost (<code>minecraft.inkku.xyz</code>) separately.

<h3 class="subheading">Service layer</h3>
Both Deployments get a matching <code>ClusterIP</code> Service, keyed to their pod labels. 
Neither Service is reachable from outside the cluster on its own as the Ingress handles that. For the Azure path, nginx itself is the egress point.


<h3 class="subheading">Ingress</h3>
A single Ingress resource routes both <code>inkku.xyz</code> and <code>minecraft.inkku.xyz</code> to the same <code>nginx-service</code>.
 This is host-based routing, not path-based. nginx itself decides what to serve based on the <code>Host</code> header and, 
within <code>inkku.xyz</code>, the request path.

<div class="infostack">
<h4>ingress.yaml</h4>
<pre><code>rules:
- host: inkku.xyz
http:
paths:
- path: /
backend: { service: { name: nginx-service, port: 80 } }
- host: minecraft.inkku.xyz
http:
paths:
- path: /
backend: { service: { name: nginx-service, port: 80 } }</code></pre>
</div>

<h3 class="subheading">Hardening & Operational Realities</h3>
Running workloads on a single physical host with strict resource constraints (120GB SSD, shared RAM) highlighted several operational realities.
<div class="infostack">
<ul>
<li><b>Resource Limits & Quotas</b>Currently, workloads run without strict requests and limits. On a hardware-constrained server, an unconstrained pod 
(e.g., Prometheus ingestion spikes) risks causing OOM (Out Of Memory) kills on neighboring workloads. 
Implementing CPU/memory boundaries is the immediate next priority for cluster stability.
<li><b>No liveness/readiness probes</b> - Kubernetes has no way to know if PHP-FPM or nginx is actually healthy versus just running. Health checks must reflect actual application readiness, not just binary existence.</li>
<li><b>Anti-affinity rules</b>To prevent disk I/O bottlenecks, high-volume disk writers are explicitly separated. 
For example, Grafana and Prometheus utilize <code>podAntiAffinity</code> to prevent co-location on the same worker node, preventing SQLite backing store lockups 
caused by Prometheus TSDB write contention.</ul>
</div>



<h4>Source code on <a href="https://github.com/inkku3/primergy-lab/">GitHub</a>.</h4>


</div>
</div>
</div>
</div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/github-dark.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>

<script>hljs.highlightAll();</script>


<script>
// Image zooming by Molly on codepen
var zoomImg = function() {
    // Create evil image clone
    var clone = this.cloneNode();
    clone.classList.remove("zoomD");

    // Put evil clone into lightbox
    var lb = document.getElementById("lb-img");
    lb.innerHTML = "";
    lb.appendChild(clone);

    // Show lightbox
    lb = document.getElementById("lb-back");
    lb.classList.add("show");
};

window.addEventListener("load", function() {
    // Attach on click events to all .zoomD images
    var images = document.getElementsByClassName("zoomD");
    if (images.length > 0) {
      for (var img of images) {
        img.addEventListener("click", zoomImg);
      }
    }

    // Click event to hide the lightbox
    document.getElementById("lb-back").addEventListener("click", function() {
      this.classList.remove("show");
    });
});
</script>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>
