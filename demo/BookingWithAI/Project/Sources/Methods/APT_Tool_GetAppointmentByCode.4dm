//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:53:17
// ----------------------------------------------------
// Method: APT_Tool_GetAppointmentByCode
// Description
//     Looks up an appointment by its human-readable APT-XXXXXX confirmation code
//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={found: False:C215}

Try
	var $appt : cs:C1710.AppointmentEntity
	$appt:=ds:C1482.Appointment.query("confirmationCode = :1"; Uppercase:C13(String:C10($params.confirmationCode))).first()
	
	If ($appt=Null:C1517)
		return $result
	End if 
	
	return APT_Tool_GetAppointmentDetails({appointmentID: $appt.appointmentID})
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result