class_name TTT_State_Helpers

static func getPlayerFieldType(playerSign: TTT_State.PlayerSign) -> TTT_Cell_Resource.FieldType:
	if playerSign == TTT_State.PlayerSign.x: return TTT_Cell_Resource.FieldType.x
	else: return TTT_Cell_Resource.FieldType.o

static func getEnemyFieldType(playerSign: TTT_State.PlayerSign) -> TTT_Cell_Resource.FieldType:
	if playerSign == TTT_State.PlayerSign.o: return TTT_Cell_Resource.FieldType.x
	else: return TTT_Cell_Resource.FieldType.o

static func getPlayerSignByFieldType(fieldType: TTT_Cell_Resource.FieldType) -> TTT_State.PlayerSign:
	if fieldType == TTT_Cell_Resource.FieldType.o: return TTT_State.PlayerSign.o
	else: return TTT_State.PlayerSign.x

static func getOppositePlayer(playerSign: TTT_State.PlayerSign) -> TTT_State.PlayerSign:
	if playerSign == TTT_State.PlayerSign.o: return TTT_State.PlayerSign.x
	else: return TTT_State.PlayerSign.o
