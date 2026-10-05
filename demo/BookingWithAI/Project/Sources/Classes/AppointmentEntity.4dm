Class extends Entity

Function get clientName($event : Object) -> $clientName : Text
	var $client : cs.ClientEntity
	$client:=ds.Client.query("clientID = :1"; This.clientID).first()
	If ($client#Null)
		$clientName:=$client.fullName
	End if

Function get staffName($event : Object) -> $staffName : Text
	var $staff : cs.StaffEntity
	$staff:=ds.Staff.query("staffID = :1"; This.staffID).first()
	If ($staff#Null)
		$staffName:=$staff.fullName
	End if

Function get statusLabel($event : Object) -> $label : Text
	// Localised display label; the stored status value ("confirmed", "cancelled") is unchanged
	$label:=Localized string("Status_"+String(This.status))
	If ($label="")
		$label:=String(This.status)
	End if

Function orderBy statusLabel($event : Object) -> $order : Text
	$order:="status "+$event.operator
