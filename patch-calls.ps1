$path = 'd:\Projects\CFSBR\index.html'
$content = Get-Content $path -Raw

# Find the team call site
$idx1 = $content.IndexOf("setupToggle('team-toggle-btn'")
$end1 = $content.IndexOf("');", $idx1)
$end1 = $content.IndexOf("');", $end1 + 1)  # Skip past 'Show Full Team Structure' to actual close
$actualEnd1 = $end1 + 2
$oldCall1 = $content.Substring($idx1, $actualEnd1 - $idx1)
Write-Host "Old call 1: '$oldCall1'"

$newCall1 = "setupToggle('team-toggle-btn', 'team-extended',`n                'Hide Full Team Structure', 'Show Full Team Structure',`n                ['team-founders-default', 'team-member-default'],`n                ['team-founders-expanded', 'team-member-expanded']);"

$newContent = $content.Substring(0, $idx1) + $newCall1 + $content.Substring($actualEnd1)
Set-Content -Path $path -Value $newContent -NoNewline -Encoding UTF8
Write-Host "Call 1 patched"

# Verify
$content = Get-Content $path -Raw
$verify = $content.IndexOf("'team-founders-default', 'team-member-default'")
Write-Host "Verification found at: $verify"
