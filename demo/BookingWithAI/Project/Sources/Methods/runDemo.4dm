//%attributes = {}
#DECLARE($params : Object)

var $title : Text
$title:=Localized string("Splash_WindowTitle")

var $window : Integer

If (Count parameters:C259=0)
	
	// Splash already open? Bring it to the front instead of opening a second one
	ARRAY LONGINT($windows; 0)
	WINDOW LIST($windows)
	var $i : Integer
	For ($i; 1; Size of array($windows))
		$window:=$windows{$i}
		If (Window process($window)=1) && (Get window title($window)=$title)
			var $left; $top; $right; $bottom : Integer
			GET WINDOW RECT($left; $top; $right; $bottom; $window)
			CALL FORM($window; Formula(SET WINDOW RECT($left; $top; $right; $bottom; $window)))
			return 
		End if 
	End for 
	
	CALL WORKER(1; Current method name:C684; {})
	
Else 
	
	SET MENU BAR(1)
	$window:=Open form window:C675("Splash"; Plain form window:K39:10; Horizontally centered; Vertically centered)
	SET WINDOW TITLE($title; $window)
	DIALOG:C40("Splash"; *)
	
End if 
