//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/05/26, 06:50:27
// ----------------------------------------------------
// Method: APT_Open
// Description
//     Application entry point. Opens the staff panel.
//
// Parameters
// ----------------------------------------------------


var $win : Integer:=Open form window:C675("Admin"; Plain form window:K39:10)
DIALOG:C40("Admin")
CLOSE WINDOW:C154($win)
