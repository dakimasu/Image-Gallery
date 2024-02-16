Import-Module "scripts\EnvModule\EnvModule.psm1"

$envVariables = Get-EnvVariables -envFilePath ".env"

# Set your API token here
$apiToken = $envVariables["API_TOKEN"]

# Set your Cloudflare account ID
$accountId = $envVariables["ACCOUNT_ID"]

# Set the path to the file containing image_ids (one per line)
$imageIdsFilePath = $envVariables["IMAGES_TXT"]

# Read image_ids from the file
$imageIds = Get-Content -Path $imageIdsFilePath

# Loop through each image_id and send DELETE request
foreach ($imageId in $imageIds) {
    $url = $envVariables["DELETE_IMAGE_URL"] -replace "accountId", $accountId -replace "imageId", $imageId

    # Create headers
    $headers = @{
        'Authorization' = "Bearer $apiToken"
        'Content-Type'  = 'application/json'
    }

    # Send DELETE request
    try {
        Invoke-RestMethod -Method Delete -Uri $url -Headers $headers -ErrorAction Stop

        # Output success message
        Write-Host "Image with ID $imageId deleted successfully."
    } catch {
        # Output error message
        Write-Host "Error deleting image with ID $imageId. $_"
    }

    # Introduce a delay of 0.5 seconds
    Start-Sleep -Seconds 0.1
}