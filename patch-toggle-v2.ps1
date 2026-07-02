$path = 'd:\Projects\CFSBR\index.html'
$content = Get-Content $path -Raw

$old = @"
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
"@

$new = @"
            // Ultra-simple toggle: click button, show/hide panel + swap companion default/expanded blocks
            function setupToggle(buttonId, panelId, openText, closedText, companionDefault, companionExpanded) {
                const btn = document.getElementById(buttonId);
                const panel = document.getElementById(panelId);
                if (!btn || !panel) return;
                const label = btn.querySelector('.toggle-label');
                const defaultBlocks = (companionDefault || []).map(id => document.getElementById(id)).filter(Boolean);
                const expandedBlocks = (companionExpanded || []).map(id => document.getElementById(id)).filter(Boolean);
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    const isOpen = panel.classList.toggle('is-open');
                    btn.classList.toggle('is-open', isOpen);
                    btn.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
                    if (label) {
                        label.textContent = isOpen ? openText : closedText;
                    }
                    // Hide defaults when expanded, show expanded blocks; reverse on collapse
                    defaultBlocks.forEach(b => { b.style.display = isOpen ? 'none' : ''; });
                    expandedBlocks.forEach(b => { b.style.display = isOpen ? '' : 'none'; });
                });
            }
"@

if ($content.Contains($old)) {
    $newContent = $content.Replace($old, $new)
    Set-Content -Path $path -Value $newContent -NoNewline -Encoding UTF8
    Write-Host "setupToggle function updated"
} else {
    Write-Host "OLD NOT FOUND"
}

# Now update the two call sites
$call1 = "setupToggle('team-toggle-btn', 'team-extended',`n                'Hide Full Team Structure', 'Show Full Team Structure');"
$call1New = "setupToggle('team-toggle-btn', 'team-extended',`n                'Hide Full Team Structure', 'Show Full Team Structure',`n                ['team-founders-default', 'team-member-default'],`n                ['team-founders-expanded', 'team-member-expanded']);"

$call2 = "setupToggle('publications-toggle-btn', 'publications-extended',`n                'Hide Full Publication Catalog', 'Show Full Publication Catalog');"
$call2New = "setupToggle('publications-toggle-btn', 'publications-extended',`n                'Hide Full Publication Catalog', 'Show Full Publication Catalog',`n                ['publications-default'],`n                ['publications-expanded']);"

$content = Get-Content $path -Raw
if ($content.Contains($call1)) {
    $content = $content.Replace($call1, $call1New)
    Set-Content -Path $path -Value $content -NoNewline -Encoding UTF8
    Write-Host "Call 1 updated"
} else {
    Write-Host "CALL 1 NOT FOUND"
}

$content = Get-Content $path -Raw
if ($content.Contains($call2)) {
    $content = $content.Replace($call2, $call2New)
    Set-Content -Path $path -Value $content -NoNewline -Encoding UTF8
    Write-Host "Call 2 updated"
} else {
    Write-Host "CALL 2 NOT FOUND"
}

# Also need publications-default and publications-expanded blocks. Check if they exist
$content = Get-Content $path -Raw
$hasPubDefault = $content.Contains('id="publications-default"')
$hasPubExpanded = $content.Contains('id="publications-expanded-block"')
Write-Host "publications-default exists: $hasPubDefault"
Write-Host "publications-expanded-block exists: $hasPubExpanded"
