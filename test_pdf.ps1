$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edge)) {
  $edge = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}
Write-Host "Edge path: $edge"
$pdfTarget = "d:\AI_수업\AI에이젠트\stock_2\SpaceX_Stock_Report.pdf"
$url = "http://localhost:8088/index.html"

# Execute Edge headless with new mode
Start-Process -FilePath $edge -ArgumentList "--headless=new", "--disable-gpu", "--no-pdf-header-footer", "--print-to-pdf=$pdfTarget", $url -Wait
Start-Sleep -Seconds 2
if (Test-Path $pdfTarget) {
  Write-Host "PDF Generated Successfully! Size: " (Get-Item $pdfTarget).Length
} else {
  Write-Host "PDF not generated yet"
}
