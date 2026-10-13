<?php
$pageTitle = "inkku - infrastructure/ansible";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>

<!-- Documentation Sidebar Navigation -->
<nav class="sidebar-nav" id="sidebarNav" aria-label="Infrastructure sections">
    <div class="sidebar-title">Infrastructure Docs</div>
    <a href="/infrastructure/" class="sidebar-link">Overview</a>
    <a href="/infrastructure/terraform" class="sidebar-link">Terraform</a>
    <a href="/infrastructure/ansible" class="sidebar-link active">Ansible</a>
    <a href="/infrastructure/gitops" class="sidebar-link">GitOps pipeline</a>
    <a href="/infrastructure/kubernetes" class="sidebar-link">Kubernetes</a>
    <a href="/infrastructure/networking" class="sidebar-link">Networking</a>
    <a href="/infrastructure/monitoring" class="sidebar-link">Monitoring & Observability</a>
</nav>


<div id="main-container">
<div id="content">
<div class="main-header-box">
  Ansible
</div>
<div class="site-content-box">

<h3 class="subheading">Summary</h3>
Once Terraform finishes provisioning the five VMs, 
Ansible takes over to build out the actual k3s cluster and layer Argo CD on top. 
Its job is to turn a collection of fresh Ubuntu VMs into a working Kubernetes platform. 
The playbook installs k3s, joins the worker nodes, configures supporting services, 
installs Argo CD, and prepares the cluster for GitOps-based deployments.<br><br>

The playbook is designed to be idempotent. Running it against an already configured environment should either make no changes or 
only apply anything that is missing.

<div class="infostack">
<h4>What Ansible does in order</h4>
<ul>
<li>Wait for all 5 VMs to be reachable before doing anything (<code>wait_ready.yml</code>)</li>
<li>Install Docker on the utility VM (<code>docker.yml</code>)</li>
<li>Create the k3s control plane and join workers to it (<code>k3s_server.yml</code>, <code>k3s_agent.yml</code>)</li>
<li>Pull the kubeconfig back to the utility VM so later tasks can talk to the cluster (<code>kubeconfig.yml</code>)</li>
<li>Install the cloudflared tunnel (<code>cloudflared.yml</code>)</li>
<li>Install Argo CD, Argo CD Image Updater, and registering the GitHub repo + GHCR credentials (<code>argocd.yml</code>, <code>argocd_image_updater.yml</code>)</li>
<li>Apply every Argo CD Application manifest from the repo (<code>argocd_apps.yml</code>)</li>
</ul>
</div>
Execution order matters because each stage depends on the one before it.
When adding new applications to the cluster, the preferred method is running a targeted Ansible task that globs 
<code>cluster/argocd/*.yaml</code>
and applies them to the cluster.
<br><br>
I could have used ArgoCD's "App of Apps" pattern to make application registration fully automatic, but
using Ansible keeps the cluster bootstrap phase cleanly separated from steady-state GitOps. 
It costs one manual Ansible command whenever a brand new app is introduced, 
but it prevents circular dependencies if the cluster ever needs to be rebuilt from scratch.



<h3 class="subheading">Idempotency</h3>
Nearly every install task follows the same pattern: check for existing state, then act only if it's missing.

<div class="infostack">
<h4>Example: k3s server bootstrap</h4>
<pre><code style="font-size: 14px; line-height: 1.3;">- name: Check if k3s is already installed
  stat:
    path: /usr/local/bin/k3s
  register: k3s_installed

- name: Install k3s server
  shell: curl -sfL https://get.k3s.io | sh -
  when: not k3s_installed.stat.exists

</code></pre>
</div>

The worker join is the same idea from the other side: <code>k3s_agent.yml</code> 
looks up the control plane's hostname and node token directly from Ansible's own inventory facts (<code>hostvars</code>), 
so there's no token to copy/paste by hand. The token is read from the machine that generated it during the same play.

<h3 class="subheading">Credentials</h3>
The deployment process currently relies on two credential types.

<div class="infostack">
<h4>GitHub PAT</h4>
<ul>
<li>Registering repositories with Argo CD (<code>argocd.yml</code>)</li>
<li>The <b>same</b> credential is reused by Argo CD Image Updater for git write-back. 
When a new image is detected, Image Updater commits the updated tag using this identity</li>
</ul>
<h4>GHCR registry secret</h4>
<ul>
  
<li>Rendered once from a Jinja2 template <code>dockerconfig.json.j2</code> and applied as a <code>kubernetes.io/dockerconfigjson</code> secret in both the <code>argocd</code> namespace
 (so Image Updater can check tags) and the <code>apps</code> namespace (so pods can actually pull the images)</li>
<li>Explicitly <i>not</i> the same credential path as git write-back, the registry secret only grants read access to image tags, 
never repo write access</li>
</ul>
</div>

All of this is pulled from <code>vars/secrets.yml</code>, kept out of the rest of the playbook and only loaded by the plays that need it.

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
