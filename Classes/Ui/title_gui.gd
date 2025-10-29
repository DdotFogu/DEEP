extends Control

@onready var title_label: Label = $title_label
@onready var inital_text = title_label.text

func update_floor_title(level:int=0):
	title_label.text = inital_text + str(level)
