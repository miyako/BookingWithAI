// Extends the datastore singleton so the public web chat can call it via ORDA REST:
// POST /rest/$catalog/chat  with body  [{"conversationID": "...", "message": "..."}]
// (REST class-function calls take a JSON array of positional parameters - one array
// entry per declared function argument, wrapped by 4D into {"result": ...} on return.)

Class extends DataStoreImplementation

exposed Function chat($body : Object) : Object
	return APT_WebChat_Handle($body)
