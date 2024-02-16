# Copy this script into your images folder (or just specify the path for it) and fill in your API token and account ID!
$path = "."
$apiToken = "your_api_token_here"
$accountId = "your_account_id_here"

# Get the total count of files in the directory
$totalFiles = (Get-ChildItem -Path $path).Count
$progressCounter = 0

# Rest of the script remains unchanged

Get-ChildItem -Path $path | ForEach-Object {
    $filePath = $_.FullName

    # Increment the progress counter
    $progressCounter++

    # Calculate the percentage completed
    $percentComplete = ($progressCounter / $totalFiles) * 100

    # Update the progress bar
    Write-Progress -Activity "Uploading Images" -Status "Progress: $percentComplete%" -PercentComplete $percentComplete

    Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/accounts/$accountId/images/v1" -Method Post -Headers @{
        Authorization = "Bearer $apiToken"
    } -Form @{
        file = Get-Item $filePath
    }

    # Introduce a delay of 0.5 seconds
    Start-Sleep -Seconds 0.5
}

# Clear the progress bar after completion
Write-Progress -Activity "Uploading Images" -Completed