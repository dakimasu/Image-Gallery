document.addEventListener('DOMContentLoaded', function () {
    const images = document.querySelectorAll('#gallery img');

    images.forEach((image) => {
        image.addEventListener('click', function () {

            const newURL = image.getAttribute('src');

            window.location.href = newURL;
        });
    });
});