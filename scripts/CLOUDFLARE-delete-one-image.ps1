Import-Module "scripts\EnvModule\EnvModule.psm1"

$envVariables = Get-EnvVariables -envFilePath ".env"

# Set your API token here
$apiToken = $envVariables["API_TOKEN"]

# Set your Cloudflare account ID
$accountId = $envVariables["ACCOUNT_ID"]

# Read User-Input
$imageId = Read-Host "Input image ID:"

# Cloudflare API endpoint
$url = $envVariables["DELETE_IMAGE_URL"] -replace "accountId", $accountId -replace "imageId", $imageId

# Define headers
$headers = @{
    'Authorization' = "Bearer $apiToken"
    'Content-Type'  = 'application/json'
}

# Make the GET request
$response = Invoke-RestMethod -Method Delete -Uri $url -Headers $headers

$response