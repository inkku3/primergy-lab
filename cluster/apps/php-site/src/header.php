<?php
$pageTitle = $pageTitle ?? "inkku - place";
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<base href="/">
<link rel="stylesheet" href="styles.css?version=1.1">
<link rel="icon" type="image/x-icon" href="/img/favicon.ico">
<link rel="icon" type="image/png" sizes="16x16" href="/img/favicon-16x16.png">
<link rel="icon" type="image/png" sizes="32x32" href="/img/favicon-32x32.png">
<link rel="apple-touch-icon" sizes="180x180" href="/img/apple-touch-icon.png">
<link rel="manifest" href="/site.webmanifest">
<meta name="theme-color" content="#000000">
<title><?php echo htmlspecialchars($pageTitle); ?></title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Sans:opsz,wght@8..144,400;8..144,700&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
<!-- Matomo -->
<script>
var _paq = window._paq = window._paq || [];
/* tracker methods like "setCustomDimension" should be called before "trackPageView" */
_paq.push(["setDocumentTitle", document.domain + "/" + document.title]);
_paq.push(["setCookieDomain", "*.inkku.xyz"]);
_paq.push(["setDomains", ["*.inkku.xyz"]]);
_paq.push(['trackPageView']);
_paq.push(['enableLinkTracking']);
(function() {
    var u="//track.inkku.xyz/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '2']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
})();
</script>
<noscript><p><img referrerpolicy="no-referrer-when-downgrade" src="//matomo.inkku.xyz/matomo.php?idsite=2&amp;rec=1" style="border:0;" alt="" /></p></noscript>
<!-- End Matomo Code -->

</head>
<body>
<div class="background-image"></div>
<div id="particles-js"></div>

<div class="menu-icon" onclick="toggleMenu()">
    <span class="bar1"></span>
    <span class="bar2"></span>
    <span class="bar3"></span>
</div>

<div id="myNav" class="overlay-menu">
    <span class="close-btn" onclick="toggleMenu()">&times;</span>
    <div class="overlay-content">
        <div class="dropdown">
            <button class="dropbtn" onclick="toggleMobileDropdown(this)">Minecraft</button>            
            <div class="dropdown-content">
                <a href="https://minecraft.inkku.xyz">Server</a>
                <a href="https://minecraft.inkku.xyz/implementation/">Info</a>
                <a href="https://map.inkku.xyz">Live Map</a>


            </div>
        </div>
    <div class="dropdown">
        <button class="dropbtn" onclick="toggleMobileDropdown(this)">Infrastructure</button>
            <div class="dropdown-content">
                <a href="https://inkku.xyz/infrastructure">Overview</a>
                <a href="https://inkku.xyz/infrastructure/terraform">Terraform</a>
                <a href="https://inkku.xyz/infrastructure/ansible">Ansible</a>
                <a href="https://inkku.xyz/infrastructure/gitops">GitOps</a>
                <a href="https://inkku.xyz/infrastructure/kubernetes">Kubernetes</a>
                <a href="https://inkku.xyz/infrastructure/networking">Networking</a>
                <a href="https://inkku.xyz/infrastructure/monitoring">Monitoring</a>

            </div>
        </div>
    
        <a href="https://inkku.xyz/projects">
            <button class="dropbtn"">Projects</button></a>
        <div class="dropdown">
            <button class="dropbtn" onclick="toggleMobileDropdown(this)">About</button>            
            <div class="dropdown-content">
                <a href="https://inkku.xyz/about">Contact</a>
                <a href="https://inkku.xyz/about/site">Site</a>
            </div>
        </div>
    </div>
</div>


<!-- desktop navigation -->
<div id="top-navigation">
    <div id="links-container">
        <div class="dropdown">
            <button class="dropbtn">Minecraft</button>
            <div class="dropdown-content">
                <a href="https://minecraft.inkku.xyz">Server</a>
                <a href="https://minecraft.inkku.xyz/implementation/">Info</a>
                <a href="https://map.inkku.xyz">Live Map</a>


            </div>
        </div>
        <div class="dropdown">
        <a href="https://inkku.xyz/infrastructure" class="nav-link"><button class="dropbtn">Infrastructure</button></a>
        <div class="dropdown-content">
                <a href="https://inkku.xyz/infrastructure">Overview</a>
                <a href="https://inkku.xyz/infrastructure/terraform">Terraform</a>
                <a href="https://inkku.xyz/infrastructure/ansible">Ansible</a>
                <a href="https://inkku.xyz/infrastructure/gitops">GitOps</a>
                <a href="https://inkku.xyz/infrastructure/kubernetes">Kubernetes</a>
                <a href="https://inkku.xyz/infrastructure/networking">Networking</a>
                <a href="https://inkku.xyz/infrastructure/monitoring">Monitoring</a>

            </div>
    </div>
        <a href="https://inkku.xyz/projects" class="nav-link">Projects</a>
        <div class="dropdown">
            <button class="dropbtn">About</button>
            <div class="dropdown-content">
                <a href="https://inkku.xyz/about">Contact</a>
                <a href="https://inkku.xyz/about/site">Site</a>
            </div>
        </div>
    </div>
</div>           

