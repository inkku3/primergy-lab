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
    <a href="/infrastructure/monitoring" class="sidebar-link">Monitoring & Observability</a>
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
This is a self-hosted platform built with Proxmox, Terraform, Ansible and Kubernetes following GitOps principles. 
I built it to learn platform engineering in a realistic environment while hosting my own applications.
The entire deployment process is automated, from a <code>git push</code> to a live rolling update in Kubernetes.
The goal is to have zero manual <code>kubectl</code> steps.

<br>
<h4>Source code on GitHub</h4>
<b><a href="https://github.com/inkku3/primergy-lab/tree/main">Current infrastructure</a></b><br>
<b><a href="https://github.com/inkku3/kaatokanni400">Kaatokänni400</a></b><br>
<b><a href="https://github.com/inkku3/keittokirja">Keittokirja</a></b><br>



<div class="infostack">
<h4>Highlights</h4>
<ul>
<li>Fully automated <b>GitOps</b> deployment pipeline (ArgoCD, Github Actions)</li>
<li>Infrastructure managed as code with <b>Terraform</b></li>
<li>Configuration management with <b>Ansible</b></li>
<li><b>Kubernetes-based application hosting</b></li>
<li>Monitoring with <b>Prometheus and Grafana</b></li>
<li>Secure ingress through Cloudflare Tunnel</li>
</ul>
</div>

<h3 class="subheading">Architecture</h3>
The entire platform runs on a single <b>Fujitsu Primergy RX2530 M2</b> rack server via <b>Proxmox.</b>
<br>
Storage is limited to a 120 GB SSD, so resource usage is carefully managed.
Terraform provisions five VMs based on an Ubuntu Server cloud-init template, 
and Ansible handles the OS-level configuration and K3s bootstrapping.


<table>
  <tr>
    <th>VM</th>
    <th>Purpose</th>
  </tr>
  <tr>
    <td>Control plane</td>
    <td>Kubernetes control plane</td>
  </tr>
    <tr>
    <td>Worker 1</td>
    <td>Application workloads</td>
  </tr>
    <tr>
    <td>Worker 2</td>
    <td>Application workloads</td>
  </tr>
    <tr>
    <td>Utility</td>
    <td>Shared infrastructure services</td>
  </tr>
    <tr>
    <td>Cloudflare Tunnel</td>
    <td>External access</td>
  </tr>
</table>


The VMs are sized according to their role rather than being identical. 
This leaves more resources available for application workloads.
<img class="zoomD" src="/infrastructure/img/arch_final.svg" id="architecture">
Although the platform uses multiple VMs and Kubernetes nodes, everything runs on a single physical server. 
The design provides workload isolation, not true high availability.


<div class="infostack">
<h4>Technology stack</h4>
<ul>
<li>Proxmox for virtualization</li>
<li>Terraform for infrastructure provisioning</li>
<li>Ansible for configuration management</li>
<li>K3s for container orchestration</li>
<li>Argo CD for GitOps delivery</li>
<li>Cloudflare Tunnel and Traefik for ingress</li>
</ul>
</div>


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
    <td style="color:#30D900">OK &#10004;</td>
    <td>Prometheus, Alertmanager, Grafana, kube-state-metrics, node-exporter</td>
  </tr>
  <tr>
    <td>OpenVPN server</td>
    <td style="color:#30D900">OK &#10004;</td>
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
    <td style="color:#30D900">Live &#10004;</td>
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
    <td>Kubernetes</td>
    <td style="color:#30D900">Live &#10004;</td>
  </tr>
</table>
<br>
<b><a href="https://inkku.xyz/projects/kaatokanni400/">Kaatokänni400</a> </b>currently runs on 
<b>Azure App Service</b> and is integrated into the portfolio through an nginx reverse proxy. 
Its architecture and deployment pipeline are documented separately.
<br>

<h3>Design decisions and trade-offs</h3>
The goal was to learn production-style tooling without introducing unnecessary complexity.
I deliberately chose K3s instead of a full Kubernetes distribution.
<br>
As the entire environment runs on a 120 GB SSD,
 I chose not to use distributed storage solutions such as Longhorn or OpenEBS. 
 In a single-server environment they would consume significant storage while providing 
 little benefit, since all replicas would still depend on the same physical hardware.



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
