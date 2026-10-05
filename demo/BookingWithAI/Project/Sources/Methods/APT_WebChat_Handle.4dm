//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 
// ----------------------------------------------------
// Method: APT_WebChat_Handle
// Description
// 
//    Entry point for the public web chat, POST /rest/$catalog/chat.
//    Stateless per-request: the browser holds the conversationID (localStorage) and passes it
//    back each turn; the full message history lives in Conversation.messages.
//
// Parameters
//    $body : Object
// ----------------------------------------------------


#DECLARE($body : Object) : Object

var $result : Object:={success: False:C215}

Try
	var $userMessage : Text
	$userMessage:=APT_TextOrEmpty($body.message)
	
	If ($userMessage="")
		$result.error:=Localized string("WebChat_MessageRequired")
		return $result
	End if 
	
	var $conversationID : Text
	$conversationID:=APT_TextOrEmpty($body.conversationID)
	
	var $conv : cs:C1710.ConversationEntity
	$conv:=Null:C1517
	If ($conversationID#"")
		$conv:=ds:C1482.Conversation.query("conversationID = :1"; $conversationID).first()
	End if 
	
	var $messages : Collection
	If ($conv=Null:C1517)
		$conv:=ds:C1482.Conversation.new()
		$conv.messages:="[]"
		$conv.startedAt:=String:C10(Current date:C33; "yyyy-MM-dd")+"T"+String:C10(Current time:C178; "HH:mm:ss")
		$conv.save()
		$messages:=[{role: "system"; content: APT_SystemPrompt}]
	Else 
		$messages:=JSON Parse:C1218($conv.messages)
		If ($messages.length>0) && ($messages[0].role="system")
			$messages[0].content:=APT_SystemPrompt
		Else 
			$messages.unshift({role: "system"; content: APT_SystemPrompt})
		End if 
	End if 
	
	$messages.push({role: "user"; content: $userMessage})
	
	var $turn : Object
	$turn:=APT_WebChat_RunTurn($messages)
	
	If (Not:C34($turn.success))
		$result.error:=$turn.error
		return $result
	End if 
	
	$conv.messages:=JSON Stringify:C1217($turn.messages)
	If ($turn.clientID#"")
		$conv.clientID:=$turn.clientID
	End if 
	If ($turn.appointmentID#"")
		$conv.appointmentID:=$turn.appointmentID
	End if 
	$conv.save()
	
	$result.success:=True:C214
	$result.conversationID:=$conv.conversationID
	$result.reply:=$turn.reply
	$result.trace:=$turn.trace
	
Catch
	$result.error:=Last errors:C1799.first().message
End try

return $result
