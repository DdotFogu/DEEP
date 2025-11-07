extends Node

var player : base_character = null
var current_level : base_level = null
var current_cam : Camera2D = null
var transition_ui : Control = null
var levels_cleared : int
var current_time : float
var music : bool = true
var sfx : bool = true

# settings
var screen_shake : bool = true
var res_scale : int = 5
var sfx_volume : int = 5
var music_volume : int = 5
