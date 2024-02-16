const readline = require('readline');
// const axios = require('axios');
const fs = require('fs');
// const FormData = require('form-data');
const path = require('path');
require('dotenv').config();

const imageFolderPath = 'images';
const outputFilePath = './index.html';
// const api_token = process.env.API_TOKEN;
// const account_id = process.env.ACCOUNT_ID;

// const apiUrlV1 = `https://api.cloudflare.com/client/v4/accounts/${account_id}/images/v1`;
// const apiUrlV2 = `https://api.cloudflare.com/client/v4/accounts/${account_id}/images/v2`;

const allowedImageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.svg'];

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question('Do you want password functionality? (yes/no): ', (answer) => {
    if (answer.toLowerCase() === 'yes') {
        generateRegularPassword();
        rl.close();
    } else {
        generateRegularPasswordless();
        rl.close();
    }
});

function generateRegularPassword() {

    fs.readdir(imageFolderPath, (_, files) => {

        const imageFiles = files.filter(file => allowedImageExtensions.includes(path.extname(file).toLowerCase()));

        const htmlContent = generateHtmlContent(imageFiles);

        fs.writeFile(outputFilePath, htmlContent, err => {
            if (err) {
                console.error('Error writing to index.html:', err);
            } else {
                console.log('index.html generated successfully.');
            }
        });
    });

    function generateHtmlContent(imageFiles) {
        return `
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="css/password-style.css">
            <title>Image Gallery</title>
        </head>
        <body>
            <script src="javascript/password.js"></script>
            <div id="password-overlay">
                <div id="password-box">
                    <label for="password">Enter Password:</label>
                    <input type="password" id="password" name="password">
                    <button onclick="checkPassword()">Submit</button>
                </div>
            </div>
        
            <div id="gallery" style="display: none;">
${imageFiles.map((file, index) => `              <img src="/images/${file}" alt="${file}">`).join('\n')}
            </div>
            <script src="javascript/click.js"></script>
        </body>
        </html>        
    `.trim();
    }
}

function generateRegularPasswordless() {

    fs.readdir(imageFolderPath, (_, files) => {

        const imageFiles = files.filter(file => allowedImageExtensions.includes(path.extname(file).toLowerCase()));

        const htmlContent = generateHtmlContent(imageFiles);

        fs.writeFile(outputFilePath, htmlContent, err => {
            if (err) {
                console.error('Error writing to index.html:', err);
            } else {
                console.log('index.html generated successfully.');
            }
        });
    });

    function generateHtmlContent(imageFiles) {
        return `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/passwordless-style.css">
        <title>Image Gallery</title>
    </head>
    <body>
        <div id="gallery">
${imageFiles.map((file, index) => `         <img src="/images/${file}" alt="${file}">`).join('\n')}
        </div>
        <script src="javascript/click.js"></script>
    </body>
    </html>
    `.trim();
    }
}

// async function generateCloudflare() {
//     fs.readdir(imageFolderPath, (_, files) => {
//         if (Array.isArray(files)) {
//           files.forEach((file) => {
//             const imagePath = path.join(imageFolderPath, file);
//             const fileExtension = path.extname(file).toLowerCase();
      
//             // Check if the file has an allowed image extension
//             if (allowedImageExtensions.includes(fileExtension)) {
//               const formData = new FormData();
//               formData.append('file', fs.createReadStream(imagePath));
      
//               axios.post(apiUrlV1, formData, {
//                 headers: {
//                   'Authorization': `Bearer ${api_token}`,
//                   ...formData.getHeaders(),
//                 },
//               }).catch(error => {
//                 console.error('Error in Cloudflare Images API request:', error.message);
//               });
//             } else {
//               console.error(`Skipping non-image file: ${imagePath}`);
//             }
//           });
//         }
//       });
  
//     await new Promise(resolve => setTimeout(resolve, 2000));
  
//     const extractVariantLinks = (response) => {
//       const images = response.data.result.images || [];
//       const variantLinks = images.reduce((acc, image) => {
//         if (image.variants && image.variants.length > 0) {
//           acc.push(...image.variants);  // Use spread operator to add all variants to the array
//         } else {
//           console.log('Skipping invalid image:', image);
//         }
//         return acc;
//       }, []);
  
//       return variantLinks;
//     };
  
//     const makeRequest = async () => {
//       try {
//         const response = await axios.get(apiUrlV2, {
//           headers: {
//             'Authorization': `Bearer ${api_token}`,
//             'Content-Type': 'application/json',
//           },
//         });
  
//         const allLinks = extractVariantLinks(response);
  
//         const htmlContent = generateHtmlContent(allLinks);
  
//         fs.writeFile(outputFilePath, htmlContent, (err) => {
//           if (err) {
//             console.error('Error writing to index.html:', err);
//           } else {
//             console.log('index.html generated successfully.');
//           }
//         });
//       } catch (error) {
//         console.error('Error:', error.message);
//       }
//     };
  
//     makeRequest();
  
//     function generateHtmlContent(imageFiles) {
//       return `
//         <!DOCTYPE html>
//         <html lang="en">
//         <head>
//             <meta charset="UTF-8">
//             <meta name="viewport" content="width=device-width, initial-scale=1.0">
//             <link rel="stylesheet" href="style.css">
//             <title>Image Gallery</title>
//         </head>
//         <body>
//             <div id="gallery">
// ${imageFiles.map((file, index) => `                <img src="${file}" alt="Image ${index + 1}">`).join('\n')}
//             </div>
//             <script src="click.js"></script>
//         </body>
//         </html>
//       `.trim();
//     }
//   }  