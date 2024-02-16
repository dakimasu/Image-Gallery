# EnvModule.psm1

function Get-EnvVariables {
    param (
        [string]$envFilePath = ".env"
    )

    # Read the content of the .env file
    $envContent = Get-Content -Path $envFilePath

    # Initialize an empty hashtable to store key-value pairs
    $envVariables = @{}

    # Loop through each line in the .env file
    foreach ($line in $envContent) {
        # Skip comments and empty lines
        if ($line -match '^\s*#|^\s*$') {
            continue
        }

        # Split the line into key and value
        $key, $value = $line -split '=', 2

        # Add the key-value pair to the hashtable
        $envVariables[$key] = $value
    }

    return $envVariables
}