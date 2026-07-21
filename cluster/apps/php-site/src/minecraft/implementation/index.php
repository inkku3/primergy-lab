<?php
$pageTitle = "inkku - minecraft implementation";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>
code {
    font-size: 0.8em;          
}
p {
    font-size: 1em;          
 
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/base16/atelier-heath.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>
<div id="main-container">
<div id="content">
<div class="main-header-box">
</div>
<div class="site-content-box">
<h3 class="subheading">Server info</h3>

<p>
<br>
Server is accessed with a SRV record at Cloudflare with it's own subdomain, obscuring the direct server IP somewhat.
<div class="infostack">
<a href="https://papermc.io/">PaperMC</a> - running inside a Docker container<br>
<a href="https://github.com/plan-player-analytics/Plan">Plan server plugin</a> - for the Minecraft statistics site <br>
<a href="https://mcstatus.io/docs">mcstatus API</a> - used to fetch current online players on the server page<br><br>
</div>
The Minecraft server’s stats site is powered by the Plan plugin’s external webserver, 
hosted via an nginx reverse proxy. You can view some stats as a visitor by using 'other' for both login fields. 
<br><br><br>
<h3 class="subheading">Dockerization</h3>

A minecraft server is a noticeable security vulnerability. With the SRV record, direct IP and port are exposed via DNS queries. 
To minimize the risk of running a public game server, the application layer must be hardened.
<br><br>

In order to boost security, I wanted to move the server into a Docker container.<br>
Even better: run the Docker container on its own user with limited permissions, sort of like the www-data user does for web servers on Linux. 
<br><br>
There is a lovely ready to run script for Linux machines for this exact purpose <a href="https://github.com/Phyremaster/papermc-docker">here</a> which at the time of writing this had a small issue with the PaperMC API: the endpoint had been retired and hadn't yet been updated in the docker script. Fortunately, a <a href="https://github.com/ThijmenGThN/papermc">fork</a> already existed which fixes the issue with the deprecated API calls.
<br><br>
The implementation is simple, a dedicated system user with permissions to only /opt/minecraft hosts the docker container. The user itself is not added into the docker group. The docker filesystem is therefore isolated from the host system. A simple Docker flag 
<pre><code>--user $(id -u USER):$(id -g USER) 
</pre></code>
with the provided image does the job.
<br><br>
With a proper ufw setup and a router firewall alongside a whitelisted server, the setup is as good as it gets for a self-hosted server. A non-standard port was chosen, which is mapped to the standard minecraft 25565 with Docker.
<br><br>
This of course is slightly mitigated with the multitude of unverified plugins running on the server, to avoid things being too perfect. With this setup there is at least proper damage control in place. 
<br><br>
Previously, openJDK was running the Minecraft server from the server machine's home directory. 
With this setup, there is no need to have Java installed on the host system, and security is wildly improved as the Java runtime is isolated in the container.
</p>
</div>
</div>
<script>hljs.highlightAll();</script>

<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>

