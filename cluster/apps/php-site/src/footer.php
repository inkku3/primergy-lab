<div id="bottom-header">
    minimal HTML website served from a Debian 12 server via Nginx
  </div>
</div>
<script>
function toggleMenu() {
    var nav = document.getElementById("myNav");
    var menuIcon = document.querySelector('.menu-icon');
    
    if (nav.classList.contains('open')) {
        nav.classList.remove('open');
        menuIcon.classList.remove('change');
        
        document.querySelectorAll('.overlay-content .dropdown-content.open').forEach(function(dropdown) {
            dropdown.classList.remove('open');
        });
    } else {
        nav.classList.add('open');
        menuIcon.classList.add('change');
    }
}

function toggleMobileDropdown(button) {
    var dropdownContent = button.nextElementSibling;
    
    if (dropdownContent.classList.contains('open')) {
        dropdownContent.classList.remove('open');
    } else {
        dropdownContent.classList.add('open');
    }
}

document.addEventListener('DOMContentLoaded', function() {
    var desktopDropdowns = document.querySelectorAll('#links-container .dropdown');
    desktopDropdowns.forEach(function(dropdown) {
        dropdown.addEventListener('mouseenter', function() {
            this.querySelector('.dropdown-content').style.display = 'block';
        });
        dropdown.addEventListener('mouseleave', function() {
            this.querySelector('.dropdown-content').style.display = '';
        });
    });
});
</script>
<script src="/app.js"></script>
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
<!-- Matomo Tag Manager -->
<script>
  var _mtm = window._mtm = window._mtm || [];
  _mtm.push({'mtm.startTime': (new Date().getTime()), 'event': 'mtm.Start'});
  (function() {
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.async=true; g.src='https://matomo.inkku.xyz/js/container_oBTD3IM1.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<!-- End Matomo Tag Manager -->
</body>
</html>