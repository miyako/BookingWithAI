//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time:
// ----------------------------------------------------
// Method: AdminForm_CancelSelected
// Description
//   Cancels the currently selected appointment in the listbox
//
// Parameters
// ----------------------------------------------------


#DECLARE()

If (Form:C1466.currentAppointment=Null:C1517)
	ALERT:C41(Localized string("AlertSelectAppointment"))
	return 
End if 

var $status : Object
$status:=APT_Tool_CancelAppointment({appointmentID: Form:C1466.currentAppointment.appointmentID})

If ($status.success)
	AdminForm_LoadAppointments(Form:C1466.activeFilter)
Else 
	ALERT:C41($status.error)
End if 
