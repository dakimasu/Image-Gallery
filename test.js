document.addEventListener('DOMContentLoaded', function () {
    const images = document.querySelectorAll('#gallery img');

    images.forEach((image) => {
        image.addEventListener('click', function () {
            // Assuming the image has a unique filename
            const imageName = image.getAttribute('src').split('/').pop();

            // Construct the new URL
            const newURL = window.location.origin + '/images/' + imageName;

            // Navigate to the new URL
            window.location.href = newURL;
        });
    });
});
