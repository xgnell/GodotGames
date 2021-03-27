extends KinematicBody2D

# Info
export (int) var moveSpeed = 400
export (int) var gravity = 40
export (int) var jumpForce = 1000


var movement = Vector2(0, 0)

# Control
var buttonLeftPressed = false
var buttonRightPressed = false
var buttonJumpPressed = false
var buttonEscapePressed = false

# Objects
const SLASH = preload("res://Assets/Prefabs/Slash.tscn")

func player_movement():

	if Input.is_action_pressed("ui_right") or buttonRightPressed == true:
		movement.x = moveSpeed
		
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Walk")
		
	elif Input.is_action_pressed("ui_left") or buttonLeftPressed == true:
		
		movement.x = -moveSpeed

		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Walk")
	
	elif Input.is_action_pressed("ui_cancel") or buttonEscapePressed == true:
		get_tree().change_scene("res://Assets/Scenes/Menu.tscn")
	
	elif Input.is_action_just_pressed("ui_accept"):
		
		var slash = SLASH.instance()
		
		if $AnimatedSprite.flip_h == false:
			# Right side
			slash.releasePos = $positionRight.global_position
			slash.releaseDir = Vector2.RIGHT
		else:
			# Left side
			slash.releasePos = $positionLeft.global_position
			slash.releaseDir = Vector2.LEFT
			
		get_parent().add_child(slash)
		
		
		
		
	else:
		movement.x = 0
		
		$AnimatedSprite.play("Idle")
		
		
		
		
	if is_on_floor():
		
		if Input.is_action_just_pressed("ui_up") or buttonJumpPressed == true:
			movement.y = -jumpForce
			
			$AnimatedSprite.play("Jump")
		
	else:
		movement.y += gravity
		
		if movement.y > 0:
			$CollisionShape2D.disabled = false
		else:
			$CollisionShape2D.disabled = true
		
		self.visible = true
		$AnimatedSprite.play("Jump")
		
func update_move_player():
	player_movement()
	
	move_and_slide(movement, Vector2.UP)
	

func _ready():
	pass


func _physics_process(delta):
	update_move_player()
	
	
func _on_buttonLeft_button_down():
	buttonLeftPressed = true
func _on_buttonRight_button_down():
	buttonRightPressed = true
func _on_buttonLeft_button_up():
	buttonLeftPressed = false
func _on_buttonRight_button_up():
	buttonRightPressed = false
func _on_buttonJump_button_down():
	buttonJumpPressed = true
func _on_buttonJump_button_up():
	buttonJumpPressed = false


func _on_buttonEscape_pressed():
	buttonEscapePressed = true