extends Control

# Pindah ke Main Menu
func _on_btn_main_menu_pressed():
	# Karena filemu ada di folder scenes, alamatnya harus pakai scenes/
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

# Tutup Game
func _on_btn_exit_pressed():
	get_tree().quit()
