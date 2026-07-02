Get-ChildItem d:\Projects\CFSBR\*.html, d:\Projects\CFSBR\publications\*.html -ErrorAction SilentlyContinue | ForEach-Object {
    $f = $_.FullName
    $c = Get-Content -Raw $f
    $hasFetch = $c -match 'fetch.+photos/icons.svg'
    $hasUse = ([regex]::Matches($c, 'href=["'']#ic-')).Count
    $hasSprite = $c -match '<symbol id="ic-target"'
    $rel = $f.Replace('D:\Projects\CFSBR\', '')
    ('{0,-55} fetch={1,-5} use={2,-4} sprite={3}' -f $rel, $hasFetch, $hasUse, $hasSprite)
}