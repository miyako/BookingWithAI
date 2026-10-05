//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:54:32
// ----------------------------------------------------
// Method: APT_Tool_ListAppointments
// Description
//    Lists a client's appointments: upcoming (default), past, or all
//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={appointments: []}

Try
	var $filter : Text
	$filter:=APT_TextOrEmpty($params.filter)
	
	var $appts : cs:C1710.AppointmentSelection
	Case of 
		: ($filter="past")
			$appts:=ds:C1482.Appointment.query("clientID = :1 and date < :2"; $params.clientID; Current date:C33)
		: ($filter="all")
			$appts:=ds:C1482.Appointment.query("clientID = :1"; $params.clientID)
		Else 
			$appts:=ds:C1482.Appointment.query("clientID = :1 and date >= :2 and status != :3"; $params.clientID; Current date:C33; "cancelled")
	End case 
	
	$appts:=$appts.orderBy("date asc, time asc")
	
	var $appt : cs:C1710.AppointmentEntity
	For each ($appt; $appts)
		$result.appointments.push({\
			confirmationCode: $appt.confirmationCode; \
			date: String:C10($appt.date; "yyyy-MM-dd"); \
			time: String:C10(Time:C179($appt.time); "HH:mm"); \
			staffName: $appt.staffName; \
			status: $appt.status; \
			reason: $appt.reason\
			})
	End for each
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result