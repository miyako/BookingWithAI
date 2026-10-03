//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 
// ----------------------------------------------------
// Method: APT_TextOrEmpty
// Description
//    Returns the text value of the parameter, or "" if the parameter is Null.
//    The objectif is to avoid 4D's String(Null) returning the literal text "null".
//
// Parameters
//    $value : Variant
// ----------------------------------------------------



#DECLARE($value : Variant) : Text

If ($value=Null:C1517)
	return ""
End if 

return String:C10($value)
