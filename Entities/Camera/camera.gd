extends Camera2D

func _ready() -> void:
	var zoom_val = self.zoom.x + 1.2
	#self.zoom = Vector2(zoom_val, zoom_val)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("zoom_in"):
		var zoom_val = self.zoom.x +0.1
		self.zoom = Vector2(zoom_val, zoom_val)
	if Input.is_action_just_pressed("zoom_out"):
		var zoom_val = self.zoom.x -0.1
		self.zoom = Vector2(zoom_val, zoom_val)
