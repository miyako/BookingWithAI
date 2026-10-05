//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:52:42
// ----------------------------------------------------
// Method: APT_Tool_Dispatch
// Description
//     Routes a tool-call name + arguments object to the matching APT_Tool_* handler
//
// Parameters
// ----------------------------------------------------


#DECLARE($fnName : Text; $args : Object) : Object

var $result : Object

Case of 
	: ($fnName="checkAvailability")
		$result:=APT_Tool_CheckAvailability($args)
	: ($fnName="getStaffList")
		$result:=APT_Tool_GetStaffList($args)
	: ($fnName="getNextAvailable")
		$result:=APT_Tool_GetNextAvailable($args)
	: ($fnName="getWeekAvailability")
		$result:=APT_Tool_GetWeekAvailability($args)
	: ($fnName="createAppointment")
		$result:=APT_Tool_CreateAppointment($args)
	: ($fnName="cancelAppointment")
		$result:=APT_Tool_CancelAppointment($args)
	: ($fnName="rescheduleAppointment")
		$result:=APT_Tool_RescheduleAppointment($args)
	: ($fnName="listAppointments")
		$result:=APT_Tool_ListAppointments($args)
	: ($fnName="getAppointmentDetails")
		$result:=APT_Tool_GetAppointmentDetails($args)
	: ($fnName="getAppointmentByCode")
		$result:=APT_Tool_GetAppointmentByCode($args)
	: ($fnName="findClient")
		$result:=APT_Tool_FindClient($args)
	: ($fnName="createClient")
		$result:=APT_Tool_CreateClient($args)
	Else 
		$result:={error: "Unknown tool: "+$fnName}
End case 

return $result