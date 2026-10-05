//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:54:01
// ----------------------------------------------------
// Method: APT_Tool_GetStaffList
// Description
//     Lists active staff members, optionally filtered by specialty
//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={staff: []}

Try
	var $staffList : cs:C1710.StaffSelection
	
	If ($params#Null:C1517) && ($params.specialty#Null:C1517) && ($params.specialty#"")
		$staffList:=ds:C1482.Staff.query("isActive = :1 and specialty = :2"; True:C214; $params.specialty)
	Else 
		$staffList:=ds:C1482.Staff.query("isActive = :1"; True:C214)
	End if 
	
	var $s : cs:C1710.StaffEntity
	For each ($s; $staffList)
		$result.staff.push({\
			staffID: $s.staffID; \
			firstName: $s.firstName; \
			lastName: $s.lastName; \
			specialty: $s.specialty; \
			slotDuration: $s.slotDuration\
			})
	End for each 
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result