//%attributes = {}

// ----------------------------------------------------
// User name (OS): Soukaina Bachikh
// Date and time: 08/04/26, 18:39:27
// ----------------------------------------------------
// Method: APT_GetToolDefinitions
// Description
//    Builds the AIKit tools collection (function-calling schema) passed to
//    $openAI.chat.completions.create() via the "tools" parameter.
//    Uses cs.AIKit.OpenAITool.new() with the simplified {name; description; parameters} format.
//
// Parameters
// ----------------------------------------------------


#DECLARE() : Collection

var $tools : Collection:=[]

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "checkAvailability"; \
description: "Lists free appointment slots for a given date, optionally filtered to one staff member."; \
parameters: {\
type: "object"; \
properties: {\
date: {type: "string"; description: "Date to check, formatted YYYY-MM-DD"}; \
staffID: {type: "string"; description: "Optional staff member UUID to filter to"}\
}; \
required: ["date"]\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "getStaffList"; \
description: "Lists active staff members, optionally filtered by specialty. When looking for a specific staff member by name, omit the specialty filter and match the name yourself from the full list - a wrong specialty guess will make it look like they don't exist."; \
parameters: {\
type: "object"; \
properties: {\
specialty: {type: "string"; description: "Optional specialty filter, e.g. Cardiology. Do not use this when searching for a specific named staff member - leave it empty and match by name from the full list instead."}\
}; \
required: []\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "getNextAvailable"; \
description: "Finds the next free slot for a specific staff member, searching forward from a date."; \
parameters: {\
type: "object"; \
properties: {\
staffID: {type: "string"; description: "Staff member UUID"}; \
fromDate: {type: "string"; description: "Optional date to search from, formatted YYYY-MM-DD. Defaults to today."}\
}; \
required: ["staffID"]\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "getWeekAvailability"; \
description: "Lists free slots for a specific staff member across the next 7 days from a date. Use this to proactively suggest alternative days when a specifically requested date/time is not available, instead of just reporting failure."; \
parameters: {\
type: "object"; \
properties: {\
staffID: {type: "string"; description: "Staff member UUID"}; \
fromDate: {type: "string"; description: "Optional date to start from, formatted YYYY-MM-DD. Defaults to today."}\
}; \
required: ["staffID"]\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "createAppointment"; \
description: "Books an appointment slot for a resolved client and generates a confirmation code. findClient must be called first."; \
parameters: {\
type: "object"; \
properties: {\
clientID: {type: "string"; description: "Client UUID resolved via findClient or createClient"}; \
staffID: {type: "string"; description: "Staff member UUID"}; \
date: {type: "string"; description: "Date formatted YYYY-MM-DD"}; \
time: {type: "string"; description: "Time formatted HH:MM"}; \
reason: {type: "string"; description: "Optional note describing the reason for the visit"}\
}; \
required: ["clientID"; "staffID"; "date"; "time"]\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "cancelAppointment"; \
description: "Cancels an existing appointment by its internal appointment ID."; \
parameters: {\
type: "object"; \
properties: {\
appointmentID: {type: "string"; description: "Internal appointment UUID"}\
}; \
required: ["appointmentID"]\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "rescheduleAppointment"; \
description: "Moves an existing appointment to a new date/time, after verifying the new slot is free."; \
parameters: {\
type: "object"; \
properties: {\
appointmentID: {type: "string"; description: "Internal appointment UUID"}; \
newDate: {type: "string"; description: "New date formatted YYYY-MM-DD"}; \
newTime: {type: "string"; description: "New time formatted HH:MM"}\
}; \
required: ["appointmentID"; "newDate"; "newTime"]\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "listAppointments"; \
description: "Lists a client's appointments."; \
parameters: {\
type: "object"; \
properties: {\
clientID: {type: "string"; description: "Client UUID"}; \
filter: {type: "string"; description: "One of: upcoming, past, all. Defaults to upcoming."}\
}; \
required: ["clientID"]\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "getAppointmentDetails"; \
description: "Retrieves full details for one appointment by its internal appointment ID."; \
parameters: {\
type: "object"; \
properties: {\
appointmentID: {type: "string"; description: "Internal appointment UUID"}\
}; \
required: ["appointmentID"]\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "getAppointmentByCode"; \
description: "Looks up an appointment by its human-readable APT-XXXXXX confirmation code. Call this immediately whenever the user mentions a confirmation code."; \
parameters: {\
type: "object"; \
properties: {\
confirmationCode: {type: "string"; description: "Confirmation code, e.g. APT-A7X3K2"}\
}; \
required: ["confirmationCode"]\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "findClient"; \
description: "Searches for an existing client by name, email, or phone. Always call this before createAppointment or createClient."; \
parameters: {\
type: "object"; \
properties: {\
name: {type: "string"; description: "Full name to search for"}; \
email: {type: "string"; description: "Email address to search for"}; \
phone: {type: "string"; description: "Phone number to search for"}\
}; \
required: []\
}\
}))

$tools.push(cs:C1710.AIKit.OpenAITool.new({\
name: "createClient"; \
description: "Registers a new client. Only call this when findClient has returned no match."; \
parameters: {\
type: "object"; \
properties: {\
firstName: {type: "string"}; \
lastName: {type: "string"}; \
email: {type: "string"}; \
phone: {type: "string"}\
}; \
required: ["firstName"; "lastName"]\
}\
}))

return $tools