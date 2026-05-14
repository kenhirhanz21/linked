extends Control

func _ready():
	# Memastikan pop-up hilang saat menu baru dibuka
	$RolePopup.visible = false

# Fungsi saat tombol New Game ditekan
func _on_new_game_pressed():
	$RolePopup.visible = true

# Fungsi saat tombol Quit Game ditekan
func _on_quit_game_pressed():
	get_tree().quit() # Ini kodingan otomatis tutup game

# Fungsi saat tombol Close di pop-up ditekan
func _on_close_pressed():
	$RolePopup.visible = false

# Fungsi ke ruangan Detective
func _on_detective_pressed():
	get_tree().change_scene_to_file("res://scenes/detective_room.tscn")

# Fungsi ke ruangan Hacker (Tambahan baru)
func _on_hacker_pressed():
	get_tree().change_scene_to_file("res://scenes/hacker_room.tscn")
