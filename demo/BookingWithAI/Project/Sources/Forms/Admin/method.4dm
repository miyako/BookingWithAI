// Admin form method

var $event : Object
$event:=FORM Event

Case of

	: ($event.code=On Load)
		Form.searchQuery:=""
		Form.appointments:=[]
		Form.currentAppointment:=Null
		Form.activeFilter:="upcoming"
		AdminForm_LoadAppointments("upcoming")

End case
