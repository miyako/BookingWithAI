//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/03/26, 17:57:30
// ----------------------------------------------------
// Method: AdminForm_LoadAppointments
// Description
//    Loads appointments based on a filter 
//
// Parameters
//    $filter : Text
// ----------------------------------------------------


#DECLARE($filter : Text)

Form:C1466.activeFilter:=$filter

var $appts : cs:C1710.AppointmentSelection
Case of 
	: ($filter="past")
		$appts:=ds:C1482.Appointment.query("date < :1"; Current date:C33).orderBy("date desc, time desc")
	: ($filter="cancelled")
		$appts:=ds:C1482.Appointment.query("status = :1"; "cancelled").orderBy("date desc, time desc")
	: ($filter="all")
		$appts:=ds:C1482.Appointment.all().orderBy("date desc, time desc")
	Else 
		$appts:=ds:C1482.Appointment.query("date >= :1 and status != :2"; Current date:C33; "cancelled").orderBy("date asc, time asc")
End case 

Form:C1466.appointments:=$appts
Form:C1466.currentAppointment:=Null:C1517
