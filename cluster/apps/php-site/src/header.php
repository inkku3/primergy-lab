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

<style>
    a {
        color: #cf3c17; 
        text-decoration: none;
        transition: color 0.1s ease-in-out;
    }

    a:hover {
        color: #eb742f; 
        text-decoration: none; 
    }
    /* mobile nav */
    .menu-icon {
        display: none; 
        position: absolute;
        top: 20px;
        right: 20px;
        z-index: 1000;
        cursor: pointer;
        padding: 10px;
    }
    
    .menu-icon span {
        display: block;
        width: 30px;
        height: 3px;
        background-color: white;
        margin: 6px 0;
        transition: 0.4s;
    }
    
    .overlay-menu {
        height: 0;
        width: 100%;
        position: fixed;
        z-index: 999;
        left: 0;
        top: 0;
        background-color: rgba(0, 0, 0, 0.95);
        overflow-y: hidden;
        transition: height 0.5s ease;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        opacity: 0;
        pointer-events: none;
    }
    
    .overlay-menu.open {
        height: 100%;
        opacity: 1;
        pointer-events: all;
        transition: height 0.5s ease, opacity 0.3s ease;
    }
    
    .overlay-content {
        position: relative;
        width: 100%;
        text-align: center;
        margin-top: 30px;
        display: flex;
        flex-direction: column;
        gap: 20px;
        padding: 0 20px;
    }
    
    .overlay-content .nav-link,
    .overlay-content .dropbtn {
        padding: 15px;
        font-size: 1.5em;
        display: block;
        width: 80%;
        margin: 0 auto;
        background-color: transparent;
        color: white;
        border: none;
        cursor: pointer;
        text-decoration: none;
    }
    
    .overlay-content .dropdown-content {
        position: static;
        background-color: transparent;
        box-shadow: none;
        display: block;
        transform: none;
        left: 0;
        margin-top: 0;
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.5s ease, margin-top 0.5s ease;
    }
    
    .overlay-content .dropdown-content.open {
        max-height: 200px; 
        margin-top: 10px;
    }
    
    .overlay-content .dropdown-content a {
        font-size: 1.2em;
        padding: 10px;
        color: white;
        text-decoration: none;
        display: block;
        opacity: 0;
        transform: translateY(-10px);
        transition: opacity 0.3s ease, transform 0.3s ease;
        transition-delay: 0s;
    }
    
    .overlay-content .dropdown-content.open a {
        opacity: 1;
        transform: translateY(0);
    }
    
    .overlay-content .dropdown-content.open a:nth-child(1) {
        transition-delay: 0.1s;
    }
    
    .overlay-content .dropdown-content.open a:nth-child(2) {
        transition-delay: 0.2s;
    }

    @media screen and (max-width: 768px) {
        #links-container {
            display: none; 
        }
    
        .menu-icon {
            display: block; 
        }
    
        .menu-icon.change .bar1 {
            transform: rotate(-45deg) translate(-8px, 6px);
        }
    
        .menu-icon.change .bar2 {
            opacity: 0;
        }
    
        .menu-icon.change .bar3 {
            transform: rotate(45deg) translate(-8px, -6px);
        }
    }
    </style>

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
                <a href="https://minecraft.inkku.xyz">Live Map (TBD)</a>


            </div>
        </div>
    <div class="dropdown">
        <button class="dropbtn" onclick="toggleMobileDropdown(this)">Infrastructure</button>
            <div class="dropdown-content">

                <a href="https://minecraft.inkku.xyz">Provisioning</a>
                <a href="https://minecraft.inkku.xyz/implementation/">GitOps</a>
                <a href="https://minecraft.inkku.xyz">Networking</a>
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
                <a href="https://minecraft.inkku.xyz">Live Map (TBD)</a>


            </div>
        </div>
        <div class="dropdown">
        <a href="https://inkku.xyz/infrastructure" class="nav-link"><button class="dropbtn">Infrastructure</button></a>
        <div class="dropdown-content">
                <a href="https://minecraft.inkku.xyz">Provisioning</a>
                <a href="https://minecraft.inkku.xyz/implementation/">GitOps</a>
                <a href="https://minecraft.inkku.xyz">Networking</a>
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

