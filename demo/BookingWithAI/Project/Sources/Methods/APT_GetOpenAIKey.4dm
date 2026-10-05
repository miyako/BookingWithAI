//%attributes = {}
// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/04/26, 16:30:20
// ----------------------------------------------------
// Method: APT_GetOpenAIKey
// Description
//     Reads the OpenAI API key from Resources/AIProvider.json (gitignored, never committed).
//     Copy Resources/AIProvider.example.json to Resources/AIProvider.json and set your own key.
//
// Parameters
// ----------------------------------------------------


#DECLARE() : Text

var $config : Object

Try
	$config:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("AIProvider.json").getText())
Catch
	ALERT:C41(Localized string("AlertMissingAIProvider"))
	return ""
End try

return String:C10($config.apiKey)
