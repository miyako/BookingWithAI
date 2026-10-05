//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:53:31
// ----------------------------------------------------
// Method: APT_Tool_GetAppointmentDetails
// Description
//     Retrieves full details for one appointment by its internal appointment ID
//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={found: False:C215}

Try
	var $appt : cs:C1710.AppointmentEntity
	$appt:=ds:C1482.Appointment.query("appointmentID = :1"; $params.appointmentID).first()
	
	If ($appt=Null:C1517)
		return $result
	End if 
	
	$result.found:=True:C214
	$result.appointmentID:=$appt.appointmentID
	$result.confirmationCode:=$appt.confirmationCode
	$result.date:=String:C10($appt.date; "yyyy-MM-dd")
	$result.time:=String:C10(Time:C179($appt.time); "HH:mm")
	$result.duration:=$appt.duration
	$result.reason:=$appt.reason
	$result.status:=$appt.status
	
	$result.clientName:=$appt.clientName
	$result.staffName:=$appt.staffName
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result