//%attributes = {}
// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/04/26, 16:30:20
// ----------------------------------------------------
// Method: APT_GetOpenAIKey
// Description
//     Reads the OpenAI API key from Project/Sources/AIProviders.json, the 4D AIKit
//     provider settings file (gitignored, never committed). Copy AIProviders.example.json
//     to AIProviders.json in the same folder and set your own key, or use the AI page of
//     the 4D Settings. Uses the provider whose baseURL is api.openai.com, otherwise the first
//     provider that has an apiKey.
//
// Parameters
// ----------------------------------------------------


#DECLARE() : Text

var $config : Object

Try
	$config:=JSON Parse:C1218(File("/SOURCES/AIProviders.json").getText())
Catch
	$config:=Null:C1517
End try

var $apiKey : Text:=""

If ($config#Null:C1517) && ($config.providers#Null:C1517)
	var $name : Text
	var $provider : Object
	For each ($name; $config.providers)
		$provider:=$config.providers[$name]
		If (String:C10($provider.apiKey)#"")
			If ($apiKey="") || (Position:C15("api.openai.com"; String:C10($provider.baseURL))>0)
				$apiKey:=String:C10($provider.apiKey)
			End if 
		End if 
	End for each 
End if 

If ($apiKey="")
	ALERT:C41(Localized string("AlertMissingAIProvider"))
End if 

return $apiKey
