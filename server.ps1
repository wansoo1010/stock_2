$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:8088/')
$listener.Start()
Write-Host "Server started at http://localhost:8088/"
while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    $relPath = $request.Url.LocalPath.TrimStart('/')
    if ([string]::IsNullOrEmpty($relPath)) { $relPath = 'index.html' }
    $localPath = Join-Path "d:\AI_수업\AI에이젠트\stock_2" $relPath

    if (Test-Path $localPath -PathType Leaf) {
        $bytes = [System.IO.File]::ReadAllBytes($localPath)
        if ($localPath.EndsWith('.html')) { $response.ContentType = 'text/html; charset=utf-8' }
        elseif ($localPath.EndsWith('.json')) { $response.ContentType = 'application/json; charset=utf-8' }
        elseif ($localPath.EndsWith('.jpg') -or $localPath.EndsWith('.jpeg')) { $response.ContentType = 'image/jpeg' }
        elseif ($localPath.EndsWith('.png')) { $response.ContentType = 'image/png' }
        else { $response.ContentType = 'application/octet-stream' }
        
        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
        $response.StatusCode = 404
    }
    $response.OutputStream.Close()
}
