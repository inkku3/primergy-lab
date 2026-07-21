<?php
$pageTitle = "inkku - portfolio";
?>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/header.php'; ?>
<div id="content">
<div class="thumbnail-container">
<h3>Portfolio</h3>
<br>
<div id="thumbnails">
<img class="thumbnail" src="/projects/portfolio/img/digital/cree.png" id="mccree">
<img class="thumbnail" src="/projects/portfolio/img/digital/KAKYOIN1.png" id="kakyoin">
<img class="thumbnail" src="/projects/portfolio/img/digital/SHIZA.png" id="caesar">
<img class="thumbnail" src="/projects/portfolio/img/digital/rohan.png" id="rohan">
<img class="thumbnail" src="/projects/portfolio/img/digital/amklds.png" id="cigar">
<img class="thumbnail" src="/projects/portfolio/img/digital/feel.png" id="cigarette">
<img class="thumbnail" src="/projects/portfolio/img/digital/leafeon.png" id="leafeon">
<img class="thumbnail" src="/projects/portfolio/img/digital/vapoo.png" id="vaporeon">
</div>
<div class="site-content-box">
<br>
Before starting my current studies I was a hobbyist digital artist. Best examples of my work are showcased here. Some of my other work has been published and monetized under an alias elsewhere.<br> <br>All artwork displayed here is my original work. It is not to be copied, reproduced, or distributed in any form without my explicit permission. Unauthorized use is strictly prohibited.
</div>

</div>

</div>

<div id="gallery" class="gallery">
<div class="gallery-inside" id="ginside">
<img class="gallery-img" id="img1">
<span class="gallery-nav">X</span>
<div class="gallery-text" id="gallery-text">
Gallery text not available...
</div>
</div>
</div>


<script>

var gallery = document.getElementById("gallery");
var modalImg = document.getElementById("img1");

var captionText = document.getElementById("gallery-text");

const textHQ = {};

fetch("/projects/portfolio/img/digital/imagetext.txt")
.then(response => response.text())
.then(data => {
  const line = data.split("\n");
  line.forEach(line => {
    const [id, contents] = line.split("|")
    textHQ[id] = contents;
  })

  console.log("File contents:", data);
  captionText.innerHTML = data;
})
.catch(error => {
  console.error("Failed to load text file:", error);
});


var closeBtn = document.getElementsByClassName("gallery-nav")[0];
  var ingallery = document.getElementById("ginside");
  var menuIcon = document.querySelector('.menu-icon');

  var thumbnails = document.getElementsByClassName("thumbnail");
  for (let i = 0; i < thumbnails.length; i++) {
    thumbnails[i].onclick = function() {
      gallery.style.display = "block";
      modalImg.src = this.src;
      const imgID = this.id;
      captionText.innerHTML = textHQ[imgID];

      menuIcon.style.display = "none";
    }
  }

  closeBtn.onclick = function() {
    gallery.style.display = "none";
    if (window.innerWidth <= 768) {
        menuIcon.style.display = "block";
        }
  }

  window.onclick = function(event) {
    if (event.target === ginside) {
      gallery.style.display = "none";
        if (window.innerWidth <= 768) {
            menuIcon.style.display = "block";
         }
    }
  }

  window.onkeydown = function(){
    gallery.style.display = "none";
    if (window.innerWidth <= 768) {
        menuIcon.style.display = "block";
    }
  }
</script>
<?php include dirname($_SERVER['DOCUMENT_ROOT']) . '/footer.php'; ?>

