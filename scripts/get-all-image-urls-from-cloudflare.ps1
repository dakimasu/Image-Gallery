# Set your Cloudflare API token
$apiToken = "your_api_token_here"

# Set your Cloudflare account ID
$accountId = "your_account_id_here"

# Specify the output directory
$outputDirectory = "."

# Set the API endpoint URL with query parameters
$url = "https://api.cloudflare.com/client/v4/accounts/$accountId/images/v2?per_page=10000"

# Define headers
$headers = @{
    'Authorization' = "Bearer $apiToken"
    'Content-Type'  = 'application/json'
}

# Make the GET request
$response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers

# Check if the request was successful
if ($response.success) {
    # Initialize total variant count
    $totalVariantCount = 0

    # Loop through each image and accumulate the number of variants
    foreach ($image in $response.result.images) {
        $variants = $image.variants

        # Loop through each variant and write to the out.txt file
        foreach ($variant in $variants) {
            $totalVariantCount++
            $imgTag = "<img src=`"$variant`" alt=`"$totalVariantCount`">"
            $imgTag | Out-File -Append -FilePath "$outputDirectory\out.txt" -Encoding UTF8
        }
    }

    Write-Host "Total Variant Count: $totalVariantCount"
} else {
    Write-Host "Error: $($response.errors[0].message)"
}