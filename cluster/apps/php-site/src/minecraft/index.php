<?php
$pageTitle = "inkku - minecraft";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>
<div id="main-container">
  <div id="content">
  <div class="mcbox">MINECRAFT SURVIVAL SERVER</div>
<div class="site-content-box">
<p>The address <code>mc.inkku.xyz</code> functions as a minecraft server. It is running PaperMC. Maximum players allowed is currently 10, whitelist only.</p>
<div class="server-container">
<div class="header-box">mc.inkku.xyz</div>
<button class="copy-ip-button">Copy IP</button>
<div id="copiedMessage" class="copied-message">IP copied!</div>
<div class="playercounter">Players Online: <span id="playerCount">Loading...</span></div></div></div>

</div>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>

<script>
    async function fetchMCdata() {
        try {
            const response = await fetch('https://api.mcstatus.io/v2/status/java/mc.inkku.xyz');
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
    const ipAddress = "mc.inkku.xyz";
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

