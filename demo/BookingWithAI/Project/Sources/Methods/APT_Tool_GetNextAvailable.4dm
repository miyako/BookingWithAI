//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:53:44
// ----------------------------------------------------
// Method: APT_Tool_GetNextAvailable
// Description
//     Finds the next free slot for a specific staff member, searching forward from a date (14-day window)
//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={found: False:C215}

Try
	If ($params.staffID=Null:C1517) || ($params.staffID="")
		$result.error:="staffID is required"
		return $result
	End if 
	
	var $staff : cs:C1710.StaffEntity
	$staff:=ds:C1482.Staff.query("staffID = :1"; $params.staffID).first()
	
	If ($staff=Null:C1517)
		$result.error:="Staff not found"
		return $result
	End if 
	
	var $searchDate : Date
	If ($params.fromDate#Null:C1517) && ($params.fromDate#"")
		$searchDate:=Date:C102($params.fromDate)
	Else 
		$searchDate:=Current date:C33
	End if 
	
	var $daysChecked : Integer
	$daysChecked:=0
	
	While (Not:C34($result.found)) && ($daysChecked<14)
		var $freeSlots : Collection
		$freeSlots:=APT_ComputeFreeSlots($staff; $searchDate)
		
		If ($freeSlots.length>0)
			$result.found:=True:C214
			$result.staffID:=$staff.staffID
			$result.staffName:=$staff.fullName
			$result.date:=String:C10($searchDate; "yyyy-MM-dd")
			$result.time:=String:C10(Time:C179($freeSlots[0]); "HH:mm")
		End if 
		
		$searchDate:=$searchDate+1
		$daysChecked:=$daysChecked+1
	End while 
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result