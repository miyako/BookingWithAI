//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:55:44
// ----------------------------------------------------
// Method: APT_Tool_RescheduleAppointment
// Description
//     Moves an existing appointment to a new date/time, after verifying the new slot is free
//
// Parameters
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
	
	var $newDate : Date
	var $newTime : Time
	$newDate:=Date:C102($params.newDate)
	$newTime:=Time:C179($params.newTime)
	
	var $conflict : cs:C1710.AppointmentSelection
	$conflict:=ds:C1482.Appointment.query("staffID = :1 and date = :2 and time = :3 and status != :4 and appointmentID != :5"; \
		$appt.staffID; $newDate; $newTime; "cancelled"; $appt.appointmentID)
	
	If ($conflict.length>0)
		$result.error:="This slot is no longer available. Please choose another time."
		return $result
	End if 
	
	$appt.date:=$newDate
	$appt.time:=$newTime
	
	var $status : Object
	$status:=$appt.save()
	
	If ($status.success)
		$result.success:=True:C214
		$result.confirmationCode:=$appt.confirmationCode
		$result.date:=String:C10($appt.date; "yyyy-MM-dd")
		$result.time:=String:C10($appt.time; "HH:mm")
	Else 
		$result.error:="Failed to reschedule appointment: "+$status.statusText
	End if 
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result