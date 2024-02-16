# Set your API token here
$apiToken = "your_api_token_here"

# Set your Cloudflare account ID
$accountId = "your_account_id_here"

# Set the path to the file containing image_ids (one per line)
$imageIdsFilePath = "./image_ids.txt"

# Read image_ids from the file
$imageIds = Get-Content -Path $imageIdsFilePath

# Cloudflare API endpoint
$urlBase = "https://api.cloudflare.com/client/v4/accounts/$accountId/images/v1/"

# Loop through each image_id and send DELETE request
foreach ($imageId in $imageIds) {
    $url = "$urlBase$imageId"

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