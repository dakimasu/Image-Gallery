function checkPassword() {
    var password = document.getElementById("password").value;

    // Replace "your_password" with your actual password
    if (password === "your_password") {
        document.getElementById("password-overlay").style.display = "none";
        loadGallery();
    } else {
        alert("Incorrect password. Please try again.");
        document.getElementById("password").value = "";
    }
}

function loadGallery() {
    // Code to dynamically add images to the gallery
    var gallery = document.getElementById("gallery");
    gallery.style.display = "grid";

    // Replace the following with your actual image URLs
    var imageUrls = ["image1.jpg", "image2.jpg", "image3.jpg"];

    imageUrls.forEach(function (url) {
        var img = document.createElement("img");
        img.src = url;
        gallery.appendChild(img);
    });
}