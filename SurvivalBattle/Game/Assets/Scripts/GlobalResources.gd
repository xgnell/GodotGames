extends Node2D

################ Scenes ###############
const PlaygroundScene = "res://Assets/Scenes/Playground.tscn"
const MainMenuScene = "res://Assets/Scenes/MainGUIs/MainMenu.tscn"
const SettingsMenu = "res://Assets/Scenes/MainGUIs/Settings.tscn"

#################################### Characters

const objActor = preload("res://Assets/Objects/Characters/Actor/Actor.gd")

const objPlayer = preload("res://Assets/Templates/Characters/Player/Player.gd")

const objEnemy = preload("res://Assets/Templates/Characters/Enemy/Enemy.gd")

const sZombie = preload("res://Assets/Templates/Types/Enemies/Zombie/Zombie.tscn")



##################################### Maps
const objMap = preload("res://Assets/Objects/Map/Map.gd")





##################################### Weapons
const objWeapon = preload("res://Assets/Objects/Weapons/Weapon/Weapon.gd")

const sPistol = preload("res://Assets/Templates/Weapons/Guns/Pistol/Pistol.tscn")
const sAK47 = preload("res://Assets/Templates/Weapons/Guns/AK47/AK47.tscn")


const objBullet = preload("res://Assets/Objects/Weapons/Bullet/Bullet.gd")
const sNormalBullet = preload("res://Assets/Templates/Weapons/Bullets/NormalBullet/NormalBullet.tscn")




##################################### Items
const objItem = preload("res://Assets/Objects/Item/Item.gd")

const sIncreaseSpeedItem = preload("res://Assets/Templates/Items/IncreaseSpeedItem/IncreaseSpeedItem.tscn")
const sAddMoreBulletItem = preload("res://Assets/Templates/Items/AddMoreBullet/AddMoreBullet.tscn")
const sWeaponItem = preload("res://Assets/Templates/Items/WeaponItem/WeaponItem.tscn")
const sAddLife = preload("res://Assets/Templates/Items/AddLife/AddLife.tscn")

const objWeaponItem = preload("res://Assets/Templates/Items/WeaponItem/WeaponItem.gd")


##################################### Effects
const balloonNotifier = preload("res://Assets/Objects/BalloonNotifier/BalloonNotifier.tscn")

const effectBulletExplosion = preload("res://Assets/Templates/Effects/BulletExplosion/BulletExplosion.tscn")
const effectActorDie = preload("res://Assets/Templates/Effects/ActorDie/ActorDie.tscn")
