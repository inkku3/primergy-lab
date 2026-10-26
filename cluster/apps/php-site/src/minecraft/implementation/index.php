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
This is a PaperMC Minecraft server running on my self-hosted Kubernetes cluster. 
Everything is deployed from manifests in Git, and ArgoCD keeps the cluster in sync with them.

It was a good excuse to work through persistent storage, secrets, networking and ingress on a real workload in my homelab.

I built it for a small private server, with at most 10 players at a time on a single-node cluster, and that shaped a few choices. 
I used a single-replica StatefulSet instead of a game server orchestration platform, 
and exposed the server through a LoadBalancer Service instead of putting a proxy in front of it.

<div class="infostack">
<h4>Architecture</h4>
The setup consists of:
<ul>
<li>A StatefulSet for the PaperMC server, giving it a stable identity and persistent storage</li>
<li>A PersistentVolumeClaim for world and plugin data</li>
<li>A LoadBalancer Service for Minecraft and RCON</li>
<li>A Traefik Ingress for the SquareMap web interface</li>
<li>A Cloudflare Tunnel that publishes SquareMap on its own subdomain</li>
<li>Kubernetes Secrets for the RCON credentials and the DiscordSRV bot token</li>
<li>The <a href="https://github.com/itzg/docker-minecraft-server"><code>itzg/minecraft-server</code></a> container image, which runs PaperMC</li>
</ul>
</div>
<br>
<h3 class="subheading">Deployment</h3>
The server is managed with GitOps.

All infrastructure and application config lives in Git. 
When I push a change, ArgoCD applies it to the cluster, so I never have to deploy anything by hand.

Most settings are controlled through the manifests and environment variables, so changing the server config just means editing a file and committing it.

<h4 class="subheading">Storage</h4>
A Minecraft server keeps a lot of state, so it needs persistent storage.

The server runs as a StatefulSet with a PersistentVolumeClaim, so the world, player data and plugin config survive pod restarts and upgrades.

The pod can be deleted and recreated without losing anything, because the data lives separately from the application config.

<h4 class="subheading">Networking</h4>
Two things are exposed:<br>
<br>
<b>Minecraft Server</b>
<ul>
<li>Runs behind a LoadBalancer Service provided by k3s ServiceLB</li>
<li>Accepts TCP connections from Minecraft clients</li>
<li>My router forwards the external port to the LoadBalancer Service</li>
<li>RCON is only available locally</li>
<li>DiscordSRV connects the server to Discord, which I use for remote administration</li>
</ul>
The server listens on a non-default port to cut down on automated scans and log spam. 
A DNS SRV record lets players connect with just the hostname, without typing the port.
<br><br>
<b>SquareMap</b>
<ul>
<li>Published through its own Traefik Ingress</li>
<li>Available on its own subdomain</li>
<li>Exposed to the internet through a Cloudflare Tunnel</li>
</ul>

<h4 class="subheading">Security</h4>
The RCON credentials and the DiscordSRV bot token are stored as Kubernetes Secrets, so they never end up in the Git repo.

DiscordSRV generates and manages its own config file, so mounting a Secret over it would break that. 
Instead, an initContainer writes just the bot token into the generated config at startup. 
The plugin can still manage its own config, and the token stays out of version control.
<br><br>
SquareMap goes through a Cloudflare Tunnel, so it is never directly exposed to the internet. 
The Minecraft game port is the only thing open to the public.

<h3 class="subheading">Design Decisions</h3>
The two services have different needs, so I exposed them differently. 
Minecraft needs a raw TCP connection, so the game server sits behind a router port forward pointing at a LoadBalancer Service. 
On a single-node k3s cluster, the built-in ServiceLB handles this fine, so I didn't need MetalLB or anything else.
<br><br>
HTTP services like SquareMap go through Traefik and a Cloudflare Tunnel instead. That gives me normal HTTP routing without opening a port to the internet.
<br><br>
I also had to decide what belongs in Git and what doesn't. The initial player whitelist comes from a Git-managed Secret, which gives me a known starting point if I ever have to rebuild from scratch. 
After that, whitelist changes are made through DiscordSRV or RCON, and they persist across pod restarts instead of being overwritten when Git syncs.
<br><br>
<h4>Source code on <a href="https://github.com/inkku3/primergy-lab/">GitHub</a>.</h4>

</div>
</div>
</div>
</div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/github-dark.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>

<script>hljs.highlightAll();</script>

<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>

