# Set your Cloudflare API token
$apiToken = "your_api_token_here"

# Set your Cloudflare account ID
$accountId = "your_account_id_here"

# Specify the output directory
$outputDirectory = "."

# Set the API endpoint URL
$url = "https://api.cloudflare.com/client/v4/accounts/$accountId/images/v2"

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
    $null | Out-File -FilePath "$outputDirectory\image_ids.txt" -Force

    # Loop through each image and write the id to image_ds.txt
    foreach ($image in $response.result.images) {
        $imageId = $image.id
        $imageId | Out-File -Append -FilePath "$outputDirectory\image_ids.txt" -Encoding UTF8
    }

    Write-Host "Image IDs have been written to image_ids.txt"
} else {
    Write-Host "Error: $($response.errors[0].message)"
}