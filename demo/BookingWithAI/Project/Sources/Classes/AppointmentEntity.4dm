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
