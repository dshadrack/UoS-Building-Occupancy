#Define location for data to be saved
$CSVPATH = ""G:\My Drive\OccupancyData\IC.csv""

#Check if data file exists 
If (Test-Path -Path $CSVPATH){

#If data file doesn't exist, create blank CSV file with column headers
}Else{
    Set-Content $CSVPATH -Value "DateTime,Occupancy"
}

#Try/Catch to stop writing if disconnected from the internet
try{

    #Read the HTML from the specified site and load this into memory
    $HTMLResponse = Invoke-WebRequest https://lib-wordpress.sheffield.ac.uk/occupancy/ic.htm?style=infoscreen 
    #Isolate occupancy number from the returned HTML
    $SiteContent = $HTMLResponse.AllElements | Where {$_.TagName -eq "SPAN"}
    $Occupancy = $SiteContent.innerText


    #Get current date and time in a readable format
    $date = Get-Date -Format "MM/dd/yyyy HH:mm"

    #Add newly returned data in a new line
    $newline = $date + "," + $Occupancy
    $newline | Add-Content -Path $CSVPATH
}

Catch{}