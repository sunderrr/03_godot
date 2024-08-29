extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(1000,1000,1000,0.25)
	var tween_fade = create_tween()
	#tween_fade.tween_property(self, "modulate",Color(1, 1, 1, 0), 0.75 )
	#tween_fade.tween_property(self, "self_modulate",Color(1, 1, 1, 0), 0.75 )
	tween_fade.tween_property(self, "modulate:a", 0.0, 0.8 )
	await tween_fade.finished
 
	queue_free()
