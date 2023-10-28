extends Node

const difficultiesEasy = preload('./easy.gd')

func _ready():
	_test(
		'. . .\n. . .\n. . .',
		[
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
		],
		[
			[],
			[],
			[],
			[],
			[0, 1, 2, 3, 4, 5, 6, 7, 8],
		]
	)
	_test(
		'x . .\n. . .\n. . .',
		[
			{ type = TTT_Cell_Resource.FieldType.x },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
			{ type = TTT_Cell_Resource.FieldType.none },
		],
		[
			[],
			[],
			[],
			[],
			[0, 1, 2, 3, 4, 5, 6, 7, 8],
		]
	)

func _test(testName: String, fieldList: Array[TTT_Cell_Resource], expectedResult: Array):
	print('Start testing\n')

	var result = difficultiesEasy._getClosingCells(TTT_State.PlayerSign.o, fieldList)

	for rowIndex in range(result.size()):
		var row = _prepareResult(result[rowIndex])
		var expectedRow = expectedResult[rowIndex]

		if row.size() != expectedRow.size():
			_error(testName, 'Row ' + str(rowIndex) + ' is not equal. Got: ' + str(row.size()) + '; Expected: ' + str(expectedRow.size()))
			break

		for cellIndex in range(row.size()):
			if row[cellIndex] != expectedRow[cellIndex]:
				_error(testName, 'Cell ' + str(rowIndex) + '.' + str(cellIndex) + ' is not equal. Got: ' + str(row[cellIndex]) + '; Expected: ' + str(expectedRow[cellIndex]))
				break

	print('Tests are finished')

func _prepareResult(rawResult: Array) -> Array:
	var result: Array = []

	for rawValue in rawResult:
		if !result.has(rawValue): result.append(rawValue)

	result.sort()

	return result

func _error(testName: String, message: String):
	print('> Error test\n', testName, '\n', message, '\n')
