$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$pdfTarget = "d:\AI_수업\AI에이젠트\stock_2\SpaceX_Stock_Report.pdf"
$htmlPath = "file:///d:/AI_수업/AI에이젠트/stock_2/stock-report.html"

# Run msedge headless with delay to allow layout and Chart.js to render
Start-Process -FilePath $edge -ArgumentList "--headless", "--disable-gpu", "--virtual-time-budget=5000", "--print-to-pdf=$pdfTarget", $htmlPath -Wait
Start-Sleep -Seconds 2
if (Test-Path $pdfTarget) {
  Write-Host "PDF Size:" (Get-Item $pdfTarget).Length
}
