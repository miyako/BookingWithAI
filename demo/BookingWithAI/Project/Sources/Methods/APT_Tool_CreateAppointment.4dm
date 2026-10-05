//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:52:13
// ----------------------------------------------------
// Method: APT_Tool_CreateAppointment
// Description
//     Books an appointment slot and generates a confirmation code. findClient must have run first.

//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={success: False:C215}

Try
	var $requestedDate : Date
	var $requestedTime : Time
	$requestedDate:=Date:C102($params.date)
	$requestedTime:=Time:C179($params.time)
	
	var $existing : cs:C1710.AppointmentSelection
	$existing:=ds:C1482.Appointment.query("staffID = :1 and date = :2 and time = :3 and status != :4"; \
		$params.staffID; $requestedDate; $requestedTime; "cancelled")
	
	If ($existing.length>0)
		$result.error:="This slot is no longer available. Please choose another time."
		return $result
	End if 
	
	var $staff : cs:C1710.StaffEntity
	$staff:=ds:C1482.Staff.query("staffID = :1"; $params.staffID).first()
	
	If ($staff=Null:C1517)
		$result.error:="Staff member not found"
		return $result
	End if 
	
	var $code : Text
	var $isUnique : Boolean
	$isUnique:=False:C215
	While (Not:C34($isUnique))
		$code:="APT-"+Uppercase:C13(Substring:C12(Generate UUID:C1066; 1; 6))
		$isUnique:=(ds:C1482.Appointment.query("confirmationCode = :1"; $code).length=0)
	End while 
	
	var $appt : cs:C1710.AppointmentEntity
	$appt:=ds:C1482.Appointment.new()
	$appt.confirmationCode:=$code
	$appt.clientID:=$params.clientID
	$appt.staffID:=$params.staffID
	$appt.date:=$requestedDate
	$appt.time:=$requestedTime
	$appt.duration:=$staff.slotDuration
	$appt.reason:=APT_TextOrEmpty($params.reason)
	$appt.status:="confirmed"
	$appt.createdAt:=Current date:C33
	
	var $status : Object
	$status:=$appt.save()
	
	If ($status.success)
		$result.success:=True:C214
		$result.appointmentID:=$appt.appointmentID
		$result.confirmationCode:=$appt.confirmationCode
		$result.date:=String:C10($appt.date; "yyyy-MM-dd")
		$result.time:=String:C10(Time:C179($appt.time); "HH:mm")
		$result.staffName:=$staff.fullName
	Else 
		$result.error:="Failed to create appointment: "+$status.statusText
	End if 
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result