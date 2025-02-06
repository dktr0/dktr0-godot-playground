extends Node3D

@onready var popupScene = preload("res://popup.tscn");
@onready var choice2Scene = preload("res://choice2.tscn");

func popup(t : String, cb : Callable = Callable()):
	var popup = popupScene.instantiate();
	popup.setup(t,cb);
	add_child(popup);
	
func choice2(t : String, c0 : String, c1 : String, cb : Callable = Callable()):
	var choice2 = choice2Scene.instantiate();
	choice2.setup(t,c0,c1,cb);
	add_child(choice2);

func _ready():
	popup("This is some awesome text that I want to share with the player.",Callable(self,"followup1"));
	
func followup1():
	choice2("Now I am present a choice. Do you want to go left or go right?","Left","Right",Callable(self,"followup2"));

func followup2(n : int):
	if n == 0:
		print("the player selected left");
	else:
		print("the player selected right");
