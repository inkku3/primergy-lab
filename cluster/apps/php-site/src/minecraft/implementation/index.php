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
and deployment automation within a homelab environment.

The deployment is intentionally scoped for a small private server (max 10 concurrent players on a single-node cluster), 
which informed several design decisions. These include using a single-replica StatefulSet rather than a multi-node game server orchestration platform, 
and exposing the game server through a LoadBalancer Service instead of introducing additional proxy layers.

<div class="infostack">
<h4>Architecture</h4>
The deployment consists of:
<ul>
<li>Kubernetes StatefulSet providing stable pod identity and persistent storage for the PaperMC server</li>
<li>PersistentVolumeClaim for world and plugin data</li>
<li>Kubernetes LoadBalancer Service exposing Minecraft and RCON</li>
<li>Traefik Ingress exposing the SquareMap web interface</li>
<li>Cloudflare Tunnel publishing SquareMap on a dedicated subdomainn</li>
<li>Kubernetes Secrets storing sensitive configuration such as RCON credentials and the DiscordSRV bot token</li>
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
<li>Exposed through a Kubernetes LoadBalancer Service provided by k3s ServiceLB</li>
<li>TCP connectivity for Minecraft clients</li>
<li>Router port forwarding directs external traffic to the LoadBalancer Service</li>
<li>RCON available for local administration</li>
<li>DiscordSRV provides integration between the game server and Discord for remote administration</li>
</ul>
To reduce automated scan traffic and log noise, the server listens on a non-default port. 
A DNS SRV record allows players to connect using a standard hostname without specifying the port.
<b>SquareMap</b>
<ul>
<li>Published through a dedicated Traefik Ingress</li>
<li>Accessible via its own subdomain</li>
<li>Exposed externally using a Cloudflare Tunnel</li>
</ul>

<h4 class="subheading">Security</h4>
Sensitive configuration, including RCON credentials and the DiscordSRV bot token, is stored as Kubernetes Secrets rather than in version-controlled manifests.

DiscordSRV manages its own configuration file, so instead of replacing the file with a Secret mount, an 
initContainer injects only the bot token into the plugin's generated configuration during startup. 
This preserves the plugin's ability to manage its own configuration while keeping credentials outside version control.
<br><br>
The SquareMap web interface is published through a Cloudflare Tunnel, preventing direct public exposure of the service. 
Only the Minecraft game port is directly exposed to the internet.

<h3 class="subheading">Design Decisions</h3>
Several implementation choices were driven by the differing requirements of the services being hosted. 
Because Minecraft requires direct TCP connectivity, the game server is exposed through a router port forward to a Kubernetes LoadBalancer Service. 
On this single-node k3s cluster, the built-in ServiceLB provides external connectivity without requiring MetalLB or additional load balancing components.
<br><br>
HTTP services, such as SquareMap, are instead published through Traefik and Cloudflare Tunnel, avoiding direct exposure while benefiting from standard HTTP routing.
<br><br>
The deployment also balances declarative infrastructure with mutable application state. An initial player whitelist is seeded from a Git-managed Secret during 
deployment, providing a reproducible baseline for disaster recovery. Subsequent whitelist changes are performed through DiscordSRV or RCON and are preserved across 
pod restarts rather than being overwritten by Git reconciliation.
<br><br>
Future improvements include automated backups of persistent world data and plugin configuration
<h4>Source code on <a href="https://github.com/inkku3/primergy-lab/">GitHub</a>.</h4>

</div>
</div>
</div>
</div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/github-dark.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>

<script>hljs.highlightAll();</script>

<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>

