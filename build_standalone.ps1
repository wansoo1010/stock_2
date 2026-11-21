$html = [System.IO.File]::ReadAllText('d:\AI_수업\AI에이젠트\stock_2\index.html', [System.Text.Encoding]::UTF8)
$chartJs = [System.IO.File]::ReadAllText('d:\AI_수업\AI에이젠트\stock_2\chart.min.js', [System.Text.Encoding]::UTF8)
$bgBytes = [System.IO.File]::ReadAllBytes('d:\AI_수업\AI에이젠트\stock_2\autumn_bg.jpg')
$bgB64 = [Convert]::ToBase64String($bgBytes)
$bgDataUri = 'data:image/jpeg;base64,' + $bgB64

# Print CSS block
$printCss = @"
    /* Print & PDF Export Optimized Styles */
    @media print {
      body {
        background-color: #ffffff !important;
        color: #111827 !important;
        padding: 0 !important;
      }
      body::before, body::after {
        display: none !important;
      }
      .container {
        max-width: 100% !important;
        gap: 14px !important;
      }
      .theme-switch-bar, .print-btn-bar, .chart-actions, .helper-text {
        display: none !important;
      }
      .banner-disclaimer, header, .quick-summary-box, .metric-card, .glossary-card, .chart-section, .news-section, .card, footer {
        background: #ffffff !important;
        color: #111827 !important;
        border: 1px solid #d1d5db !important;
        box-shadow: none !important;
        page-break-inside: avoid !important;
        break-inside: avoid !important;
      }
      .quick-card, .glossary-item, .news-item, .price-table th, .price-table td {
        background: #f9fafb !important;
        color: #111827 !important;
        border-color: #e5e7eb !important;
        page-break-inside: avoid !important;
        break-inside: avoid !important;
      }
      .news-summary-box {
        background: #f3f4f6 !important;
        color: #1f2937 !important;
      }
      .news-fact-col {
        background: #eff6ff !important;
        border-left: 3px solid #2563eb !important;
        color: #1e3a8a !important;
      }
      .news-interp-col {
        background: #faf5ff !important;
        border-left: 3px solid #7c3aed !important;
        color: #581c87 !important;
      }
      .tag-fact-box {
        background: #eff6ff !important;
        color: #1e3a8a !important;
      }
      .tag-ai-box {
        background: #faf5ff !important;
        color: #581c87 !important;
      }
      .tag-unverified-box {
        background: #fef2f2 !important;
        color: #991b1b !important;
      }
      .metric-value {
        color: #111827 !important;
      }
      .chart-wrapper {
        height: 280px !important;
      }
      .table-responsive {
        max-height: none !important;
        overflow: visible !important;
      }
      .content-grid {
        grid-template-columns: 1fr 1fr !important;
      }
      .news-item {
        margin-bottom: 12px !important;
      }
    }
"@

$btnReplacement = @"
    <div class="theme-switch-bar print-btn-bar" style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:10px;">
      <div style="display:flex; gap:8px;">
        <button class="theme-btn" onclick="window.print()" style="background:linear-gradient(135deg, #10b981, #059669); color:#fff; border-color:#059669; font-weight:800; cursor:pointer;">
          🖨️ 인쇄 / PDF로 저장하기
        </button>
      </div>
      <div style="display:flex; align-items:center; gap:8px;">
"@

# Update index.html
$indexUpdated = $html.Replace("  </style>", $printCss + "`r`n  </style>")
$indexUpdated = $indexUpdated.Replace('<div class="theme-switch-bar">', $btnReplacement)
[System.IO.File]::WriteAllText('d:\AI_수업\AI에이젠트\stock_2\index.html', $indexUpdated, [System.Text.Encoding]::UTF8)

# Build standalone stock-report.html
$standalone = $indexUpdated.Replace('<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>', '<script>' + $chartJs + '</script>')
$standalone = $standalone.Replace("url('autumn_bg.jpg')", "url('" + $bgDataUri + "')")
[System.IO.File]::WriteAllText('d:\AI_수업\AI에이젠트\stock_2\stock-report.html', $standalone, [System.Text.Encoding]::UTF8)

Write-Host "Success!"
Write-Host "index.html: " (Get-Item 'd:\AI_수업\AI에이젠트\stock_2\index.html').Length
Write-Host "stock-report.html: " (Get-Item 'd:\AI_수업\AI에이젠트\stock_2\stock-report.html').Length
