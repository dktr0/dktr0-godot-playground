extends Control

var callback : Callable;

func setup(t : String, c0 : String, c1 : String, cb : Callable = Callable()):
	$Panel/RichTextLabel.text = t;
	$Panel/FirstButton.text = c0;
	$Panel/SecondButton.text = c1;
	callback = cb;

func _ready():
	$Panel/FirstButton.grab_focus();

func dismiss(n : int):
	if !callback.is_null():
		callback.call(n);
	queue_free();

func _on_first_button_pressed():
	dismiss(0);

func _on_second_button_pressed():
	dismiss(1);
