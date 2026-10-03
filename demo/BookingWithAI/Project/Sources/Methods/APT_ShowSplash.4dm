//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time:
// ----------------------------------------------------
// Method: APT_ShowSplash
// Description
//     Shows the startup splash screen, then opens the staff panel once dismissed.
//
// Parameters
// ----------------------------------------------------


var $win : Integer:=Open form window:C675("Splash"; Plain form window:K39:10)
DIALOG:C40("Splash")
CLOSE WINDOW:C154($win)
APT_Open
