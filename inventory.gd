extends Control

@onready var heartScene = preload("res://heart.tscn");

func _ready():
	setNumberHearts(0); # change to 1 2 3 4 etc to test- 
	
func setNumberHearts(n):
	deleteAllItems();
	for x in n:
		addItem();

func deleteAllItems():
	for x in $HBoxContainer.get_children():
		x.queue_free(); 

func addItem():
	$HBoxContainer.add_child(heartScene.instantiate());
	
