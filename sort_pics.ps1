$backupFolderPath = Join-Path -Path $PWD -ChildPath "Backup"
if (-not (Test-Path $backupFolderPath)) {
New-Item -ItemType Directory -Path $backupFolderPath
}

$files = Get-ChildItem -Recurse | Where-Object {$_.Extension -match "(jpg|jpeg|png|gif|bmp|mov|mp4|avi|wmv|flv)"}

foreach ($file in $files) {
    $month = $file.CreationTime.Month.ToString("00")
    $year = $file.CreationTime.Year
    $folderName = "$year-$month"
    $newFolderPath = Join-Path -Path $backupFolderPath -ChildPath $folderName
    if (-not (Test-Path $newFolderPath)) {
        New-Item -ItemType Directory -Path $newFolderPath
    }
    $newFilePath = Join-Path -Path $newFolderPath -ChildPath $file.Name
    if (-not (Test-Path $newFilePath)) {
        Copy-Item -Path $file.FullName -Destination $newFilePath
    }
}
