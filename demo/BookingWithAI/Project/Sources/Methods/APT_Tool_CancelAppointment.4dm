//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/03/26, 17:56:54
// ----------------------------------------------------
// Method: APT_Tool_CancelAppointment
// Description
//    Cancels an existing appointment by its internal appointment ID
//
// Parameters
//    $params : Object
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={success: False:C215}

Try
	var $appt : cs:C1710.AppointmentEntity
	$appt:=ds:C1482.Appointment.query("appointmentID = :1"; $params.appointmentID).first()
	
	If ($appt=Null:C1517)
		$result.error:="Appointment not found"
		return $result
	End if 
	
	$appt.status:="cancelled"
	
	var $status : Object
	$status:=$appt.save()
	
	If ($status.success)
		$result.success:=True:C214
		$result.confirmationCode:=$appt.confirmationCode
	Else 
		$result.error:="Failed to cancel appointment: "+$status.statusText
	End if 
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result