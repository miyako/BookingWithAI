//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/04/26, 18:38:12
// ----------------------------------------------------
// Method: APT_DigitsOnly
// Description
//    Strips everything except digits 0-9 from $1, so phone numbers can be compared
//    regardless of spacing, dashes, parentheses, or a leading "+".
//
// Parameters
// ----------------------------------------------------


#DECLARE($value : Text) : Text

var $result : Text:=""
var $i : Integer
var $char : Text

For ($i; 1; Length:C16($value))
	$char:=Substring:C12($value; $i; 1)
	If (($char>="0") && ($char<="9"))
		$result:=$result+$char
	End if 
End for 

return $result
