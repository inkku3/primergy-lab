<div id="bottom-header">
    minimal HTML website served to you via PHP
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
</body>
</html>
