//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/03/26, 15:48:50
// ----------------------------------------------------
// Method: APT_WebChat_RunTurn
// Description
//     Drives the public web chat's tool-calling loop synchronously. 
//
// Parameters
// ----------------------------------------------------


#DECLARE($messages : Collection) : Object

var $result : Object:={success: False:C215}
var $openAI : cs:C1710.AIKit.OpenAI
$openAI:=cs:C1710.AIKit.OpenAI.new(APT_GetOpenAIKey)

var $linkedClientID : Text:=""
var $linkedAppointmentID : Text:=""
var $rounds : Integer:=0
var $done : Boolean:=False:C215

// Demo aid: records every tool call made this turn (name/arguments/result) so the
// public web chat can render the same "what just got called" trace the native
// Chat form shows live - this endpoint is synchronous, so it's all sent at once
// alongside the final reply instead of appearing incrementally.
var $trace : Collection:=[]

While (Not:C34($done)) && ($rounds<6)
	$rounds:=$rounds+1
	
	var $completion : cs:C1710.AIKit.OpenAIChatCompletionsResult
	$completion:=$openAI.chat.completions.create($messages; {\
		model: "gpt-5"; \
		tools: APT_GetToolDefinitions; \
		stream: False:C215; \
		max_tokens: 500\
		})
	
	If (Not:C34($completion.success))
		If ($completion.errors#Null:C1517) && ($completion.errors.length>0)
			$result.error:="The AI request failed: "+$completion.errors[0].message
		Else 
			$result.error:="The AI request failed."
		End if 
		return $result
	End if 
	
	var $choice : cs:C1710.AIKit.OpenAIChoice
	$choice:=$completion.choice
	
	If ($choice.finish_reason="tool_calls")
		$messages.push({role: "assistant"; tool_calls: $choice.message.tool_calls})
		
		var $toolCall : Object
		For each ($toolCall; $choice.message.tool_calls)
			var $fnArgs : Object
			$fnArgs:=JSON Parse:C1218($toolCall.function.arguments)
			
			var $toolResult : Object
			$toolResult:=APT_Tool_Dispatch($toolCall.function.name; $fnArgs)
			
			$trace.push({\
				name: $toolCall.function.name; \
				arguments: $toolCall.function.arguments; \
				result: JSON Stringify:C1217($toolResult)\
				})
			
			If ($toolResult.client#Null:C1517)
				$linkedClientID:=$toolResult.client.clientID
			End if 
			If ($toolCall.function.name="createAppointment") && ($toolResult.success)
				$linkedAppointmentID:=$toolResult.appointmentID
			End if 
			
			$messages.push({\
				role: "tool"; \
				tool_call_id: $toolCall.id; \
				content: JSON Stringify:C1217($toolResult)\
				})
		End for each 
		
	Else 
		$result.reply:=APT_TextOrEmpty($choice.message.content)
		$messages.push({role: "assistant"; content: $result.reply})
		$done:=True:C214
	End if 
End while 

If (Not:C34($done))
	$result.error:="The assistant took too many steps to answer - please try rephrasing."
	return $result
End if 

$result.success:=True:C214
$result.messages:=$messages
$result.clientID:=$linkedClientID
$result.appointmentID:=$linkedAppointmentID
$result.trace:=$trace
return $result
