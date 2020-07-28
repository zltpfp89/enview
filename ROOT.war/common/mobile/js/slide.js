try {
var slideImage=document.getElementById("slideImg");
var slideprev=document.getElementById("slideprev");
var slidenext=document.getElementById("slidenext");

var slideArray=  [
"sample01.jpg",
"sample02.jpg",
"sample03.jpg",
"sample04.jpg",
"sample05.jpg",
"sample06.jpg",
"sample07.jpg",
"sample08.jpg"
];
baseURL = "images";
var slideIndextotal = slideArray.length;
var slideIndex = 1;
var slideImagetotal=document.getElementById("total");
var slideImagepage=document.getElementById("page");
slideImagetotal.innerHTML = slideArray.length;
slideImagepage.innerHTML = slideIndex;
} catch (e) {console.log(e)}
function slideshow( slide ) {
	slideIndex++;
	if (slideIndex > slideIndextotal){ 
		slideIndex = 1 ;
	} 
	if (slideIndex == 0){
		slideIndex = slideIndextotal ; 
	} 
	slideImage.src = baseURL + '/' + slideArray[slideIndex - 1];
	
	slideImagepage.innerHTML = slideIndex;
}
