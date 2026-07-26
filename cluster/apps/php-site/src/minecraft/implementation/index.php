<?php
$pageTitle = "inkku - minecraft implementation";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>

<div id="main-container">
<div id="content">
<div class="main-header-box">
  Minecraft server implementation
</div>
<div class="site-content-box">
<h3 class="subheading">Summary</h3>
This project demonstrates operating a stateful application on my self-hosted Kubernetes cluster using GitOps principles. 
The server runs PaperMC and is deployed entirely from declarative Kubernetes manifests stored in Git and synchronised automatically by ArgoCD.

The project showcases persistent storage management, secret handling, networking, ingress configuration, 
and deployment automation within a production-like homelab environment.

Scoped for a small private server (≤10 concurrent players, single node), 
which informed decisions to avoid unnecessary complexity, e.g. a single-replica StatefulSet rather 
than a multi-node game server orchestration layer, and NodePort/LoadBalancer exposure rather than a dedicated ingress-adjacent proxy.

<div class="infostack">
<h4>Architecture</h4>
The deployment consists of:
<ul>
<li>Kubernetes StatefulSet for the PaperMC server</li>
<li>PersistentVolumeClaim for world and plugin data</li>
<li>LoadBalancer Service exposing Minecraft and RCON</li>
<li>Dedicated Traefik Ingress exposing the SquareMap web interface</li>
<li>Cloudflare Tunnel publishing the live map on its own subdomain</li>
<li>Kubernetes Secrets for sensitive configuration</li>
<li>PaperMC running from the <a href="https://github.com/itzg/docker-minecraft-server"><code>itzg/minecraft-server</code></a> container image</li>
</ul>
</div>
<br>
<h3 class="subheading">Deployment</h3>
The server is managed through GitOps.

Infrastructure and application configuration are version-controlled in Git. 
When changes are committed, ArgoCD automatically reconciles the cluster state, ensuring deployments remain consistent without manual intervention.

Configuration is managed primarily through Kubernetes manifests and environment variables, allowing server settings to be modified declaratively.

<h4 class="subheading">Storage</h4>
Minecraft is a stateful application, making persistent storage essential.

The server is deployed as a Kubernetes StatefulSet with a PersistentVolumeClaim, ensuring that world data, 
player information and plugin configuration survive pod restarts and upgrades.

This separates application configuration from persistent data while allowing the workload to be recreated without data loss.

<h4 class="subheading">Networking</h4>
The deployment exposes two separate services:<br>
<br>
<b>Minecraft Server</b>
<ul>
<li>Kubernetes LoadBalancer Service</li>
<li>TCP connectivity for Minecraft clients</li>
<li>RCON available for local administration</li>
<li>DiscordSRV for remote administration</li>
</ul>
<b>SquareMap</b>
<ul>
<li>Published through a dedicated Traefik Ingress</li>
<li>Accessible via its own subdomain</li>
<li>Exposed externally using a Cloudflare Tunnel</li>
</ul>

<h4 class="subheading">Security</h4>
Sensitive values, including the DiscordSRV bot token and RCON credentials, are stored as Kubernetes Secrets rather than in version-controlled manifests.

The SquareMap web interface is published through Cloudflare Tunnel, avoiding direct exposure of the web service to the internet.

<h3 class="subheading">Design Decisions</h3>
Several implementation choices were made based on the requirements of the Minecraft protocol rather than forcing every service through the same architecture.

Because Minecraft requires direct TCP connectivity, the game server is exposed through a dedicated router port forward to a Kubernetes LoadBalancer Service. 
<br><br>In contrast, HTTP services such as SquareMap are published through Traefik and Cloudflare Tunnel.

The server also listens on a non-default port to reduce unsolicited connection attempts, 
with DNS SRV records providing a transparent connection experience for players.

Future improvements include backups.
<h4>Source code on <a href="https://github.com/inkku3/primergy-lab/">GitHub</a>.</h4>

</div>
</div>
</div>
</div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/github-dark.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>

<script>hljs.highlightAll();</script>

<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>

