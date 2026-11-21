$chromePaths = @(
  "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
  "C:\Program Files\Microsoft\Edge\Application\msedge.exe",
  "C:\Program Files\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
)
$found = $null
foreach ($p in $chromePaths) {
  if (Test-Path $p) {
    $found = $p
    break
  }
}

if ($found) {
  Write-Host "Found browser engine: $found"
  $htmlPath = "file:///d:/AI_수업/AI에이젠트/stock_2/stock-report.html"
  $pdfPath = "d:\AI_수업\AI에이젠트\stock_2\SpaceX_Stock_Report.pdf"
  & $found --headless --disable-gpu --run-all-compositor-stages-before-draw --print-to-pdf=$pdfPath $htmlPath
  Start-Sleep -Seconds 3
  if (Test-Path $pdfPath) {
    Write-Host "PDF Generated Successfully! Size: " (Get-Item $pdfPath).Length
  } else {
    Write-Host "PDF generation completed but file check needed."
  }
} else {
  Write-Host "No browser found for headless print."
}
