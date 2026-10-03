//%attributes = {}
#DECLARE($OK : Integer)
If (Count parameters:C259=0)
	BRING TO FRONT:C326(New process:C317(Current method name:C684; 0; "Splash"; 1; *))
Else 
	var $win_l : Integer
	var $formName_t : Text
	$formName_t:="Splash"
	$win_l:=Open form window:C675($formName_t)
	DIALOG:C40($formName_t)
	CLOSE WINDOW:C154($win_l)
End if 
