# Finding the video streaming length of all videos in a specific folder
function Get_Duration ([String]$Folder){
	$time_duration = @()
	$objShell = New-Object -ComObject Shell.Application
	$LengthColumn = 27
	$files = Get-ChildItem -Path $Folder -Recurse -Name
	$seconds = "00:00:00"
	$textReformat2 = $seconds  -replace ",","."
	for ($i = 0; $i -lt $files.count; $i++) {
		$objFolder = $objShell.Namespace($Folder)
		$objFile = $objFolder.ParseName($files[$i])
		$Length = $objFolder.GetDetailsOf($objFile, $LengthColumn)
   		#Write-Host "File Name $($i+1): $($files[$i])"
		$Time1 = $Length
		$textReformat1 = $Time1 -replace ",","."
		$seconds = ([TimeSpan]::Parse($textReformat2)).TotalSeconds + ([TimeSpan]::Parse($textReformat1)).TotalSeconds
		$time_duration += $seconds
	}
	$TimeSpan = [timespan]::fromseconds($seconds)
	Write-Host "Total Files : $($files.count)"
	Write-Host "Total Hours : $(($time_duration | Measure-Object -sum).sum/60/60)"
}
$Folder = "E:\workspace\videos" #path of the videos location
Get_Duration $Folder

#Output:
#==========
#Total Files : 73
#Total Hours : 9.28388888888889
