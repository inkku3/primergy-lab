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

It is deployed through Argo CD and managed through GitOps so dashboard definitions, alert rules and configuration is stored in Git.
<div class="infostack">
<h4>Components</h4>
<ul>
<li><b>Prometheus Operator</b> - Manages Prometheus, Alertmanager and monitoring CRDs</li>
<li><b>Prometheus</b> - Metrics collection, storage and alert evaluation</li>
<li><b>Alertmanager</b> - Groups and routes alerts to a Telegram bot</li>
<li><b>Grafana</b> - Dashboards and visualization</li>
<li><b>node-exporter</b> - Host-level metrics for CPU, memory, storage and networking</li>
<li><b>kube-state-metrics</b> - exposes metrics about Kubernetes resources and their state</li>
</ul>
</div>

<h4 class="subheading">Alerting</h4>
Prometheus evaluates the configured alert rules and forwards firing alerts to Alertmanager, which routes notifications to my Telegram bot. 
That means real-time alerts go straight to my phone.<br><br>
This is especially useful considering the small, singular disk that the server is running on.
<br><br>
Prometheus storage is also limited due to this:
<ul>
  <li><b>Time-based limit:</b> <code>15d</code> retention window.</li>
  <li><b>Size-based cap:</b> <code>retentionSize: 8GB</code> hard ceiling.</li>
</ul>
The Prometheus PVC is 10 GiB, leaving some additional room for write-ahead logs and compaction operations.


<h4 class="subheading">External monitoring</h4>
In addition to the internal Prometheus monitoring, I use UptimeRobot to monitor the website and KaatoKänni400 on Azure. 
In the event a fault occurs that takes down internal monitoring I get an email notification via UptimeRobot.
<br><br>
The Azure monitor also serves another purpose. Regular requests keep the frontend active and prevent it from going idle. 
Previously, the backend could go to sleep, resulting in a delay of around a minute before the application became reachable again. 
Keeping the endpoint active avoids that initial delay. UptimeRobot pings it every 2 minutes.


<h3 class="subheading">GitOps & Dashboards as Code</h3>

Grafana dashboards are stored as JSON files in Git rather than 
being created manually through the Grafana web interface.<br><br>

<br><br>
The monitoring stack uses ArgoCD's multi-source Application feature. A single Application object combines:
<ol>
  <li>The remote community <code>kube-prometheus-stack</code> Helm chart repository.</li>
  <li>Git-managed <code>values.yaml</code> overrides for local configuration.</li>
  <li>Additional Kubernetes manifests such as dashboards and ServiceMonitors</li>
</ol>

<h4 class="subheading">Future Improvements</h4>
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