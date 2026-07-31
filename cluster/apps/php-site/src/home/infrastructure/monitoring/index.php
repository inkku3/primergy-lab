<?php
$pageTitle = "inkku - monitoring & observability";
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
    <a href="/infrastructure/networking" class="sidebar-link">Networking</a>
    <a href="/infrastructure/monitoring" class="sidebar-link active">Monitoring & Observability</a>
</nav>

<div id="lb-back">
    <div id="lb-img"></div>
</div>

<div id="main-container">
<div id="content">
<div class="main-header-box">
Monitoring & Observability
</div>
<div class="site-content-box">
<h3 class="subheading">Summary</h3>
The observability platform provides full cluster visibility, metric collection, and alerting using the standard community 
<code>kube-prometheus-stack</code> Helm release managed entirely via GitOps.

Rather than clicking dashboards together manually in a web UI that wouldn't survive a cluster rebuild, the entire monitoring setup including metrics storage, 
scrape targets, alerting rules, and Grafana dashboard definitions is declared in version control and reconciled automatically by ArgoCD.

<div class="infostack">
<h4>Key Objectives:</h4>
<ul>
<li><b>Declarative Configuration:</b> Provision the entire observability stack as code, making dashboards and alerting rules fully reviewable and reproducible.</li>
<li><b>Resource Safeguards:</b> Strict metrics retention bounds to prevent time-series database growth from overwhelming the host's 120GB SSD storage constraint.</li>
<li><b>Workload Isolation:</b> Eliminate disk I/O contention between heavy time-series writes and dashboard database operations on shared hardware.</li>
<li><b>GitOps-Native Deployment:</b> Handle helm chart multi-source references and CRD size limits cleanly within ArgoCD.</li>
</ul>
</div>

<h3 class="subheading">Stack Architecture</h3>
The stack combines metrics harvesting, time-series storage, alert evaluation, and visualization into a unified deployment.

<table>
  <tr>
    <th>Component</th>
    <th>Role</th>
    <th>Deployment Method</th>
  </tr>
  <tr>
    <td><b>Prometheus</b></td>
    <td>Metrics scraper and time-series database (TSDB)</td>
    <td>Helm (<code>kube-prometheus-stack</code>)</td>
  </tr>
  <tr>
    <td><b>Grafana</b></td>
    <td>Metrics visualization and dashboard frontend</td>
    <td>Helm + Sidecar ConfigMaps</td>
  </tr>
  <tr>
    <td><b>Alertmanager</b></td>
    <td>Alert routing, deduplication, and silencing</td>
    <td>Helm (<code>kube-prometheus-stack</code>)</td>
  </tr>
  <tr>
    <td><b>node-exporter</b></td>
    <td>OS and hardware-level host metrics (CPU, RAM, disk I/O)</td>
    <td>DaemonSet via Helm</td>
  </tr>
  <tr>
    <td><b>kube-state-metrics</b></td>
    <td>Listens to the K8s API server and generates object state metrics</td>
    <td>Deployment via Helm</td>
  </tr>
</table>

<h3 class="subheading">GitOps & Dashboards as Code</h3>

<h4>Dashboards in version control</h4>
To prevent dashboards from becoming unbacked state trapped inside Grafana's internal database, dashboard definitions are stored as JSON files directly in Git. 
<br><br>
These JSON files are rendered as Kubernetes <code>ConfigMap</code> resources labeled for Grafana's sidecar container. 
The sidecar watches for tagged ConfigMaps and automatically mounts them into Grafana live, keeping dashboard management entirely within the standard Git workflow.

<h4>Bounded Retention Strategy</h4>
On a hardware setup with storage constraints, time-based metric retention alone is a liability. 
A sudden spike in pod churn or scrape targets can fill the disk before the time window expires. Prometheus retention is explicitly dual-bounded:
<ul>
  <li><b>Time-based limit:</b> <code>15d</code> retention window.</li>
  <li><b>Size-based cap:</b> <code>retentionSize: 8GB</code> hard ceiling.</li>
</ul>
Enforcing an absolute size cap ensures that unexpected scrape volume never silently consumes worker node disk space.

<div class="infostack">
<h4>Multi-Source ArgoCD Pattern</h4>
The monitoring stack uses ArgoCD's multi-source Application feature. A single Application object combines:
<ol>
  <li>The remote community <code>kube-prometheus-stack</code> Helm chart repository.</li>
  <li>Git-managed <code>values.yaml</code> overrides for local configuration.</li>
  <li>Plain Git manifests for supplementary resources (ConfigMaps, extra RBAC).</li>
</ol>
This keeps the deployment under a single lifecycle status, health check, and rollback target.
</div>

<h3 class="subheading">Future Improvements</h3>
<ul>
  <li><b>ServiceMonitors for Applications:</b> Extend scrape coverage to application-level metrics by adding <code>ServiceMonitor</code> 
  CRDs for Traefik ingress and Matomo's PHP-FPM exporter.</li>
  <li><b>Alertmanager Webhooks:</b> Integrate Alertmanager with a Discord webhook channel to push critical cluster alerts automatically without manual 
  Grafana inspection.</li>
  <li><b>External DB for Grafana:</b> Migrate Grafana's persistent store from local SQLite to the existing MariaDB instance if disk contention 
  emerges during future scaling.</li>
</ul>

<h4>Source Code on GitHub</h4>
<b><a href="https://github.com/inkku3/primergy-lab/tree/main">Current Infrastructure Repository</a></b><br>

</div>
</div>

<script>
// Image zooming script
var zoomImg = function() {
    var clone = this.cloneNode();
    clone.classList.remove("zoomD");
    var lb = document.getElementById("lb-img");
    lb.innerHTML = "";
    lb.appendChild(clone);
    var lbBack = document.getElementById("lb-back");
    lbBack.classList.add("show");
};

window.addEventListener("load", function() {
    var images = document.getElementsByClassName("zoomD");
    if (images.length > 0) {
      for (var img of images) {
        img.addEventListener("click", zoomImg);
      }
    }
    document.getElementById("lb-back").addEventListener("click", function() {
      this.classList.remove("show");
    });
});
</script>

<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>