do {
    Write-Host "Digite o site " -ForegroundColor Cyan -NoNewline
    Write-Host "(ex: www.exemplo.com.br)" -ForegroundColor Yellow -NoNewline
    $site = Read-Host " "

    $outputFile = "$site.txt"

    Write-Host "`n=======================================================================" -ForegroundColor Magenta

    try{ $web = Invoke-WebRequest -Uri "$site" -Method Options
        $server = $web.headers.server } 
    catch { 
        echo "Não foi possível obter informações" 
    } 

    Write-Host "`nO servidor roda: $server" -ForegroundColor Cyan
    Write-Host "`n=======================================================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "`n[+] Resolvendo URLs em: $site" -ForegroundColor Green
    Write-Host ""
    Write-Host "`n========================================================================" -ForegroundColor Magenta
    Write-Host ""
 
    $web2 = Invoke-WebRequest -Uri "$site" 
    $links = $web2.links.href | Where-Object { $_ -match '^http' }

    $resultados = @()
    $contador = 1
    
    foreach ($link in $links) {
    $uri = [Uri]$link
    $dominio = $uri.Host

    try {
        $ip = [System.Net.Dns]::GetHostAddresses($dominio) |
              Where-Object { $_.AddressFamily -eq 'InterNetwork' } |
              Select-Object -First 1
    } catch {
        $ip = "Não resolvido"
    }

    $resultados += [PSCustomObject]@{
        Line    = $contador
        IP      = $ip
        ADDRESS = $dominio
    }

    $contador++
}

Write-Host "[+] Concluído: Salvando os resultados em: $site.txt" -ForegroundColor Red
Write-Host "`n========================================================================" -ForegroundColor Magenta
Write-Host "`tLine`t`tIP`t`tADDRESS"
Write-Host "`n========================================================================" -ForegroundColor Magenta

foreach ($r in $resultados) {
   $linhaFormatada = "{0,4}`t{1,-16}`t{2}" -f $r.Line, $r.IP, $r.ADDRESS
   Write-Host $linhaFormatada
   $linhaFormatada | Out-File $outputFile -Append
}

Write-Host "`n========================================================================" -ForegroundColor Magenta

    Write-Host "- Nova pesquisa? (y/n)" -ForegroundColor green -NoNewline
    $novaPesquisa = Read-Host

} while ($novaPesquisa -eq 'y')