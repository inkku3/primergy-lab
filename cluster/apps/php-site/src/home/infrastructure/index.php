<?php
$pageTitle = "inkku - infrastructure";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>

<!-- Documentation Sidebar Navigation -->
<nav class="sidebar-nav" id="sidebarNav" aria-label="Infrastructure sections">
    <div class="sidebar-title">Infrastructure Docs</div>
    <a href="/infrastructure/" class="sidebar-link active">Overview</a>
    <a href="/infrastructure/terraform" class="sidebar-link">Terraform</a>
    <a href="/infrastructure/ansible" class="sidebar-link">Ansible</a>
    <a href="/infrastructure/gitops" class="sidebar-link">GitOps pipeline</a>
    <a href="/infrastructure/kubernetes" class="sidebar-link">Kubernetes</a>
    <a href="/infrastructure/networking" class="sidebar-link">Networking</a>
</nav>


  <div id="lb-back">
    <div id="lb-img"></div>
  </div>
<div id="main-container">
<div id="content">
<div class="main-header-box">
Infrastructure overview
</div>
<div class="site-content-box">
<h3 class="subheading">Summary</h3>
A self-hosted platform built around Proxmox, Terraform, Ansible and Kubernetes using GitOps principles. 
The project was created to learn production-style platform engineering while providing infrastructure for my own applications.
There is a full deployment pipeline from <code>git push</code> to a live rolling update. No manual <code>kubectl</code> steps anywhere.

<div class="infostack">
<h4>Goals:</h4>
<ul>
<li>Build a production-style deployment platform</li>
<li>Automate infrastructure provisioning </li>
<li>Build a real GitOps loop </li>
<li>Separate provisioning from configuration management </li>
<li>Understand workload scheduling and resilience within a single host, constrained environment</li>
</ul>
</div>

<h3 class="subheading">Architecture</h3>
The entire platform runs on a single enterprise-grade Fujitsu Primergy RX2530 M2 rack server. Terraform provisions 5 VMs inside Proxmox using a Ubuntu Server cloud-init template.
<img class="zoomD" src="/infrastructure/img/arch_final.svg" id="architecture">
Because everything runs on one physical host, this is workload distribution and fault isolation at the VM/pod level.
As all virtual machines ultimately share the same hardware, 
the platform provides workload isolation rather than true high availability. A hardware failure would still take down the entire environment.

<div class="infostack">
<h4>Why did I choose..</h4>
<ul>
<li> <b>Proxmox</b> - provides enterprise-grade virtualization, snapshots and VM lifecycle management while remaining practical for a home lab. </li>
<li><b>Terraform</b> - declarative infrastructure provisioning and reproducible VM creation</li>
<li><b>Ansible</b> - idempotent server configuration, separates infra provisioning from configuration</li>
<li><b>Kubernetes (k3s)</b> - lightweight enough for the hardware, still teaches real orchestration concepts</li>
<li><b>Cloudflare Tunnel</b> - removes the need for inbound ports while handling TLS termination and public exposure</li>
<li><b>Argo CD / GitOps</b> - Git is the single source of truth. Every change is auditable and revertible through Git history</li>
</ul>
</div>

<h3 class="subheading">Automation pipeline (GitOps loop)</h3>
Starting with a <code>git push</code> the diagram below shows how the GitOps pipeline works. GitHub Actions builds and pushes the images which are updated to the 
running Kubernetes application using Argo CD Image Updater.

<img class="zoomD" src="/infrastructure/img/GitOps_final.svg" id="gitops-graph">

Argo CD Image Updater monitors the registry for new image versions and updates the image references in the application's <code>kustomization.yaml.</code>
This Git commit becomes the desired state that Argo CD reconciles to the Kubernetes cluster, resulting in an automated rolling update without 
manual deployment commands.<br>
Every deployment is traceable through Git history. This is especially important as the infrastructure has grown quite large.

<img class="zoomD-small" src="/infrastructure/img/request_final.svg" id="gitops-graph">
This is how you accessed this site. Incoming requests pass through Cloudflare Tunnel to Traefik, 
which routes traffic to the appropriate Kubernetes Service and ultimately the application Pod. 
Cloudflare plays a major role, as there is no need to manually configure certificates, open ports, or local firewalls.
WAF features allow region blocking. Currently only traffic from Finland and Sweden is allowed. 

<h3 class="subheading">Current status</h3>
<h4>Infrastructure</h4>
<table>
  <tr>
    <th>Component</th>
    <th>Status</th>
    <th>Info</th>
  </tr>
  <tr>
    <td>Proxmox infrastructure</td>
    <td style="color:#30D900">OK &#10004;</td>
    <td>In place</td>
  </tr>
  <tr>
    <td>Terraform provisioning</td>
    <td style="color:#30D900">OK &#10004;</td>
    <td>Uses a Ubuntu Server cloud-init template</td>
  </tr>
  <tr>
    <td>Ansible configuration</td>
    <td style="color:#30D900">OK &#10004;</td>
    <td>Configures VMs</td>
  </tr>
  <tr>
    <td>k3s cluster and ArgoCD</td>
    <td style="color:#30D900">OK &#10004;</td>
    <td>Done, expandable via GitOps pipeline</td>
  </tr>
  <tr>
    <td>Monitoring</td>
    <td>Planned</td>
    <td>Grafana and Prometheus stack</td>
  </tr>
  <tr>
    <td>Tailscale</td>
    <td>Planned</td>
    <td>Use a VPN to manage remotely</td>
  </tr>
  <tr>
    <td>Backups</td>
    <td>Planned</td>
    <td>TBD</td>
  </tr>
</table>
<br>
<h4>Deployed workloads</h4>
<table>
  <tr>
    <th>Service</th>
    <th>Platform</th>
    <th>Status</th>
  </tr>
  <tr>
    <td>Portfolio website</td>
    <td>Kubernetes</td>
    <td style="color:#30D900">Live &#10004;</td>
  </tr>
  <tr>
    <td>Keittokirja</td>
    <td>Kubernetes</td>
    <td style="color:#F5A50F">In progress</td>
  </tr>
  <tr>
    <td>Kaatokänni400</td>
    <td>Azure App Service</td>
    <td style="color:#30D900">Live &#10004;</td>
  </tr>
  <tr>
    <td>Minecraft server</td>
    <td>Kubernetes</td>
    <td style="color:#30D900">Live &#10004;</td>
  </tr>
  <tr>
    <td>Matomo analytics</td>
    <td>Kubernetes</td>
    <td style="color:#30D900">Live &#10004;</td>
  </tr>
  <tr>
    <td>Monitoring</td>
    <td>To be planned</td>
    <td>Planned</td>
  </tr>
</table>
<br>
Not every project is hosted on the Kubernetes cluster. 
<b><a href="https://inkku.xyz/projects/kaatokanni400/">Kaatokänni400</a> </b>currently runs on <b>Azure App Service</b> and is integrated into the portfolio through an nginx reverse proxy. 
Its architecture and deployment pipeline are documented separately.
<br>
<h4>Source code on GitHub</h4>
<b><a href="https://github.com/inkku3/primergy-lab/tree/main">Current infrastructure</a></b><br>
<b><a href="https://github.com/inkku3/kaatokanni400">Kaatokänni400</a></b><br>

</div>
</div>
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
