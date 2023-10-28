extends Resource
class_name TTT_Cell_Resource

enum FieldType { none, x, o, field }

@export var type: FieldType
@export var inner: Array[TTT_Cell_Resource]

static func createEmptyFieldList(
  cellType: TTT_Cell_Resource.FieldType = TTT_Cell_Resource.FieldType.field
) -> Array[TTT_Cell_Resource]:
  var list: Array[TTT_Cell_Resource] = []

  for parentIndex in range(9):
    var cell = TTT_Cell_Resource.new(cellType)
    if cellType == TTT_Cell_Resource.FieldType.field:
      cell.inner = createEmptyFieldList(TTT_Cell_Resource.FieldType.none)
    list.append(cell)

  return list

func _init(
  initType: FieldType = FieldType.none,
  initChildren: Array[TTT_Cell_Resource] = [],
):
  type = initType
  inner = initChildren
