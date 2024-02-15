document.addEventListener('DOMContentLoaded', function () {
    const images = document.querySelectorAll('#gallery img');

    images.forEach((image) => {
        image.addEventListener('click', function () {

            const imageName = image.getAttribute('src').split('/').pop();

            const currentURL = window.location.href.replace(/\/index\.html$/, '');

            const newURL = currentURL + '/images/' + imageName;

            window.location.href = newURL;
        });
    });
});