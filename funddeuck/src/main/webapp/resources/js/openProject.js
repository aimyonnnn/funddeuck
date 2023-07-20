// Select all elements with the class "card"
const cards = document.querySelectorAll(".card");

// Initialize the current index and the number of projects per slide
let currentIndex = 0;
const projectsPerSlide = 5;

// Function to show projects based on the current index
function showProjects() {
  console.log("3");	
  for (let i = 0; i < cards.length; i++) {
    if (i >= currentIndex && i < currentIndex + projectsPerSlide) {
      cards[i].style.display = "block";
    } else {
      cards[i].style.display = "none";
    }
  }
}

// Function to handle the "Previous" button click
function handlePrevClick() {
  console.log("4");
  if (currentIndex > 0) {
    currentIndex -= projectsPerSlide;
    if (currentIndex < 0) {
      currentIndex = 0;
    }
    showProjects();
  }
}

// Function to handle the "Next" button click
function handleNextClick() {
  console.log("5");
  if (currentIndex < cards.length - projectsPerSlide) {
    currentIndex += projectsPerSlide;
    showProjects();
  }
}

// Add event listeners to "Previous" and "Next" buttons
document.addEventListener("DOMContentLoaded", function () {
  const prevBtn = document.getElementById("prev-btn");
  const nextBtn = document.getElementById("next-btn");

  prevBtn.addEventListener("click", handlePrevClick);
  nextBtn.addEventListener("click", handleNextClick);

  // Initially show the first set of projects.
  showProjects();
});
