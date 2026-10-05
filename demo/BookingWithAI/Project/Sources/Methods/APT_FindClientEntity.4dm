//%attributes = {}
// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 
// ----------------------------------------------------
// Method: APT_FindClientEntity
// Description
//    Finds a client entity by email, phone, or full name. Matching is done in plain
//    4D code with explicit Uppercase() comparisons on both sides, rather than the
//    ORDA query() string DSL - see APT_Tool_FindClient for why.
//    Shared by APT_Tool_FindClient and APT_Tool_CreateClient's duplicate check.
//
// Parameters
// ----------------------------------------------------


#DECLARE($params : Object) : cs:C1710.ClientEntity

var $match : cs:C1710.ClientEntity
$match:=Null:C1517

var $c : cs:C1710.ClientEntity

If ($params.email#Null:C1517) && ($params.email#"")
	var $searchEmail : Text
	$searchEmail:=Uppercase:C13(Trim:C1853($params.email))
	
	For each ($c; ds:C1482.Client.all())
		If (Uppercase:C13(String:C10($c.email))=$searchEmail)
			$match:=$c
		End if 
	End for each 
End if 
If (($params.phone#Null:C1517) && ($params.phone#""))
	// Compare digits only, ignoring the trunk prefix "0" and a country code of up to 3 digits,
	// so "+81 90 1234 5678" and "090-1234-5678" match regardless of spacing/punctuation.
	var $searchPhone; $clientPhone; $long; $short : Text
	$searchPhone:=APT_DigitsOnly($params.phone)
	While (Substring:C12($searchPhone; 1; 1)="0")
		$searchPhone:=Substring:C12($searchPhone; 2)
	End while 
	
	If (Length:C16($searchPhone)>=8)
		For each ($c; ds:C1482.Client.all())
			$clientPhone:=APT_DigitsOnly(String:C10($c.phone))
			While (Substring:C12($clientPhone; 1; 1)="0")
				$clientPhone:=Substring:C12($clientPhone; 2)
			End while 
			If (Length:C16($clientPhone)>=Length:C16($searchPhone))
				$long:=$clientPhone
				$short:=$searchPhone
			Else 
				$long:=$searchPhone
				$short:=$clientPhone
			End if 
			If ((Length:C16($short)>=8) && ((Length:C16($long)-Length:C16($short))<=3) && (Substring:C12($long; Length:C16($long)-Length:C16($short)+1)=$short))
				$match:=$c
			End if 
		End for each 
	End if 
End if 
If ($params.name#Null:C1517) && ($params.name#"")
	// Japanese names: accept family-name-first or given-name-first, with or without a (full-width) space
	var $searchName : Text
	$searchName:=Uppercase:C13(Trim:C1853($params.name))
	$searchName:=Replace string(Replace string($searchName; Char(12288); ""); " "; "")
	
	var $first; $last : Text
	For each ($c; ds:C1482.Client.all())
		$first:=Uppercase:C13(String:C10($c.firstName))
		$last:=Uppercase:C13(String:C10($c.lastName))
		If (($searchName=($last+$first)) || ($searchName=($first+$last)) || ($searchName=$last) || ($searchName=$first))
			$match:=$c
		End if 
	End for each 
End if 

return $match
