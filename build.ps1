$paths=@(
    "MonoGame.IMEHelper.DesktopGL",
    "MonoGame.IMEHelper.WindowsDX"
)

Write-Host "Step 1: Restore" -ForegroundColor Blue 

foreach($path in $paths){
    Write-Host "- Restore $path.csproj" -ForegroundColor DarkBlue 
    & dotnet restore $path
}

Write-Host "Step 2: Build" -ForegroundColor Blue 

Write-Host "- Remove Artifacts Folder" -ForegroundColor DarkBlue 
Remove-Item Artifacts\ -Force -Recurse

foreach($path in $paths){
    Write-Host "- Restore $path.csproj" -ForegroundColor DarkBlue 
    & dotnet pack --no-restore -c Release $path
}

Write-Host "Step 3: Copy" -ForegroundColor Blue 

Move-Item Artifacts\DesktopGL\*.nupkg Artifacts\
Move-Item Artifacts\WindowsDX\*.nupkg Artifacts\
Get-ChildItem Artifacts|Where-Object Extension -eq .nupkg

Write-Host "Step 4: Clear" -ForegroundColor Blue 
Get-ChildItem Artifacts|Where-Object Mode -eq d----|Remove-Item -Force -Recurse