<?php
$pageTitle = "inkku - infrastructure/terraform";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>

<!-- Documentation Sidebar Navigation -->
<nav class="sidebar-nav" id="sidebarNav" aria-label="Infrastructure sections">
    <div class="sidebar-title">Infrastructure Docs</div>
    <a href="/infrastructure/" class="sidebar-link">Overview</a>
    <a href="/infrastructure/terraform" class="sidebar-link active">Terraform</a>
    <a href="/infrastructure/ansible" class="sidebar-link">Ansible</a>
    <a href="/infrastructure/gitops" class="sidebar-link">GitOps pipeline</a>
    <a href="/infrastructure/kubernetes" class="sidebar-link">Kubernetes</a>
    <a href="/infrastructure/networking" class="sidebar-link">Networking</a>
    <a href="/infrastructure/monitoring" class="sidebar-link">Monitoring & Observability</a>
</nav>


<div id="main-container">
<div id="content">
<div class="main-header-box">
  Terraform
</div>
<div class="site-content-box">

<h3 class="subheading">Summary</h3>
Terraform provisions the 5 VMs that make up the platform inside Proxmox, 
cloning each from the same template and sizing it for its specific role.
Everything else (Ansible, k3s, ArgoCD) assumes these VMs already exist, are reachable, and are correctly sized.
Terraform's job stops at an existing bootable VM that is reachable by SSH. 
It does not configure anything inside the OS.

<div class="infostack">
<h4>What Terraform does</h4>
<ul>
<li>Provider connection to Proxmox (<code>bpg/proxmox</code>, via API endpoint + token auth)</li>
<li>VM definitions for each role driven by a single <code>vms</code> map variable</li>
<li>Per-role sizing: cores, memory, and disk scaled to what each VM actually needs</li>
<li>Cloud-init injection for the <code>ansible</code> user, SSH key, and static IPs</li>
<li>Dynamically generating the Ansible inventory file from the resulting VM IPs</li>
</ul>
</div>

<h3 class="subheading">VM layout</h3>
Rather than five identical nodes, each VM is sized for its role. 
<table>
  <tr>
    <th>Role</th>
    <th>vCPUs</th>
    <th>Memory</th>
    <th>Disk</th>
    <th>Static IP</th>
  </tr>
  <tr>
    <td>control-plane</td>
    <td>2</td>
    <td>6 GB</td>
    <td>20 GB</td>
    <td>192.168.0.101</td>
  </tr>
  <tr>
    <td>worker-1</td>
    <td>6</td>
    <td>16 GB</td>
    <td>32 GB</td>
    <td>192.168.0.102</td>
  </tr>
  <tr>
    <td>worker-2</td>
    <td>6</td>
    <td>16 GB</td>
    <td>32 GB</td>
    <td>192.168.0.103</td>
  </tr>
  <tr>
    <td>utility</td>
    <td>2</td>
    <td>4 GB</td>
    <td>20 GB</td>
    <td>192.168.0.104</td>
  </tr>
  <tr>
    <td>cloudflared</td>
    <td>1</td>
    <td>2 GB</td>
    <td>10 GB</td>
    <td>192.168.0.105</td>
  </tr>
</table>
<br>
The two workers carry the real compute budget of the host, leaving the control-plane and utility VMs 
lean since they don't run application workloads directly.
The cloudflared tunnel VM does one job and gets exactly the resources that job needs.
Because this entire platform runs on a host with a hard 120GB SSD limit, capacity planning had to be exact. 
The VM allocation totals 114 GB, leaving roughly 6 GB available for Proxmox overhead and LVM metadata.

  <!-- LIGHTBOX CONTAINER -->
  <div id="lb-back">
    <div id="lb-img"></div>
  </div>

  <img class="zoomD" src="/infrastructure/terraform/terraform_final.svg" id="terraform-graph">


<h3 class="subheading">Provisioning flow</h3>
A single <code>terraform apply</code> loops over the <code>vms</code> map with <code>for_each</code>, 
cloning every VM from the same template but applying each role's own cores/memory/disk/IP. 
<br><br>
Adding another node only requires a new entry in the map.

<div class="infostack">
<h4>VM resource definition example</h4>
<pre><code style="font-size: 14px; line-height: 1.3;">resource "proxmox_virtual_environment_vm" "vm" {
  for_each  = var.vms

  name      = each.key
  vm_id     = each.value.vmid

  cpu {
    cores = each.value.cores
  }

  memory {
    dedicated = each.value.memory
  }

  ...
  
  initialization {
    ...
    ip_config {
      ipv4 {
        address = "${each.value.ip}"
        gateway = "192.168.0.1"
      }
    }
  }
}
</code></pre>
The full configuration is available on GitHub.
</div>

<h3 class="subheading">Handoff to Ansible</h3>
Once VMs exist, <code>ansible_inventory.tf</code> pulls the IPs straight out of the same <code>vms</code> map and renders <code>inventory.tftpl</code> 
into an Ansible inventory at <code>ansible/inventory.ini</code>. 
I use Terraform's templatefile function (.tftpl).

<div class="infostack">
<h4>Example</h4>
<pre><code style="font-size: 14px; line-height: 1.3;">[control_plane]
192.168.0.101 ansible_user=ansible

[workers]
192.168.0.102 ansible_user=ansible
192.168.0.103 ansible_user=ansible

...

[k3s_cluster:children]
control_plane
workers
</code></pre>
The <code>k3s_cluster:children</code> group is what lets the Ansible 
playbook target the whole cluster without hardcoding which node is which.
</div>




<div class="infostack">
<h4>Why split Terraform/Ansible</h4>
<ul>
<li>Re-running <code>terraform apply</code> won't reconfigure a VM's software, and re-running the Ansible playbook won't recreate VMs</li>
<li>Infrastructure changes (resize a worker, add a node) and configuration changes (bump the k3s version) can be reasoned about and version controlled independently</li>
<li>The generated inventory means there is no manually maintained IP list</li>
</ul>
</div>
<br>

<h4>Source code on <a href="https://github.com/inkku3/primergy-lab/tree/main/terraform">GitHub</a>.</h4>


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
