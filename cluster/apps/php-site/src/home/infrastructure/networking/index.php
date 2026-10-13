<?php
$pageTitle = "inkku - infrastructure/networking";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>

<!-- Documentation Sidebar Navigation -->
<nav class="sidebar-nav" id="sidebarNav" aria-label="Infrastructure sections">
    <div class="sidebar-title">Infrastructure Docs</div>
    <a href="/infrastructure/" class="sidebar-link">Overview</a>
    <a href="/infrastructure/terraform" class="sidebar-link">Terraform</a>
    <a href="/infrastructure/ansible" class="sidebar-link">Ansible</a>
    <a href="/infrastructure/gitops" class="sidebar-link">GitOps pipeline</a>
    <a href="/infrastructure/kubernetes" class="sidebar-link">Kubernetes</a>
    <a href="/infrastructure/networking" class="sidebar-link active">Networking</a>
    <a href="/infrastructure/monitoring" class="sidebar-link">Monitoring & Observability</a>
</nav>


<div id="main-container">
<div id="content">
<div class="main-header-box">
  Networking
</div>
<div class="site-content-box">
<h3 class="subheading">Summary</h3>
This page covers how traffic reaches services running in the cluster and the design decisions behind the public 
ingress layer.
For web applications, all inbound traffic passes through Cloudflare and Cloudflare Tunnel before entering the 
Kubernetes cluster. No HTTP or HTTPS ports are exposed directly on the home network.
Game traffic is handled differently. Minecraft uses a direct TCP path because Cloudflare's free tunnel service 
only proxies HTTP(s) traffic.

<img class="zoomD-small" src="/infrastructure/img/request_final.svg" id="gitops-graph">
This is how you accessed this site. Incoming requests pass through Cloudflare Tunnel to Traefik, 
which routes traffic to the appropriate Kubernetes Service and ultimately the application Pod. 
Cloudflare plays a major role, as there is no need to manually configure certificates, open ports, or local firewalls.
WAF features allow region blocking. Currently only traffic from Finland and Sweden is allowed.

<h4>Traffic paths</h4>
The platform currently exposes two different types of traffic.
<ul>
  <li><b>HTTP(s) (websites, Matomo, dashboards)</b> - websites, monitoring dashboards and other web applications are published through Cloudflare Tunnel</li>
  <li><b>TCP</b> - Minecraft traffic bypasses the tunnel and reaches the cluster through a dedicated (non-standard for security) forwarded port.
  A custom DNS SRV record lets players connect cleanly without typing port numbers, while keeping the server's origin IP unproxied.</li>
</ul>

<div class="infostack">
<h4>HTTP request flow</h4>
<ol>
<li><b>Browser</b> - resolves <code>inkku.xyz</code> via Cloudflare DNS</li>
<li><b>Cloudflare</b> - terminates TLS, applies WAF rules, forwards over the tunnel</li>
<li><b>Tunnel VM (cloudflared)</b> - outbound-only forward</li>
<li><b>Traefik</b> - k3s's built-in ingress controller, reads the <code>Ingress</code> resource and routes by hostname to the right Kubernetes Service</li>
<li><b>Application</b> - processes request and returns a response</li>
</ol>
</div>

<h3 class="subheading">Traefik vs. the application's nginx</h3>
nginx is not the cluster ingress. Routing decisions happen at two different layers:

<div class="infostack">
<ul>
<li><b>Traefik</b> - k3s's default ingress controller. Cluster-level and generic: it owns the <code>Ingress</code> resource and decides which Kubernetes Service a hostname routes to.</li>
<li><b>Application nginx</b> - a Pod, not a cluster component. It's <code>php-site</code>-specific: PHP routing, static files, and the reverse-proxy hop to the Azure-hosted Kaatokänni400 app all happen here, one layer below where Kubernetes' own routing ends.</li>
</ul>
</div>
Traefik's job is only selecting the right Service. What that Service's Pod does with the request from there is application logic, not cluster infrastructure.

<h3 class="subheading">Why the tunnel gets its own VM</h3>
cloudflared runs on a dedicated, minimal VM (1 vCPU / 1GB) rather than as a Pod inside the k3s cluster.
<div class="infostack">
<ul>
<li>The public entry point remains independent from the cluster itself. A k3s node reboot, upgrade, or outage doesn't also take down the tunnel</li>
<li>The tunnel performs a single task and has very small resource requirements, making it easy to reason about and rebuild.</li>
</ul>
</div>

<h3 class="subheading">Cloudflare's role beyond the tunnel</h3>
Alongside the Tunnel, Cloudflare handles DNS, TLS termination, and access control before traffic ever reaches the home network.
<div class="infostack">
<ul>
<li><b>DNS</b> - <code>inkku.xyz</code> and its subdomains resolve to Cloudflare</li>
<li><b>TLS termination</b> - certificates are handled at the edge</li>
<li><b>WAF region-block</b> - only traffic from Finland and Sweden is currently allowed through, 
cutting exposure to the rest of the internet by default</li>
</ul>
</div>

<h3 class="subheading">Management access</h3>

Public application traffic and infrastructure administration use separate paths.

Applications are exposed through Cloudflare Tunnel, while administrative access is restricted to the home network and an OpenVPN server running on the router.

When connected through the VPN, I can:

<ul>
<li>Access the Proxmox management interface</li>
<li>SSH into virtual machines</li>
<li>Manage the Kubernetes cluster directly</li>
<li>Access services that are intentionally not exposed to the public internet</li>
</ul>

This keeps infrastructure management separate from public application ingress and avoids exposing administrative interfaces to the internet.

<h3 class="subheading">Known gaps & future plans</h3>
<div class="infostack">
<ul>
<li><b>Tunnel routing isn't version-controlled</b> - Right now, mapping <code>inkku.xyz</code> to the in-cluster Traefik service requires manual clicks in the 
Cloudflare Zero Trust dashboard. This breaks the strict GitOps philosophy used everywhere else in the project. 
The planned fix is to adopt the Cloudflare Terraform provider to manage the tunnel, ingress rules, and DNS records declaratively alongside the VMs. 
This ensures that if the tunnel configuration is ever lost, recreating it is just a <code>terraform apply</code> away, requiring zero manual UI clicks.</li>
</ul>
</div>




</div>
</div>
</div>
</div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/github-dark.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>

<script>hljs.highlightAll();</script>


<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>
