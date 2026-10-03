//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:51:47
// ----------------------------------------------------
// Method: APT_Tool_CheckAvailability
// Description
//    Lists free appointment slots for a date, optionally filtered to one staff member
//
// Parameters
// ----------------------------------------------------

#DECLARE($params : Object) : Object

var $result : Object:={date: $params.date; slots: []}

Try
	var $date : Date
	$date:=Date:C102($params.date)
	
	var $staffList : cs:C1710.StaffSelection
	If ($params.staffID#Null:C1517) && ($params.staffID#"")
		$staffList:=ds:C1482.Staff.query("staffID = :1 and isActive = :2"; $params.staffID; True:C214)
	Else 
		$staffList:=ds:C1482.Staff.query("isActive = :1"; True:C214)
	End if 
	
	var $staff : cs:C1710.StaffEntity
	For each ($staff; $staffList)
		var $freeSlots : Collection
		$freeSlots:=APT_ComputeFreeSlots($staff; $date)
		
		var $slotTime : Time
		For each ($slotTime; $freeSlots)
			$result.slots.push({\
				staffID: $staff.staffID; \
				staffName: $staff.fullName; \
				time: String:C10($slotTime; "HH:mm")\
				})
		End for each 
	End for each 
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result