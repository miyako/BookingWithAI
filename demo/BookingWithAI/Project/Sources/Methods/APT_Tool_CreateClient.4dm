//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:52:28
// ----------------------------------------------------
// Method: APT_Tool_CreateClient
// Description
//    Registers a new client. Only called when findClient has returned no match.
//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : Object

var $result : Object:={success: False:C215}

Try
	var $firstName : Text
	var $lastName : Text
	$firstName:=APT_TitleCase($params.firstName)
	$lastName:=APT_TitleCase($params.lastName)
	
	If ($firstName="") || ($lastName="")
		$result.error:="Both firstName and lastName are required to create a client - ask the user for whichever is missing."
		return $result
	End if 
	
	// Defensive re-check: if email/phone already matches an existing client (the
	// model skipped findClient, or findClient's own match missed it), resolve to
	// that record instead of creating a duplicate. Only email/phone are checked here
	// (not name) since name matching is fuzzy and more likely to misfire.
	If (($params.email#Null:C1517) && ($params.email#"")) || (($params.phone#Null:C1517) && ($params.phone#""))
		var $existing : cs:C1710.ClientEntity
		$existing:=APT_FindClientEntity({email: $params.email; phone: $params.phone})
		If ($existing#Null:C1517)
			$result.success:=True:C214
			$result.client:={\
				clientID: $existing.clientID; \
				firstName: $existing.firstName; \
				lastName: $existing.lastName\
				}
			return $result
		End if 
	End if 
	
	var $client : cs:C1710.ClientEntity
	$client:=ds:C1482.Client.new()
	$client.firstName:=$firstName
	$client.lastName:=$lastName
	$client.email:=Lowercase:C14(APT_TextOrEmpty($params.email))
	$client.phone:=APT_TextOrEmpty($params.phone)
	$client.createdAt:=Current date:C33
	
	var $status : Object
	$status:=$client.save()
	
	If ($status.success)
		$result.success:=True:C214
		$result.client:={\
			clientID: $client.clientID; \
			firstName: $client.firstName; \
			lastName: $client.lastName\
			}
	Else 
		$result.error:="Failed to create client: "+$status.statusText
	End if 
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result
