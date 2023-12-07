const easyAI = preload('./easy.gd')

enum FieldCategory {
	won, # Field's already has player's sign
	lost, # Field's already has enemy's sign
	winnable, # There's just one turn before win
	lossable, # There's just one turn before lose
	canBeContinued, # There's just one sign in a row
	enemyCanBeContinued, # There's just one enemy sign in a row
	empty, # There's no any signs
}

enum CellCategory {
	won, # Cell's already has player's sign
	lost, # Cell's already has enemy's sign
	winnable, # Choose this cell to win
	lossable, # Enemy can choose this cell to win
	canBeContinued, # Player has one sign in the row
	enemyCanBeContinued, # Enemy has one sign in the row
	empty, # There's no cells in the row
}

enum LineType {
	twoPlayerSigns,
	twoEnemySigns,
	onePlayerSign,
	oneEnemySign,
	empty,
	other,
	notBelongToCell,
}

const minCellWeight: int = -1000

const lineWeighs = {
	twoPlayerSigns = 10,
	twoEnemySigns = 5,
	onePlayerSign = 3,
	oneEnemySign = 2,
	empty = 1,
	other = 0,
	notBelongToCell = 0,
}

const fieldDefenceWeighs = {
	blocked = -2,
	blockedMinor = 0,
	empty = 2,
	hasOnePlayerLine = 1,
	hasTwoSignPlayerLineBase = -1,
	hasTwoSignPlayerLineWithAdvance = 2,
	hasTwoSignEnemyLineBase = -1,
	hasTwoSignEnemyLineWithAdvance = 1,
}

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

static func _getLineType(
	playerFieldType: TTT_Cell_Resource.FieldType,
	enemyFieldType: TTT_Cell_Resource.FieldType,
	localFieldList: Array[TTT_Cell_Resource],
	includedCellIndex: int,
	lineStart: int,
	lineStepSize: int,
) -> LineType:
	var currentPlayerListItemNumber: int = 0
	var enemyListItemNumber: int = 0
	var blockedFieldNumber: int = 0
	var isCellBelongToLine: bool = false

	for step in range(3):
		var index: int = lineStart + step * lineStepSize
		var fieldType: TTT_Cell_Resource.FieldType = localFieldList[index].type
		isCellBelongToLine = isCellBelongToLine || index == includedCellIndex || includedCellIndex == -1

		match fieldType:
			playerFieldType:
				currentPlayerListItemNumber += 1
			enemyFieldType:
				enemyListItemNumber += 1
			TTT_Cell_Resource.FieldType.field:
				if !TTT_State_Selectors.getIsFieldAvailable(localFieldList[index].inner):
					blockedFieldNumber += 1

	if !isCellBelongToLine: return LineType.notBelongToCell
	if blockedFieldNumber > 0: return LineType.other
	if currentPlayerListItemNumber == 2 && enemyListItemNumber == 0: return LineType.twoPlayerSigns
	if enemyListItemNumber == 2 && currentPlayerListItemNumber == 0: return LineType.twoEnemySigns
	if currentPlayerListItemNumber == 1 && enemyListItemNumber == 0: return LineType.onePlayerSign
	if enemyListItemNumber == 1 && currentPlayerListItemNumber == 0: return LineType.oneEnemySign
	if enemyListItemNumber == 0 && currentPlayerListItemNumber == 0: return LineType.empty
	return LineType.other

static func _getCellLineTypes(
	playerFieldType: TTT_Cell_Resource.FieldType,
	enemyFieldType: TTT_Cell_Resource.FieldType,
	localFieldList: Array[TTT_Cell_Resource],
	cellIndex: int = -1,
) -> Array[LineType]:
	var linesTypes: Array[LineType] = []
	for line in lines:
		var lineType: LineType = _getLineType(playerFieldType, enemyFieldType, localFieldList, cellIndex, line.start, line.stepSize)
		linesTypes.append(lineType)
	return linesTypes

static func _getCellBaseWeight(
	playerFieldType: TTT_Cell_Resource.FieldType,
	enemyFieldType: TTT_Cell_Resource.FieldType,
	localFieldList: Array[TTT_Cell_Resource],
	cellIndex: int,
) -> int:
	var linesSum: int = 0
	var lineTypeKeys: Array = LineType.keys()
	for lineType in _getCellLineTypes(playerFieldType, enemyFieldType, localFieldList, cellIndex):
		linesSum += lineWeighs[lineTypeKeys[lineType]]
	return linesSum

static func _getNextCellIndexOfLine(
	localFieldList: Array[TTT_Cell_Resource],
	lineStart: int,
	lineStepSize: int,
) -> int:
	for step in range(3):
		var index: int = lineStart + step * lineStepSize
		if localFieldList[index].type == TTT_Cell_Resource.FieldType.none:
			return index
	return -1

static func _getNextFieldDefenceWeight(
	playerFieldType: TTT_Cell_Resource.FieldType,
	enemyFieldType: TTT_Cell_Resource.FieldType,
	mainFieldList: Array[TTT_Cell_Resource],
	targetFieldIndex: int,
) -> int:
	var nextField = mainFieldList[targetFieldIndex]

	if (
		nextField.type == TTT_Cell_Resource.FieldType.x ||
		nextField.type == TTT_Cell_Resource.FieldType.o ||
		(
			nextField.type == TTT_Cell_Resource.FieldType.field &&
			!TTT_State_Selectors.getIsFieldAvailable(nextField.inner)
		)
	):
		var mainFieldWeightTypes: Array[LineType] = _getCellLineTypes(playerFieldType, enemyFieldType, mainFieldList)
		if mainFieldWeightTypes.has(LineType.twoEnemySigns):
			return fieldDefenceWeighs.blocked
		else:
			return fieldDefenceWeighs.blockedMinor

	if (
		nextField.type == TTT_Cell_Resource.FieldType.field &&
		TTT_State_Selectors.getIsFieldEmpty(nextField.inner)
	):
		return fieldDefenceWeighs.empty

	var targetFieldLinesWeights: Array[LineType] = _getCellLineTypes(playerFieldType, enemyFieldType, mainFieldList[targetFieldIndex].inner)
	var targetCellLinesWeights: Array[LineType] = _getCellLineTypes(playerFieldType, enemyFieldType, mainFieldList, targetFieldIndex)

	# Enemy can easely block me
	if targetFieldLinesWeights.has(LineType.twoPlayerSigns):
		# The target field won't win the game
		if targetCellLinesWeights.has(LineType.twoPlayerSigns || LineType.twoEnemySigns):
			return fieldDefenceWeighs.hasTwoSignPlayerLineBase

		var line = lines[targetFieldLinesWeights.find(LineType.twoPlayerSigns)]
		var nextCellIndex: int = _getNextCellIndexOfLine(mainFieldList[targetFieldIndex].inner, line.start, line.stepSize)
		var nextFieldLinesWeights: Array[LineType] = _getCellLineTypes(playerFieldType, enemyFieldType, mainFieldList[nextCellIndex].inner)
		# if the next field can be win by player and this one cannot win the game
		if nextFieldLinesWeights.has(LineType.twoPlayerSigns):
			return fieldDefenceWeighs.hasTwoSignPlayerLineWithAdvance

		return fieldDefenceWeighs.hasTwoSignPlayerLineBase

	if targetFieldLinesWeights.has(LineType.twoEnemySigns):
		# The target field won't win the game
		if targetCellLinesWeights.has(LineType.twoPlayerSigns || LineType.twoEnemySigns):
			return fieldDefenceWeighs.hasTwoSignEnemyLineBase


		var line = lines[targetFieldLinesWeights.find(LineType.twoPlayerSigns)]
		var nextCellIndex: int = _getNextCellIndexOfLine(mainFieldList[targetFieldIndex].inner, line.start, line.stepSize)
		var nextFieldLinesWeights: Array[LineType] = _getCellLineTypes(playerFieldType, enemyFieldType, mainFieldList[nextCellIndex].inner)
		# if the next field can be win by player and this one cannot win the game
		if nextFieldLinesWeights.has(LineType.twoPlayerSigns):
			return fieldDefenceWeighs.hasTwoSignEnemyLineWithAdvance

		return fieldDefenceWeighs.hasTwoSignEnemyLineBase

	if (
		targetFieldLinesWeights.has(LineType.onePlayerSign) ||
		targetFieldLinesWeights.has(LineType.oneEnemySign)
	):
		return fieldDefenceWeighs.hasOnePlayerLine

	return 0

static func _getCellWeight(
	playerFieldType: TTT_Cell_Resource.FieldType,
	enemyFieldType: TTT_Cell_Resource.FieldType,
	mainFieldList: Array[TTT_Cell_Resource],
	localCellList: Array[TTT_Cell_Resource],
	cellIndex: int,
) -> int:
	if (
		localCellList[cellIndex].type == TTT_Cell_Resource.FieldType.x ||
		localCellList[cellIndex].type == TTT_Cell_Resource.FieldType.o
	):
		return minCellWeight

	return (
		_getCellBaseWeight(playerFieldType, enemyFieldType, localCellList, cellIndex) +
		_getNextFieldDefenceWeight(playerFieldType, enemyFieldType, mainFieldList, cellIndex)
	)

static func _getFieldWeight(
	playerFieldType: TTT_Cell_Resource.FieldType,
	enemyFieldType: TTT_Cell_Resource.FieldType,
	mainFieldList: Array[TTT_Cell_Resource],
	fieldIndex: int,
) -> int:
	if (
		mainFieldList[fieldIndex].type == TTT_Cell_Resource.FieldType.x ||
		mainFieldList[fieldIndex].type == TTT_Cell_Resource.FieldType.o
	):
		return minCellWeight

	var maxCellWeight: int = minCellWeight
	for cellIndex in range(9):
		var cellWeight: int = _getCellWeight(playerFieldType, enemyFieldType, mainFieldList, mainFieldList[fieldIndex].inner, cellIndex)
		if maxCellWeight < cellWeight:
			maxCellWeight = cellWeight

	return _getCellBaseWeight(playerFieldType, enemyFieldType, mainFieldList, fieldIndex) + maxCellWeight

static func getCellsToChoose(state: TTT_State, openBlock: int, playerSign: TTT_State.PlayerSign) -> Array[int]:
	if TTT_State_Selectors.getNestingLevel(state) == TTT_State.NestingLevel.one:
		return easyAI.getCellsToChoose(state, openBlock, playerSign)

	var playerFieldType: TTT_Cell_Resource.FieldType = TTT_State_Helpers.getPlayerFieldType(playerSign)
	var enemyFieldType: TTT_Cell_Resource.FieldType = TTT_State_Helpers.getEnemyFieldType(playerSign)
	var mainFieldList: Array[TTT_Cell_Resource] = TTT_State_Selectors.getFieldList(state, TTT_State.mainFieldIndex)
	var localCellList: Array[TTT_Cell_Resource] = TTT_State_Selectors.getFieldList(state, openBlock)
	var result: Array[int] = []
	var weightList: Array[int] = []
	var maxCellWeight: int = minCellWeight

	for cellIndex in range(9):
		var cellWeight: int = (
			_getFieldWeight(playerFieldType, enemyFieldType, mainFieldList, cellIndex)
				if openBlock == TTT_State.mainFieldIndex else
			_getCellWeight(playerFieldType, enemyFieldType, mainFieldList, localCellList, cellIndex)
		)

		weightList.append(cellWeight)
		if maxCellWeight < cellWeight:
			maxCellWeight = cellWeight
			result = [cellIndex]
		elif maxCellWeight == cellWeight:
			result.append(cellIndex)

	prints('\nweightList')
	prints('\t', weightList[0], weightList[3], weightList[6])
	prints('\t', weightList[1], weightList[4], weightList[7])
	prints('\t', weightList[2], weightList[5], weightList[8])

	# TODO: get rid of that
	if result.size() == 0:
		prints('WARNING: hard mode returned an empty result list. Use easy mode instead.')
		return easyAI.getCellsToChoose(state, openBlock, playerSign)

	return result
