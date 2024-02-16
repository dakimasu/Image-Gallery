Import-Module "scripts\EnvModule\EnvModule.psm1"

$envVariables = Get-EnvVariables -envFilePath ".env"

# Set your API token here
$apiToken = $envVariables["API_TOKEN"]

# Set your Cloudflare account ID
$accountId = $envVariables["ACCOUNT_ID"]

# Specify the output directory
$outputDirectory = $envVariables["IMAGES_TXT"]

# Set the API endpoint URL
$url = $envVariables["LIST_IMAGE_URL"] -replace "accountId", $accountId

# Define headers
$headers = @{
    'Authorization' = "Bearer $apiToken"
    'Content-Type'  = 'application/json'
}

# Make the GET request
$response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

# Check if the request was successful
if ($response.success) {
    # Create or clear the image_ds.txt file
    $null | Out-File -FilePath "$outputDirectory" -Force

    # Loop through each image and write the id to image_ds.txt
    foreach ($image in $response.result.images) {
        $imageId = $image.id
        $imageId | Out-File -Append -FilePath "$outputDirectory" -Encoding UTF8
    }

    Write-Host "Image IDs have been written to /files/images.txt"
} else {
    Write-Host "Error: $($response.errors[0].message)"
}