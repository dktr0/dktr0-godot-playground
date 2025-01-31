extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	setScore(1977);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func setScore(x):
	$Score.text = str(x);
