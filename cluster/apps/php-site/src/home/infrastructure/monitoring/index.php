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
The platform uses the community <code>kube-prometheus-stack</code> Helm chart for metrics collection, visualization and alerting.

The stack is deployed through Argo CD and managed entirely through GitOps. 
Dashboard definitions, retention settings, alert routing and application-specific monitoring resources live 
in Git and are reconciled automatically with the cluster.
<div class="infostack">
<h4>Components</h4>
<ul>
<li><b>Prometheus Operator</b> - Manages Prometheus, Alertmanager and monitoring CRDs</li>
<li><b>Prometheus</b> - Metrics collection, storage and alert evaluation</li>
<li><b>Alertmanager</b> - Groups and routes alerts to Telegram</li>
<li><b>Grafana</b> - Dashboards and visualization</li>
<li><b>node-exporter</b> - Host-level metrics for CPU, memory, storage and networking</li>
<li><b>kube-state-metrics</b> - Metrics derived from Kubernetes object state</li>
</ul>
</div>
Grafana and Prometheus are intentionally only accessible through the 
management network and are not exposed through the public Cloudflare Tunnel.

<h3 class="subheading">Alerting</h3>
Prometheus evaluates the default alert rules shipped with <code>kube-prometheus-stack</code>. 
When an alert fires, it is sent to Alertmanager, which routes notifications to a Telegram chat. That means
real-time alerts on the go straight to my phone.
<h3 class="subheading">GitOps & Dashboards as Code</h3>

<h4>Dashboards in version control</h4>
Grafana dashboards are stored as JSON files in Git rather than 
being created manually through the Grafana web interface.<br><br>
During deployment, dashboard definitions are rendered into Kubernetes ConfigMaps 
labelled for Grafana's sidecar container. The sidecar continuously watches for dashboard ConfigMaps and loads them automatically.

<h4>Storage constraints and retention</h4>
The entire platform runs on a server with a 120 GB SSD, so monitoring storage must be treated carefully.

Prometheus retention is explicitly dual-bounded:
<ul>
  <li><b>Time-based limit:</b> <code>15d</code> retention window.</li>
  <li><b>Size-based cap:</b> <code>retentionSize: 8GB</code> hard ceiling.</li>
</ul>
Enforcing an absolute size cap ensures that unexpected scrape volume never silently consumes worker node disk space.
The Prometheus PVC itself is slightly larger (10 GiB) to leave room for write-ahead logs and compaction operations.

<div class="infostack">
<h4>Multi-Source ArgoCD Pattern</h4>
The monitoring stack uses ArgoCD's multi-source Application feature. A single Application object combines:
<ol>
  <li>The remote community <code>kube-prometheus-stack</code> Helm chart repository.</li>
  <li>Git-managed <code>values.yaml</code> overrides for local configuration.</li>
  <li>Additional Kubernetes manifests such as dashboards and ServiceMonitors</li>
</ol>
</div>

<h3 class="subheading">Future Improvements</h3>
<ul>
  <li><b>ServiceMonitors for Applications:</b> Extend scrape coverage to application-level metrics by adding <code>ServiceMonitor</code> 
  CRDs for Traefik ingress and Matomo's PHP-FPM exporter.</li>
</ul>

<h4>Source Code on GitHub</h4>
<b><a href="https://github.com/inkku3/primergy-lab/">Current Infrastructure Repository</a></b><br>

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