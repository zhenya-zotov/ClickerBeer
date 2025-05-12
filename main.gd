extends Node2D

@onready var sprite: Sprite2D = $BeerSprite
@onready var label: Label = $Label
@onready var gulp_sound: AudioStreamPlayer2D = $GulpSound
@onready var back_label: Sprite2D = $backlabel
@onready var text_price: Label = $price
@onready var btn_exit: TextureButton = $Exit

var beers_drunk = 0
var taps_left = 3

var textures := [
	preload("res://assets/beer/beer_1.png"),
	preload("res://assets/beer/beer_3.png"),
	preload("res://assets/beer/beer_2.png"),
	preload("res://assets/beer/beer_1.png")
]

func _ready():
	update_ui()
	btn_exit.connect("pressed", Callable(self, "_on_exit_pressed"))

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		handle_tap(event.position)

func handle_tap(pos: Vector2):
	var rect = Rect2(sprite.global_position - sprite.texture.get_size() / 2, sprite.texture.get_size())
	if rect.has_point(pos):
		taps_left -= 1
		if taps_left <= 0:
			beers_drunk += 1
			taps_left = 3
			gulp_sound.play()
		update_ui()

func update_ui():
	sprite.texture = textures[taps_left]
	label.text = "%d" % beers_drunk
	
	if beers_drunk != 0 and beers_drunk % 10 == 0:
		back_label.visible = true
		text_price.visible = true
		text_price.text = "ALCOHOLIC"
		
		await get_tree().create_timer(2.0).timeout
		
		back_label.visible = false
		text_price.visible = false
		
	if beers_drunk != 0 and beers_drunk % 100 == 0:
		$Vomit.visible = true
		$Vomit.play()
		await get_tree().create_timer(3.0).timeout
		$Vomit.visible = false
		$Vomit.stop()
		
func _on_exit_pressed():
	get_tree().quit()
