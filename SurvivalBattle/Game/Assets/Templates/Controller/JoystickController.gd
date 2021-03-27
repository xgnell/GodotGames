extends TouchScreenButton

var boundary = 270

var ongoing_drag = -1

var return_accel = 20

var threshold = 10

func _process(delta):
	if ongoing_drag == -1:
		var pos_difference = Vector2(0, 0) - position
		position += pos_difference * return_accel * delta

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre = (event.position - get_parent().global_position).length()

		if event_dist_from_centre <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event.position)

			if position.length() > boundary:
				set_position( position.normalized() * boundary )

			ongoing_drag = event.get_index()

	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1

func get_value():
	# Return direction
	if position.length() > threshold:
		return position.normalized()
	return Vector2(0, 0)