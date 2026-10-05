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
	$nameParts:=Split string:C1554(Replace string($query; Char(12288); " "); " "; sk ignore empty strings:K86:1)
	
	If ($nameParts.length>=2)
		// Japanese order (family name first) or Western order
		$clients:=ds:C1482.Client.query("(lastName = :1 and firstName = :2) or (firstName = :1 and lastName = :2)"; "@"+$nameParts[0]+"@"; "@"+$nameParts[$nameParts.length-1]+"@")
	Else 
		$clients:=ds:C1482.Client.query("firstName = :1 or lastName = :1"; "@"+$query+"@")
		If ($clients.length=0)
			// Full name typed without a space, e.g. 高橋結衣
			var $c : cs:C1710.ClientEntity
			$clients:=ds:C1482.Client.newSelection()
			For each ($c; ds:C1482.Client.all())
				If ((Position($query; $c.lastName+$c.firstName)>0) || (Position($query; $c.firstName+$c.lastName)>0))
					$clients.add($c)
				End if 
			End for each 
		End if 
	End if 
	
	If ($clients.length>0)
		$appts:=ds:C1482.Appointment.query("clientID IN :1"; $clients.extract("clientID"))
	End if 
End if 

Form:C1466.appointments:=$appts.orderBy("date desc, time desc")
Form:C1466.currentAppointment:=Null:C1517
