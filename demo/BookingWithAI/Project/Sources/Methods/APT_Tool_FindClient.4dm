//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:53:01
// ----------------------------------------------------
// Method: APT_Tool_FindClient
// Description
//     Searches for an existing client by name, email, or phone
//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={found: False:C215; client: Null:C1517}

Try
	var $match : cs:C1710.ClientEntity
	$match:=APT_FindClientEntity($params)
	
	If ($match#Null:C1517)
		$result.found:=True:C214
		$result.client:={\
			clientID: $match.clientID; \
			firstName: $match.firstName; \
			lastName: $match.lastName; \
			email: $match.email; \
			phone: $match.phone\
			}
	End if 
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result
