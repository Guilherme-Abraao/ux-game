extends Control

@onready var score_counter = $container/score_container/score_counter as Label
@onready var timer_counter = $container/timer_counter/timer_counter as Label
@onready var clock_timer = $clock_timer as Timer

var minutes = 0
var seconds = 0
@export_range(0, 59) var default_minutes := 0
@export_range(0, 59) var default_seconds := 0

@onready var coracao1 = $container/vida_container/Coracao1
@onready var coracao2 = $container/vida_container/Coracao2
@onready var coracao3 = $container/vida_container/Coracao3

@export var vidaAtual: int
var vidaInicial = 3

signal time_is_up()

# Called when the node enters the scene tree for the first time.
func _ready():
	score_counter.text = str("%04d" % Globals.score)
	timer_counter.text = str("%02d" % default_minutes) + ':' + str("%02d" % default_seconds)
	reset_clock_timer()
	
	vidaAtual = vidaInicial
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if minutes == 59 and seconds == 0:
		emit_signal('time_is_up')
	ajustaCoracoes()

func _on_clock_timer_timeout():
	if seconds == 60:
		if minutes < 60:
			minutes += 1
			seconds = 0
	seconds += 1
	timer_counter.text = str("%02d" % minutes) + ':' + str("%02d" % seconds)
	
func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds

func ajustaCoracoes():
	match vidaAtual:
		3:
			coracao1.visible = true
			coracao2.visible = true
			coracao3.visible = true
		2:
			coracao1.visible = false
			coracao2.visible = true
			coracao3.visible = true
		1:
			coracao1.visible = false
			coracao2.visible = false
			coracao3.visible = true
		0:
			coracao1.visible = false
			coracao2.visible = false
			coracao3.visible = false
	pass
