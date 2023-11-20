# TODO: Refactor code to prefer edge cells if enemy stays in the center
# 1 2 1
# 2 x 2
# 1 2 1

const lines = [
	{ start = 0, stepSize = 1 },
	{ start = 0, stepSize = 3 },
	{ start = 0, stepSize = 4 },
	{ start = 1, stepSize = 3 },
	{ start = 2, stepSize = 2 },
	{ start = 2, stepSize = 3 },
	{ start = 3, stepSize = 1 },
	{ start = 6, stepSize = 1 },
]
const middleCell: = 4

static func _getClosingCells(playerSign: TTT_State.PlayerSign, fieldList: Array[TTT_Cell_Resource]) -> Array[Array]:
	var playerFieldType: = TTT_Cell_Resource.FieldType.x if playerSign == TTT_State.PlayerSign.x else TTT_Cell_Resource.FieldType.o
	var enemyFieldType: = TTT_Cell_Resource.FieldType.o if playerSign == TTT_State.PlayerSign.x else TTT_Cell_Resource.FieldType.x
	var result: Array[Array] = [
		[], # Finish my 2-cell line
		[], # Block enemy's 2-cell line
		[], # Continue my 1-cell line
		[], # Block enemy's 1-cell line
		[], # Free cell
	]

	for line in lines:
		var possiblePoints: Array[int] = []
		var currentPlayerListItemNumber: int = 0
		var enemyListItemNumber: int = 0

		for step in range(3):
			var index: int = line.start + step * line.stepSize
			var fieldType: TTT_Cell_Resource.FieldType = fieldList[index].type

			match (fieldType):
				playerFieldType:
					currentPlayerListItemNumber += 1
				enemyFieldType:
					enemyListItemNumber += 1
				TTT_Cell_Resource.FieldType.none:
					possiblePoints.append(index)
				TTT_Cell_Resource.FieldType.field:
					if TTT_State_Selectors.getIsFieldAvailable(fieldList[index].inner):
						possiblePoints.append(index)

		if currentPlayerListItemNumber == 2:
			result[0].append_array(possiblePoints)
		elif enemyListItemNumber == 2:
			result[1].append_array(possiblePoints)
		elif enemyListItemNumber == 1:
			result[3].append_array(possiblePoints)
		elif currentPlayerListItemNumber == 1:
			result[2].append_array(possiblePoints)
		else:
			result[4].append_array(possiblePoints)

	return result

static func getCellsToChoose(state: TTT_State, openBlock: int, playerSign: TTT_State.PlayerSign) -> Array[int]:
	var closingCellsList = _getClosingCells(playerSign, TTT_State_Selectors.getFieldList(state, openBlock))

	var result: Array[int] = []
	for closingCells in closingCellsList:
		if closingCells.size() > 0:
			if closingCells.has(middleCell):
				result.append(middleCell)
			else:
				result.append_array(closingCells)
			break
	return result
