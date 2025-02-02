extends TileMapLayer


var original_cells: Array[Dictionary] = []

func _ready() -> void:
	# Store original cells
	for cell in get_used_cells():
		original_cells.append({
			"coords": cell,
			"source_id": get_cell_source_id(cell),
			"atlas_coords": get_cell_atlas_coords(cell),
		})

func respawn_breakables() -> void:
	for cell_data in original_cells:
		set_cell(cell_data["coords"], cell_data["source_id"], cell_data["atlas_coords"])
