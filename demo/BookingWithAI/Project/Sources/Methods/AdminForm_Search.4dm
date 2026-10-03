//%attributes = {}
// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 
// ----------------------------------------------------
// Method: AdminForm_Search
// Description
//     Searches appointments by confirmation code or client name, using Form.searchQuery
//
// Parameters
// ----------------------------------------------------


#DECLARE()

If (Form:C1466.searchQuery="")
	AdminForm_LoadAppointments(Form:C1466.activeFilter)
	return 
End if 

var $query : Text
$query:=Trim:C1853(Form:C1466.searchQuery)

var $appts : cs:C1710.AppointmentSelection
$appts:=ds:C1482.Appointment.query("confirmationCode = :1"; "@"+Uppercase:C13($query)+"@")

If ($appts.length=0)
	
	var $clients : cs:C1710.ClientSelection
	var $nameParts : Collection
	$nameParts:=Split string:C1554($query; " ")
	
	If ($nameParts.length>=2)
		$clients:=ds:C1482.Client.query("firstName = :1 and lastName = :2"; "@"+$nameParts[0]+"@"; "@"+$nameParts[$nameParts.length-1]+"@")
	Else 
		$clients:=ds:C1482.Client.query("firstName = :1 or lastName = :1"; "@"+$query+"@")
	End if 
	
	If ($clients.length>0)
		$appts:=ds:C1482.Appointment.query("clientID IN :1"; $clients.extract("clientID"))
	End if 
End if 

Form:C1466.appointments:=$appts.orderBy("date desc, time desc")
Form:C1466.currentAppointment:=Null:C1517
