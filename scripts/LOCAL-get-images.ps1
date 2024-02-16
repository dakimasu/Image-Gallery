Import-Module "scripts\EnvModule\EnvModule.psm1"

$envVariables = Get-EnvVariables -envFilePath ".env"

# Define the path to the images directory and the output file
$imagesDirectory = $envVariables["IMAGES_FOLDER"]
$outputFile = $envVariables["IMAGES_TXT"]

# Get all files in the images directory
$imageFiles = Get-ChildItem -Path $imagesDirectory -File

# Create or overwrite the output file
$null | Set-Content -Path $outputFile

# Initialize a counter
$counter = 1

# Loop through each image file and generate HTML element
foreach ($file in $imageFiles) {
    $imageName = $file.Name
    $htmlElement = "<img src=""$imagesDirectory/$imageName"" alt=""$counter"">"
    Add-Content -Path $outputFile -Value $htmlElement
    $counter++
}

Write-Host "HTML elements generated and saved to $outputFile"