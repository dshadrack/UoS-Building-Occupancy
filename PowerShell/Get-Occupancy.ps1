$CSVPATH = "F:\TEMP\Occupancy.csv"

If (Test-Path -Path $CSVPATH){

}Else{
    Set-Content $CSVPATH -Value "DateTime,Occupancy"
}

$HTMLResponse = Invoke-WebRequest https://lib-wordpress.sheffield.ac.uk/occupancy/ic.htm?style=infoscreen 
$SiteContent = $HTMLResponse.AllElements | Where {$_.TagName -eq "SPAN"}
$Occupancy = $SiteContent.innerText
$date = Get-Date -Format "MM/dd/yyyy HH:mm"

$CSVfile = Import-Csv $CSVPATH
$newline = $date + "," + $Occupancy
$newline | Add-Content -Path $CSVPATH
