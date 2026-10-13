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
The platform runs on a k3s cluster consisting of one control-plane node and two worker nodes.

All applications are deployed through Argo CD and managed through the GitOps workflow described earlier. 
No workloads are deployed manually with kubectl.
<br><br>
<h3>Workload types</h3>
<ul>
  <li><b>Stateless Deployments (php-site, Grafana, Matomo web frontend)</b> - Used where pod instances are completely disposable and hold no unique local data. 
  Scaling or replacing a pod carries zero risk of data loss.</li>
  <li><b>StatefulSets (Minecraft, MariaDB)</b> - These workloads depend on PersistentVolumeClaims and benefit from predictable pod naming and storage assignment.</li>
</ul>
<br>
<h3 class="subheading">Example: php-site</h3>
<code>php-site</code> is split into a <code>php-deployment</code> (PHP-FPM) and an <code>nginx-deployment</code>, each with its own Service. 
nginx serves static content, routes PHP requests to <code>php-service:9000</code> over FastCGI, 
and proxies one specific path to an entirely separate hosting platform.
<br><br>
For example, changes to frontend assets or nginx configuration can be deployed without restarting 
PHP worker processes. Likewise, PHP updates do not require rebuilding the nginx container.


<h3 class="subheading">nginx config</h3>
<code>home.conf</code> handles the <code>inkku.xyz</code> virtual host.
Most traffic stays inside the cluster. Static files are served directly by nginx and PHP requests are 
forwarded to the PHP-FPM deployment through the internal Kubernetes service.
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
</code></pre>
</div>
The <code>/projects/kaatokanni400/</code> path is an exception. 
Requests matching that route are reverse proxied to an Azure App Service instance instead of a 
Kubernetes workload.<br><br>
The application has its own deployment pipeline and hosting environment, but nginx makes it look like part of 
the same site.
From a visitor's perspective, everything still appears under a single domain even though 
some applications are hosted outside the cluster. 


This setup allowed me to migrate individual applications independently without changing user-facing URLs 
or introducing additional domains.
<br><br>
<code>minecraft.conf</code> handles the separate <code>minecraft.inkku.xyz</code> virtual host.


<h3 class="subheading">Service layer</h3>

The PHP-FPM and nginx Deployments each have their own ClusterIP Service.
These Services are only used for communication inside the cluster. They are not exposed directly to the internet.
The ingress forwards external traffic to nginx, and nginx then either:

<ul>
<li>serves static content directly</li>
<li>forwards PHP requests to the PHP-FPM service</li>
<li>proxies requests to Azure App Service when the request targets <code>/projects/kaatokanni400/</code></li>
</ul>

This keeps the PHP backend isolated while allowing nginx to act as a unified entry point for both local and external workloads.

<h3 class="subheading">Ingress</h3>
A single Ingress resource routes both <code>inkku.xyz</code> and <code>minecraft.inkku.xyz</code> to the same <code>nginx-service</code>.
 This is host-based routing, not path-based. nginx itself decides what to serve based on the <code>Host</code> header and, 
within <code>inkku.xyz</code>, the request path.



<h3 class="subheading">Hardening & lessons learned</h3>
Running workloads on a single physical host with strict resource constraints (120GB SSD, shared RAM) highlighted several operational realities.
<div class="infostack">
<ul>
<li><b>Resource limits</b>Currently, workloads run without strict requests and limits. On a hardware-constrained 
server, an unconstrained pod 
(e.g., Prometheus ingestion spikes) risks causing OOM (Out Of Memory) kills on neighboring workloads. 
<li><b>No liveness/readiness probes</b> - Kubernetes has no way to know if PHP-FPM or nginx is actually healthy versus just running.</li>
<li><b>Anti-affinity rules</b>To prevent disk I/O bottlenecks, high-volume disk writers are explicitly separated. 
For example, Grafana and Prometheus utilize <code>podAntiAffinity</code> to prevent co-location on the same worker 
node.</ul>
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
