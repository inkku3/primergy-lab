<?php
$pageTitle = "inkku - infrastructure/gitops";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>

<!-- Documentation Sidebar Navigation -->
<nav class="sidebar-nav" id="sidebarNav" aria-label="Infrastructure sections">
    <div class="sidebar-title">Infrastructure Docs</div>
    <a href="/infrastructure/" class="sidebar-link">Overview</a>
    <a href="/infrastructure/terraform" class="sidebar-link">Terraform</a>
    <a href="/infrastructure/ansible" class="sidebar-link">Ansible</a>
    <a href="/infrastructure/gitops" class="sidebar-link active">GitOps pipeline</a>
    <a href="/infrastructure/kubernetes" class="sidebar-link">Kubernetes</a>
    <a href="/infrastructure/networking" class="sidebar-link">Networking</a>
</nav>

  <div id="lb-back">
    <div id="lb-img"></div>
  </div>
<div id="main-container">
<div id="content">
<div class="main-header-box">
  GitOps pipeline
</div>
<div class="site-content-box">

<h3 class="subheading">Summary</h3>
<code>git push</code> is the only way deployments happen here. When code gets pushed, 
GitHub Actions builds the new PHP and nginx images. 
Argo CD's Image Updater spots them in the registry, writes the new tags back to Git, and Argo CD syncs the cluster to match. 
Git stays the absolute source of truth, and the cluster cannot drift from what's in the repo for more than a few minutes.

<h3 class="subheading">The loop</h3>
<img class="zoomD" src="../infrastructure/img/GitOps_final.svg" id="gitops-graph">

<div class="infostack">
<h4>Step by step</h4>
<ol>
<li><b><code>git push</code></b> - push some code to GitHub.</li>
<li><b>GitHub Actions</b> - get triggered, builds the PHP and Nginx images, tags them with the commit SHA, and pushes them into GHCR.</li>
<li><b>Argo CD Image Updater</b> - scans GHCR, sees the fresh tags, and updates the image refs in <code>kustomization.yaml</code>.</li>
<li><b><code>git commit</code></b> - Image Updater automatically commits that YAML tweak back to the repo (as <code>argocd-image-updater</code>). 
      This commit is now our desired state.</li>
<li><b>Argo CD</b> - notices the cluster is out of sync with Git and rolls out the new images to fix it.</li>
</ol>
</div>

Only the first step (git push) is manual.<br>
Image Updater reuses the same GitHub PAT we used to register the repo, meaning the write-back commit belongs to the bot, not a developer.
<br><br>
<h4 class="subheading">Avoiding an infinite loop</h4>
Because step 4 commits right back into the repo, we're basically asking for an infinite loop. 
The bot commits, Actions sees the commit and builds, the bot sees the build and commits... you get the idea. We use two checks to kill that cycle:

<div class="infostack">
<h4>In the GitHub Actions workflow</h4>
<pre><code>on:
  push:
    branches: [main]
    paths-ignore:
      - cluster/apps/php-site/k8s/**
jobs:
  build:
    if: github.actor != 'argocd-image-updater'</code></pre>
</div>

Using <code>paths-ignore</code> stops changes in <code>kustomization.yaml</code> from waking up GitHub Actions at all. 
There is also a <code>github.actor</code> check as a fallback. 

<h3 class="subheading">Example: php-site</h3>
Take <code>php-site</code> for example. It's a PHP-FPM image and an nginx image that have to be deployed as a pair.
 You'll find the manifests in <code>cluster/apps/php-site/k8s/</code> and the Argo CD setup in <code>cluster/argocd/php-site.yaml</code>.

<div class="infostack">
<h4>kustomization.yaml - the file Image Updater edits</h4>
<pre><code>apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - php-deployment.yaml
  - php-service.yaml
  - nginx-deployment.yaml
  - nginx-service.yaml
  - ingress.yaml
images:
  - name: ghcr.io/inkku3/primergy-lab-php
    newTag:
  - name: ghcr.io/inkku3/primergy-lab-nginx
    newTag:</code></pre>
</div>

The two empty <code>newTag</code> fields are the only lines in the entire repository that the bot modifies. 
Because Image Updater bumps both tags in a single commit, PHP and Nginx always roll out together, meaning no version drift.

<h4 class="subheading">Traceability</h4>
Since every single deployment generates a Git commit, the audit trail for production is literally just <code>git log</code>. 
You can easily skim the history and spot the bot's routine image updates versus actual humans tweaking the infrastructure.
<br><br>
In the future there are plans to add ansible lint and terraform fmt to the CI stage.

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
