# inline-icons.ps1 (v2)
# Convert each HTML file from fetch-based sprite loading to inline sprite host.
# Handles two patterns:
#   A) Pre-existing <div id="cfsbr-icon-sprite">...</div> followed by a <script>fetch</script>
#   B) A <script> that creates the host via document.createElement + fetches

$ErrorActionPreference = 'Stop'

# 1. Load sprite inner XML (between <svg ...> and </svg>)
$spriteRaw = Get-Content -Raw 'd:\Projects\CFSBR\photos\icons.svg'
$spriteInner = $spriteRaw -replace '(?s)^.*?<svg[^>]*>\s*', '' -replace '(?s)</svg>\s*$', ''

# Build inline host block
$inlineHost = @"
<!-- Inline CFSBR icon sprite — <use href="#ic-..."/> resolves directly -->
<svg xmlns="http://www.w3.org/2000/svg" width="0" height="0" style="position:absolute;width:0;height:0;overflow:hidden" aria-hidden="true">
$spriteInner
</svg>
"@

# 2. Files to process
$files = Get-ChildItem -Path 'd:\Projects\CFSBR' -Filter *.html -Recurse -File |
    Where-Object { $_.FullName -notmatch '\\(node_modules|\.git)\\' } |
    ForEach-Object { $_.FullName }

foreach ($file in $files) {
    $content = Get-Content -Raw $file
    $original = $content
    $patched = $false

    # --- Pattern A: <div id="cfsbr-icon-sprite" ...>...</div><script>fetch...</script> ---
    $patA = '(?s)<div\s+id=["'']cfsbr-icon-sprite["''][^>]*>.*?</script>'
    if ([regex]::IsMatch($content, $patA)) {
        $content = [regex]::Replace($content, $patA, $inlineHost.TrimEnd(), 1)
        $patched = $true
    }

    # --- Pattern B: <script> that creates host via JS + fetches icons.svg ---
    # Match: <script>...fetch('photos/icons.svg')...document.createElement...host.id = 'cfsbr-icon-sprite'...</script>
    # Greedy enough to capture both IIFE and plain script forms.
    $patB = '(?s)<script[^>]*>(?>[^<]|<(?!/script>))*?fetch\(\s*[\x27"]photos/icons\.svg[\x27"][^<]*(?:<(?!(?:/script>|script>))[^<]*)*</script>'
    # The above is complex; fall back to a simpler approach: any <script>...</script> containing fetch('photos/icons.svg')
    $patBSimple = '(?s)<script\b[^>]*>(?:(?!</script>).)*?fetch\(\s*[\x27"]photos/icons\.svg[\x27"](?:(?!</script>).)*?</script>'
    if (-not $patched -and [regex]::IsMatch($content, $patBSimple)) {
        $content = [regex]::Replace($content, $patBSimple, '', 1)
        $patched = $true
    }

    # --- Pattern C: bare <div id="cfsbr-icon-sprite"> without surrounding script ---
    $patC = '(?s)<div\s+id=["'']cfsbr-icon-sprite["''][^>]*>.*?</div>'
    if ([regex]::IsMatch($content, $patC)) {
        $content = [regex]::Replace($content, $patC, $inlineHost.TrimEnd(), 1)
        $patched = $true
    }

    # Update <use href="photos.icons.svg#ic-x"/> -> <use href="#ic-x"/>
    $content = $content -replace 'href="photos/icons\.svg#ic-', 'href="#ic-'
    $content = $content -replace "href='photos\.icons\.svg#ic-", "href='#ic-"

    if ($content -ne $original) {
        Set-Content -Path $file -Value $content -NoNewline -Encoding UTF8
        Write-Host "Patched: $file"
    } else {
        Write-Host "Unchanged: $file"
    }
}

Write-Host "`nDone. Inline sprite now embedded in all HTML files."