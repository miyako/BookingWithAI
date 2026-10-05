//%attributes = {}
// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 
// ----------------------------------------------------
// Method: APT_ComputeFreeSlots
// Description
//    Computes free appointment start times for one staff member on one date,
//    based on their weekly Availability windows minus already-booked (non-cancelled) Appointments.
//    Shared by APT_Tool_CheckAvailability and APT_Tool_GetNextAvailable.
//
// Parameters
// ----------------------------------------------------

#DECLARE($staff : cs:C1710.StaffEntity; $date : Date) : Collection

var $slots : Collection:=[]

// Day number: 1=Sunday..7=Saturday. Availability.dayOfWeek uses ISO: 1=Monday..7=Sunday.
var $dow : Integer
$dow:=Day number:C114($date)-1
If ($dow=0)
	$dow:=7
End if 

var $windows : cs:C1710.AvailabilitySelection
$windows:=ds:C1482.Availability.query("staffID = :1 and dayOfWeek = :2"; $staff.staffID; $dow)

var $booked : cs:C1710.AppointmentSelection
$booked:=ds:C1482.Appointment.query("staffID = :1 and date = :2 and status != :3"; $staff.staffID; $date; "cancelled")

var $window : cs:C1710.AvailabilityEntity
For each ($window; $windows)
	var $slotStart : Time
	$slotStart:=$window.startTime
	
	While (($slotStart+($staff.slotDuration*60))<=$window.endTime)
		var $slotEnd : Time
		$slotEnd:=$slotStart+($staff.slotDuration*60)
		
		var $isFree : Boolean
		$isFree:=True:C214
		
		var $appt : cs:C1710.AppointmentEntity
		For each ($appt; $booked)
			If (($slotStart<($appt.time+($appt.duration*60))) && ($slotEnd>$appt.time))
				$isFree:=False:C215
			End if 
		End for each 
		
		If ($isFree)
			$slots.push($slotStart)
		End if 
		
		$slotStart:=$slotEnd
	End while 
End for each 

return $slots