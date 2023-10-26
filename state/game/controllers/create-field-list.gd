static func createEmptyFieldList(type: TTT_State.FieldType = TTT_State.FieldType.field) -> Array:
  var list: Array = []

  for parentIndex in range(9):
    list.append({
      type = type,
      inner = createEmptyFieldList(TTT_State.FieldType.none) if type == TTT_State.FieldType.field else []
    })

  return list
