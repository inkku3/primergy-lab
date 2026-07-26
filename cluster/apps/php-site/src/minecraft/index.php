<?php
$pageTitle = "inkku - minecraft";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>
<div id="main-container">
  <div id="content">
  <div class="mcbox">MINECRAFT SURVIVAL SERVER</div>
<div class="site-content-box" style="text-align: center;">
<p>The address <b><code>mc.inkku.xyz</code></b> functions as a Minecraft server running PaperMC 26.1.2.
<br>Maximum players allowed is currently 10, whitelist only.<br><br>
Detailed implementation details <b><a href="https://minecraft.inkku.xyz/implementation/">here.</a></b></p>
<div class="server-container">
<div class="header-box">mc.inkku.xyz</div>
<button class="copy-ip-button">Copy IP</button>
<div id="copiedMessage" class="copied-message">IP copied!</div>

</div></div></div>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>

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

