function attachImageClickEvent() {
    const images = document.querySelectorAll('#imageContainer img');

    images.forEach((image) => {
        image.addEventListener('click', function () {
            const newURL = image.getAttribute('src');
            console.log('Clicked image URL:', newURL);

            window.location.href = newURL;
        });
    });
}