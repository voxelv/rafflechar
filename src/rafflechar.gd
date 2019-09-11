extends Control

onready var next_button := find_node("next_button") as Button
onready var char_label := find_node("char_label") as Label
onready var available_chars_textedit := find_node("available_chars_textedit") as TextEdit
onready var previous_chars_list := find_node("previous_chars_list") as HBoxContainer

var curr_char = " "

func _ready():
	randomize()
	next_button.connect("pressed", self, "_on_next_button_pressed")
	set_char(curr_char)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_next_button_pressed():
	curr_char = available_chars_textedit.text[randi()%len(available_chars_textedit.text)]
	
	if previous_chars_list.get_child_count() < 10:
		var new_child = Label.new()
		new_child.text = curr_char
		previous_chars_list.add_child(new_child)
	else:
		var old_child = previous_chars_list.get_child(0) as Label
		previous_chars_list.remove_child(old_child)
		old_child.text = curr_char
		previous_chars_list.add_child(old_child)
	
	set_char(curr_char)

func set_char(c:String):
	char_label.text = "\"" + c + "\""

