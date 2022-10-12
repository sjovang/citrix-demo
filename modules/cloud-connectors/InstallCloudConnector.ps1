[CmdletBinding(SupportsShouldProcess=$True)]
param(
    $APIID,
    $APIKey,
    $CustomerName,
    $ResourceLocationID
    
)

$config_parameters = @{
    "customerName": $CustomerName,
    "clientId": $APIID,
    "clientSecret": $APIKey,
    "resourceLocationId": $ResourceLocationID,
    "acceptTermsOfService": "true"
}
$config_json = $config_parameters | ConvertFrom-Json
$config_json | ConvertTo-Json | Out-File "C:\Temp\cc_config.json"

$FileName = "cwcconnector.exe"
$Path = "C:Temp"
$url = "https://downloads.cloud.com/$CustomerName/connector/cwcconnector.exe"

Write-Verbose "Downloading $Vendor $Product $Version" -Verbose
New-Item -Path $Path -ItemType Directory -Force
Invoke-WebRequest -Uri $url -OutFile $Path$FileName

$ExitCode = (Start-Process "$Path$FileName" /q /ParametersFilePath:C:\Temp\cc_config.json -Wait -Passthru).ExitCode
Return $ExitCode