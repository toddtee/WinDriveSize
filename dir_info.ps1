param($drive)
$directory=$drive+":\"
$DirReport = @{}
$DirType = @{}
$filename = $drive+"_drive_analysis_"+(Get-Date -f yyyyMMdd)+".csv"


Foreach($i in Get-ChildItem $directory)
{
	If($i -is [System.IO.DirectoryInfo] -eq $True){
		$x=(Get-ChildItem $directory$i -recurse | Measure-Object -Property Length -Sum)
		$y=("{0:N2}" -f ($x.sum / 1MB))
		$DirReport.Add($i,$y)	
		$DirType.Add($i,"Directory")	


}
	Else{
		$x=(Get-ChildItem $directory$i | Measure-Object -Property Length -Sum)
		$y=("{0:N2}" -f ($x.sum / 1MB))
		$DirReport.Add($i,$y)	
		$DirType.Add($i,"File")	
	}

}

$csvReport = @()
$DirReport.GetEnumerator() | Sort-Object {[int]$_.Value} -descending | ForEach-Object{
	$row = "" | Select "Item", "Size", "Type"
	$row."Item"=$_.Key
	$row."Size"=$_.Value + " MB"
	$row."Type"=$DirType.Get_Item($_.Key)
	$csvReport+=$row
}

$csvReport | Export-CSV $filename

