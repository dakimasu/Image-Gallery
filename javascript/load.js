// Function to read the file and extract image entries
async function readImageEntries() {
    const response = await fetch('files/images.txt'); // Replace with the correct path to the file on your website
    const fileContent = await response.text();

    // Split the file content into lines
    const lines = fileContent.split('\n');

    // Parse each line to extract src and alt attributes
    const imageEntries = lines.map((line, index) => {
        const match = line.match(/<img src="([^"]+)" alt="([^"]+)">/);
        if (match) {
            return { src: match[1], alt: match[2] || `Image ${index + 1}` };
        }
        return null; // Skip invalid lines
    }).filter(entry => entry !== null);

    return imageEntries;
}

// Function to dynamically load images when user scrolls down
async function loadImagesOnScroll() {
    const container = document.getElementById('imageContainer');
    let imagesLoaded = 0;

    // Read image entries from the file
    const imageEntries = await readImageEntries();

    // Function to load a batch of images
    function loadBatch() {
        const batchSize = 20; // Adjust the batch size as needed
        const end = Math.min(imagesLoaded + batchSize, imageEntries.length);

        for (let i = imagesLoaded; i < end; i++) {
            // Create an <img> element
            const img = document.createElement('img');

            // Set the src and alt attributes based on the image entry
            img.src = imageEntries[i].src;
            img.alt = imageEntries[i].alt;

            // Append the image to the container
            container.appendChild(img);
        }

        imagesLoaded = end;
        attachImageClickEvent();
    }

    // Initial load
    loadBatch();

    // Load more images when user scrolls down
    const imageContainer = document.getElementById('imageContainer');
    imageContainer.addEventListener('scroll', () => {
        const containerHeight = imageContainer.clientHeight;
        const scrollableHeight = imageContainer.scrollHeight;
        const scrollTop = imageContainer.scrollTop;
    
        if (containerHeight + scrollTop >= scrollableHeight) {
            // Your code here to execute when the user has scrolled to the bottom
            loadBatch();
        }
    });
}

// Call the function to load images when the page is loaded
window.onload = loadImagesOnScroll;