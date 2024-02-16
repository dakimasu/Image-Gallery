Import-Module "scripts\EnvModule\EnvModule.psm1"

$envVariables = Get-EnvVariables -envFilePath ".env"

# Set your API token here
$apiToken = $envVariables["API_TOKEN"]

# Set your Cloudflare account ID
$accountId = $envVariables["ACCOUNT_ID"]

$path = $envVariables["IMAGES_FOLDER"]
# Get the total count of files in the directory
$totalFiles = (Get-ChildItem -Path $path).Count
$progressCounter = 0

$url = $envVariables["UPLOAD_IMAGE_URL"] -replace "accountId", $accountId

# Rest of the script remains unchanged

Get-ChildItem -Path $path | ForEach-Object {
    $filePath = $_.FullName

    # Increment the progress counter
    $progressCounter++

    # Calculate the percentage completed
    $percentComplete = ($progressCounter / $totalFiles) * 100

    # Update the progress bar
    Write-Progress -Activity "Uploading Images" -Status "Progress: $percentComplete%" -PercentComplete $percentComplete

    Invoke-RestMethod -Uri $url -Method Post -Headers @{
        Authorization = "Bearer $apiToken"
    } -Form @{
        file = Get-Item $filePath
    }

    # Introduce a delay of 0.5 seconds
    Start-Sleep -Seconds 0.5
}

# Clear the progress bar after completion
Write-Progress -Activity "Uploading Images" -Completed