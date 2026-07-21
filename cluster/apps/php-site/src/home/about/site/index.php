<?php
$pageTitle = "inkku - site";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>
<div id="main-container">
<div id="content">
<div class="main-header-box">
Site information
</div>
<div class="site-content-box">
<h3 class="subheading">Website</h3>
<div class="infostack">
<a href="https://github.com/VincentGarreau/particles.js/">particles.js</a> - particles you can see on the background <br>
<a href="https://unsplash.com/photos/timelapse-photography-of-vehicle-on-road-ukTd6UiQbLQ">Background</a> - from Unsplash, by traf<br>
<a href="https://nginx.org/">nginx</a> - as a web server and reverse proxy<br>
<a href="https://www.debian.org/">Debian</a> - Linux distro as a headless server<br><br>
</div>
The site is self-hosted, with the expection of Cloudflare TLS. SSL is set up with Certbot on the origin. <br>
This site is in mostly raw HTML and CSS.
A PHP template is in use to simplify the file structure.<br><br>
Requests from outside Finland and Sweden are automatically blocked to prevent bots, crawlers, and abuse.


<br><br>

<h3 class="subheading">Keittokirja</h3>

Utilizes a Firestore database for recipe storage. A script retrieves all recipe names to populate the search. Upon selection, nginx routes recipe requests to a template file. 
Unique recipe ID is extracted from the URL and used to fetch recipe details from Firebase to populate the template. Images are served from local storage. 
<br><br>
The application features a dark mode interface as the default theme and incorporates a landing page animation for enhanced user experience when in said mode. 
<br><br>
<h3 class="subheading">Matomo</h3>
A docker compose deployment of <a href="https://matomo.org/">Matomo</a> using a MariaDB database is in use to collect anonymous analytics. 
It is securely accessible via a cloudflare tunnel via it's own <a href="https://matomo.inkku.xyz/">subdomain.</a><br> <br>I'll be happy to provide visitor credentials if needed.




</div>
</div>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>

