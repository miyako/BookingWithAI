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
	// Compare digits only, so "+33 6 12 34 56 78" and "0612345678"-style variants
	// of the same number still match regardless of spacing/punctuation differences.
	var $searchPhone : Text
	$searchPhone:=APT_DigitsOnly($params.phone)
	
	For each ($c; ds:C1482.Client.all())
		If (APT_DigitsOnly(String:C10($c.phone))=$searchPhone)
			$match:=$c
		End if 
	End for each 
End if 
If ($params.name#Null:C1517) && ($params.name#"")
	var $nameParts : Collection
	$nameParts:=Split string:C1554(Uppercase:C13(Trim:C1853($params.name)); " ")

	var $searchFullName : Text
	If ($nameParts.length>=2)
		$searchFullName:=$nameParts[0]+" "+$nameParts[$nameParts.length-1]
	End if

	For each ($c; ds:C1482.Client.all())
		If ($nameParts.length>=2)
			If (Uppercase:C13($c.fullName)=$searchFullName)
				$match:=$c
			End if
		Else
			If ((Uppercase:C13($c.firstName)=$nameParts[0]) || (Uppercase:C13($c.lastName)=$nameParts[0]))
				$match:=$c
			End if
		End if
	End for each
End if

return $match
