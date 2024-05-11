extends TextureButton

var music_bus = AudioServer.get_bus_index("Master")
@onready var hover_on = $TextureRect
var is_pressedd: bool = false
func _ready():
	hover_on.visible = false
func _on_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
	is_pressedd = true
	update_hover_visibility()
	
func _on_mouse_entered():
	if is_pressedd:
		hover_on.show()
	update_hover_visibility()

func _on_mouse_exited():
	if is_pressedd:
		hover_on.hide()
	update_hover_visibility()


func update_hover_visibility():

	if is_pressedd:
		is_pressedd = false

