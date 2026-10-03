//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:54:15
// ----------------------------------------------------
// Method: APT_Tool_GetWeekAvailability
// Description
//     Lists free slots for a staff member across the next 7 days from a given date,
//     so the assistant can proactively offer alternatives when a specific day is full.
//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={days: []}

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
	
	var $dayNames : Collection:=["Sunday"; "Monday"; "Tuesday"; "Wednesday"; "Thursday"; "Friday"; "Saturday"]
	
	var $i : Integer
	For ($i; 0; 6)
		var $freeSlots : Collection
		$freeSlots:=APT_ComputeFreeSlots($staff; $searchDate)
		
		If ($freeSlots.length>0)
			var $slotTexts : Collection:=[]
			var $slot : Time
			For each ($slot; $freeSlots)
				$slotTexts.push(String:C10($slot; "HH:mm"))
			End for each 
			
			$result.days.push({\
				date: String:C10($searchDate; "yyyy-MM-dd"); \
				dayName: $dayNames[Day number:C114($searchDate)-1]; \
				slots: $slotTexts\
				})
		End if 
		
		$searchDate:=$searchDate+1
	End for 
	
	$result.staffName:=$staff.fullName
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result
