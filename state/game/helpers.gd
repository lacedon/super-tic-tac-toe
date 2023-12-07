class_name TTT_State_Helpers

static func getPlayerFieldType(playerSign: TTT_State.PlayerSign) -> TTT_Cell_Resource.FieldType:
	if playerSign == TTT_State.PlayerSign.x:
		return TTT_Cell_Resource.FieldType.x
	else:
		return TTT_Cell_Resource.FieldType.o

static func getEnemyFieldType(playerSign: TTT_State.PlayerSign) -> TTT_Cell_Resource.FieldType:
	if playerSign == TTT_State.PlayerSign.o:
		return TTT_Cell_Resource.FieldType.x
	else:
		return TTT_Cell_Resource.FieldType.o
