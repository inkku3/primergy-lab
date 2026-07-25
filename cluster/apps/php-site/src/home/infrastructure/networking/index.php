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
</nav>


<div id="main-container">
<div id="content">
<div class="main-header-box">
  Networking
</div>
<div class="site-content-box">
<h3 class="subheading">Summary</h3>
Two distinct concerns live under "networking" here: how public traffic reaches a Pod from the internet, and how the platform is administered.
 Only the first exists today.
The public path runs through Cloudflare, a dedicated tunnel VM, and a cluster-level ingress controller.


<div class="infostack">
<h4>Hop by hop</h4>
<ol>
<li><b>Browser</b> - resolves <code>inkku.xyz</code> via Cloudflare DNS</li>
<li><b>Cloudflare</b> - terminates TLS, applies WAF rules, forwards over the tunnel</li>
<li><b>Tunnel VM (cloudflared)</b> - outbound-only connection to Cloudflare; no inbound port is ever opened on the home network</li>
<li><b>Traefik</b> - k3s's built-in ingress controller, reads the <code>Ingress</code> resource and routes by hostname to the right Kubernetes Service</li>
<li><b>Application</b> (nginx-service -> nginx pod -> php-service -> php pod) - everything past this point is the app's own routing, covered in detail on the Kubernetes page</li>
</ol>
</div>

<h3 class="subheading">Traefik vs. the application's nginx</h3>
Here nginx is not the ingress. The distinction matters for understanding where a routing decision actually happens:

<div class="infostack">
<ul>
<li><b>Traefik</b> - k3s's default ingress controller. Cluster-level and generic: it owns the <code>Ingress</code> resource and decides which Kubernetes Service a hostname routes to. It would be identical no matter what application were deployed.</li>
<li><b>Application nginx</b> - a Pod, not a cluster component. It's <code>php-site</code>-specific: PHP routing, static files, and the reverse-proxy hop to the Azure-hosted Kaatokänni400 app all happen here, one layer below where Kubernetes' own routing ends.</li>
</ul>
</div>
Traefik's job is only seledcting the right Service.
What that Service's Pod does with the request from there is application logic, not cluster infrastructure. 
You can see the Kubernetes page for how <code>php-site</code> handles it.

<h3 class="subheading">Why the tunnel gets its own VM</h3>
cloudflared runs on a dedicated, minimal VM (1 vCPU / 1GB) rather than as a Pod inside the k3s cluster.
<div class="infostack">
<ul>
<li>The public entry point's availability isn't coupled to the cluster's. A k3s node reboot, upgrade, or outage doesn't also take down the tunnel</li>
<li>Smaller, simpler blast radius: a single-purpose VM doing one job is easier to reason about and re-provision than a tunnel Pod competing for scheduling with application workloads</li>
<li>No inbound port ever needs to open on the home network's firewall or router as the tunnel is entirely outbound-initiated</li>
</ul>
</div>

<h3 class="subheading">How the tunnel is installed</h3>
The Ansible role installs cloudflared from Cloudflare's own apt repository (pinned via <code>deb822_repository</code>, with legacy conflicting repo files explicitly removed first) and registers it as a systemd service using a tunnel token:

<div class="infostack">
<pre><code>- name: Install cloudflared service with token
command: "cloudflared service install {{ cloudflare_tunnel_token }}"
args:
creates: /etc/systemd/system/cloudflared.service
no_log: true</code></pre>
</div>

<code>no_log: true</code> keeps the token out of Ansible's own output.<br>
<code>creates:</code> also makes this step idempotent: re-running the playbook won't reinstall the service or need the token again once it exists.
<br><br>
This is a token-based, remotely-managed tunnel rather than a locally-defined one. 
As the tunnel's routing rules are configured in the Cloudflare Zero Trust dashboard they aren't a version-controlled config anywhere in this repo. 
Everything else on this platform is declarative and in Git. This one piece currently isn't.

<h3 class="subheading">Cloudflare's role beyond the tunnel</h3>
Alongside the Tunnel, Cloudflare handles DNS, TLS termination, and access control before traffic ever reaches the home network.
<div class="infostack">
<ul>
<li><b>DNS</b> - <code>inkku.xyz</code> and its subdomains resolve to Cloudflare, not to any home IP</li>
<li><b>TLS termination</b> - certificates are Cloudflare's problem, not something manually managed on the tunnel VM or in-cluster</li>
<li><b>WAF region-block</b> - only traffic from Finland and Sweden is currently allowed through, 
cutting exposure to the rest of the internet by default</li>
</ul>
</div>

<h3 class="subheading">Known gaps</h3>
<div class="infostack">
<ul>
<li><b>Tunnel routing isn't version-controlled</b></li>
<li><b>No separate management network</b> - reaching Proxmox, 
SSHing into a VM, or managing the cluster directly still depends on already being on the home network. 
Tailscale is planned specifically to close this with a private, authenticated overlay separate from the public ingress path above</li>
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
