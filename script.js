//Slider

let slideIndex = 1;
showSlides(slideIndex);

//Affiche slide suivante
function plusSlides(n) {
  showSlides(slideIndex += n);
}

//Affiche slide courrante
function currentSlide(n) {
  showSlides(slideIndex = n);
}

//Affiche slide n
function showSlides(n) {
  let i;
  //Recuperation des slides et boutons dot
  let slides = document.getElementsByClassName("slide");
  let dots = document.getElementsByClassName("dot");
    
  //Retour au début ou fin (éviter erreur de NPE)
  if (slideIndex > slides.length) {slideIndex = 1}
  if (slideIndex < 1) {slideIndex = slides.length}

  //Changement de slide lors du click
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";

};


//Bouton switch mode

function toggleDarkMode() { 
  //Recuperation des variables et du thème dans css
  const container = document.body;
  const buttonDarkMode = document.getElementById('toggleDarkMode');
  const dataTheme = container.getAttribute('data-theme');
 
  //Si theme == dark alors switch sur light et inversement
  if(dataTheme === 'dark') {
    container.setAttribute('data-theme', 'light');
  } else {
    container.setAttribute('data-theme', 'dark');
  }
  
 }

 
 





