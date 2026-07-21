<?php
$pageTitle = "inkku - minecraft";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>
<div id="main-container">
  <div id="content">
  <div class="mcbox">MINECRAFT SURVIVAL SERVER</div>
<div class="site-content-box">
<p>This address also functions as a Minecraft server. It is running PaperMC on Minecraft version 1.21.4. Maximum players allowed is currently 5, whitelist only.</p>
<p>A separate statistics site can be found via the site menu, that is for administration purposes only.</p>
<div class="server-container">
<div class="header-box">minecraft.inkku.xyz</div>
<button class="copy-ip-button">Copy IP</button>
<div id="copiedMessage" class="copied-message">IP copied!</div>
<div class="playercounter">Players Online: <span id="playerCount">Loading...</span></div></div></div>

</div>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>
<!--
  <script src='https://cdn.jsdelivr.net/npm/@widgetbot/crate@3' async defer>
    new Crate({
        server: '1166450961456308314', // Minecraft Inkku XYZ
        channel: '1358849137675866324' // #mcserver
    })
</script> -->
<!-- using mcstatus.io API fetch the current playercount -->
<script>
    async function fetchMCdata() {
        try {
            const response = await fetch('https://api.mcstatus.io/v2/status/java/minecraft.inkku.xyz'); 
            const data = await response.json();

            if (data.online) {
                document.getElementById('playerCount').textContent = data.players.online;
            } else {
                document.getElementById('playerCount').textContent = "Server offline.";
            }
        } catch (error) {
            console.error('Error fetching player count from mcstatus.io!', error);
            document.getElementById('playerCount').textContent = "Error fetching server data.";
        }
    }
    fetchMCdata();
</script>
<script>
document.querySelector('.copy-ip-button').addEventListener('click', copyIP);

function copyIP() {
    const ipAddress = "minecraft.inkku.xyz";
    navigator.clipboard.writeText(ipAddress).then(() => {
        const copiedMessage = document.getElementById("copiedMessage");
        
        copiedMessage.style.display = "block";
        void copiedMessage.offsetWidth; 
        copiedMessage.style.opacity = "1";

        setTimeout(() => {
            copiedMessage.style.opacity = "0";
            setTimeout(() => {
                copiedMessage.style.display = "none";
            }, 300); 
        }, 1000);
    }).catch((error) => {
        console.error("Copy failed:", error);
        alert("Failed to copy IP. Please copy manually.");
    });
}
</script>
<script>
  var _paq = window._paq = window._paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//matomo.inkku.xyz/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '1']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<script>
  var _paq = window._paq = window._paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//matomo.inkku.xyz/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '1']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
