const fs = require('fs');

const imagesDirectory = './images';
const outputFilePath = './index.html';

fs.readdir(imagesDirectory, (err, files) => {
    if (err) {
        console.error('Error reading the images directory:', err);
        return;
    }

    const imageFiles = files.filter(file => /\.(jpg|jpeg|png|gif)$/i.test(file));

    const htmlContent = `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Image Gallery</title>
</head>
<body>
    <div id="gallery">
${imageFiles.map((file, index) => `        <img src="${imagesDirectory}/${file}" alt="${file}">`).join('\n')}
    </div>
    <script src="/test.js"></script>
</body>
</html>
`.trim(); // Trim any leading or trailing whitespace

    fs.writeFile(outputFilePath, htmlContent, err => {
        if (err) {
            console.error('Error writing to index.html:', err);
        } else {
            console.log('index.html generated successfully.');
        }
    });
});