Class extends Entity

Function get fullName($event : Object) -> $fullName : Text
	// Japanese order: family name first
	$fullName:=This.lastName+" "+This.firstName
