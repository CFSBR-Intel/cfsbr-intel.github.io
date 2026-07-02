$path = 'd:\Projects\CFSBR\index.html'
$content = Get-Content $path -Raw

# Locate the bindToggle function block
$startMarker = '// Generic toggle helper used by both team and publications sections.'
$endMarker = '                ''Show Full Publication Catalog''            );'

$startIdx = $content.IndexOf($startMarker)
$endIdx = $content.IndexOf($endMarker, $startIdx)

if ($startIdx -lt 0 -or $endIdx -lt 0) {
    Write-Host "ERROR: Could not locate markers"
    exit 1
}

# endIdx is at the 'Show Full Publication Catalog' start; we need to include the closing ');'
# Find the closing ');' after endIdx
$closeIdx = $content.IndexOf(');', $endIdx)
$endReplaceAt = $closeIdx + 2

$oldBlock = $content.Substring($startIdx, $endReplaceAt - $startIdx)
Write-Host "Old block length: $($oldBlock.Length)"

$newBlock = @"
// Ultra-simple toggle: click button, find next sibling, show/hide, swap text
            function setupToggle(buttonId, panelId, openText, closedText) {
                const btn = document.getElementById(buttonId);
                const panel = document.getElementById(panelId);
                if (!btn || !panel) return;
                const label = btn.querySelector('.toggle-label');
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    const isOpen = panel.classList.toggle('is-open');
                    btn.classList.toggle('is-open', isOpen);
                    btn.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
                    if (label) {
                        label.textContent = isOpen ? openText : closedText;
                    }
                });
            }
            setupToggle('team-toggle-btn', 'team-extended',
                'Hide Full Team Structure', 'Show Full Team Structure');
            setupToggle('publications-toggle-btn', 'publications-extended',
                'Hide Full Publication Catalog', 'Show Full Publication Catalog');
"@

$newContent = $content.Substring(0, $startIdx) + $newBlock + $content.Substring($endReplaceAt)
$diff = $newContent.Length - $content.Length
Write-Host "Size diff: $diff"

Set-Content -Path $path -Value $newContent -NoNewline -Encoding UTF8
Write-Host "Patched successfully"
