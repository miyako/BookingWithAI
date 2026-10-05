//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:51:25
// ----------------------------------------------------
// Method: APT_TitleCase
// Description
//    Capitalizes the first letter of each word, lowercasing the rest.
//    Used to normalize client-provided names for consistent display/storage,
//    regardless of how the user typed them ("soukaina" -> "Soukaina").
//    Accepts Variant (not Text) since callers may pass a Null value straight
//    from a tool argument the model omitted, despite it being "required".
//
// Parameters
// ----------------------------------------------------



#DECLARE($value : Variant) : Text

If ($value=Null:C1517)
	return ""
End if 

var $words : Collection
$words:=Split string:C1554(Trim:C1853(String:C10($value)); " ")

var $result : Collection:=[]
var $word : Text
For each ($word; $words)
	If ($word#"")
		$result.push(Uppercase:C13(Substring:C12($word; 1; 1))+Lowercase:C14(Substring:C12($word; 2)))
	End if 
End for each 

return $result.join(" ")
