Import-Module "scripts\EnvModule\EnvModule.psm1"

$envVariables = Get-EnvVariables -envFilePath ".env"

# Set your API token here
$apiToken = $envVariables["API_TOKEN"]

# Set your Cloudflare account ID
$accountId = $envVariables["ACCOUNT_ID"]

# Specify the output directory
$outputDirectory = $envVariables["IMAGES_TXT"]

# Set the API endpoint URL with query parameters
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
    # Initialize total variant count
    $totalVariantCount = 0

    # Loop through each image and accumulate the number of variants
    foreach ($image in $response.result.images) {
        $variants = $image.variants

        # Loop through each variant and write to the out.txt file
        foreach ($variant in $variants) {
            $totalVariantCount++
            $imgTag = "<img src=`"$variant`" alt=`"$totalVariantCount`">"
            $imgTag | Out-File -Append -FilePath "$outputDirectory" -Encoding UTF8
        }
    }

    Write-Host "Total Variant Count: $totalVariantCount"
} else {
    Write-Host "Error: $($response.errors[0].message)"
}