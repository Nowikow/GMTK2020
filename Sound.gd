extends AudioStreamPlayer2D

var strm = stream as AudioStreamOGGVorbis

func _ready():
	strm.set_loop(false)
