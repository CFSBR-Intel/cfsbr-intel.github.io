# Simple static file server for CFSBR (PowerShell, no deps)
param([int]$Port = 8765, [string]$Root = $PSScriptRoot)

$mime = @{
    ".html"="text/html; charset=utf-8"
    ".css"="text/css; charset=utf-8"
    ".js"="application/javascript; charset=utf-8"
    ".json"="application/json; charset=utf-8"
    ".svg"="image/svg+xml"
    ".png"="image/png"
    ".jpg"="image/jpeg"
    ".jpeg"="image/jpeg"
    ".gif"="image/gif"
    ".webp"="image/webp"
    ".ico"="image/x-icon"
    ".woff"="font/woff"
    ".woff2"="font/woff2"
    ".ttf"="font/ttf"
    ".pdf"="application/pdf"
    ".txt"="text/plain; charset=utf-8"
    ".xml"="application/xml; charset=utf-8"
}

$listener = New-Object System.Net.HttpListener
$prefix = "http://localhost:$Port/"
$listener.Prefixes.Add($prefix)
$listener.Start()
Write-Host "CFSBR dev server running at $prefix (root: $Root)" -ForegroundColor Green
Write-Host "Press Ctrl+C to stop." -ForegroundColor Yellow

try {
    while ($listener.IsListening) {
        $ctx = $listener.GetContext()
        $req = $ctx.Request
        $res = $ctx.Response

        $relPath = [Uri]::UnescapeDataString($req.Url.AbsolutePath).TrimStart('/')
        if ([string]::IsNullOrWhiteSpace($relPath)) { $relPath = "index.html" }

        $fullPath = Join-Path $Root $relPath
        # Security: prevent path traversal
        $fullPath = [System.IO.Path]::GetFullPath($fullPath)
        if (-not $fullPath.StartsWith([System.IO.Path]::GetFullPath($Root))) {
            $res.StatusCode = 403
            $res.Close()
            continue
        }

        if (Test-Path $fullPath -PathType Container) {
            $fullPath = Join-Path $fullPath "index.html"
        }

        if (Test-Path $fullPath -PathType Leaf) {
            $ext = [System.IO.Path]::GetExtension($fullPath).ToLower()
            $res.ContentType = if ($mime.ContainsKey($ext)) { $mime[$ext] } else { "application/octet-stream" }
            $res.Headers.Add("Cache-Control", "no-store, no-cache, must-revalidate")
            $res.Headers.Add("Pragma", "no-cache")
            $bytes = [System.IO.File]::ReadAllBytes($fullPath)
            $res.ContentLength64 = $bytes.Length
            $res.OutputStream.Write($bytes, 0, $bytes.Length)
            Write-Host "$($req.HttpMethod) $($req.Url.AbsolutePath) -> 200 ($bytes.Length bytes)"
        } else {
            $res.StatusCode = 404
            $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $relPath")
            $res.OutputStream.Write($msg, 0, $msg.Length)
            Write-Host "$($req.HttpMethod) $($req.Url.AbsolutePath) -> 404" -ForegroundColor Red
        }
        $res.Close()
    }
} finally {
    $listener.Stop()
    $listener.Close()
}