extends Control

# --- VARIABEL (Ini yang tadi hilang mangkanya error merah) ---
var tahap_bom = 0
var tahan_defuse = false
var waktu_tahan = 0.0

func _ready():
	reset_bom()

func reset_bom():
	tahap_bom = 0
	# Menggunakan % karena kamu sudah set Unique Name di editor
	%LayarSimbol.text = "KOTAK"
	
	%BtnDefuseDetektif.flat = false
	%BtnDefuseDetektif.disabled = true
	
	tahan_defuse = false
	waktu_tahan = 0.0

# --- LOGIKA TOMBOL WARNA ---
func _on_btn_kuning_pressed():
	if tahap_bom == 0:
		tahap_bom = 1
		%LayarSimbol.text = "LINGKARAN"
	else:
		reset_bom()

func _on_btn_hijau_pressed():
	if tahap_bom == 1:
		tahap_bom = 2
		%LayarSimbol.text = "SEGITIGA"
	else:
		reset_bom()

func _on_btn_merah_pressed():
	if tahap_bom == 2:
		tahap_bom = 3
		%LayarSimbol.text = "HOLD!" 
		%BtnDefuseDetektif.flat = true
		%BtnDefuseDetektif.disabled = false
	else:
		reset_bom()

# --- MEKANIK TAHAN 5 DETIK ---
func _process(delta):
	if tahan_defuse:
		waktu_tahan += delta
		if waktu_tahan >= 5.0:
			tahan_defuse = false
			get_tree().change_scene_to_file("res://scenes/congrats_scene.tscn")

func _on_btn_defuse_detektif_button_down():
	tahan_defuse = true
	waktu_tahan = 0.0

func _on_btn_defuse_detektif_button_up():
	tahan_defuse = false
	waktu_tahan = 0.0
