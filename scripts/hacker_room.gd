extends Control

# --- Variabel Sandi ---
var sandi_tablet = "1998"
const SANDI_PC_BENAR = "LINKED"

# --- Variabel Puzzle Defuse ---
var tahap_defuse = 0
var tahan_defuse = false
var waktu_tahan = 0.0

func _ready():
	# Sembunyikan semua overlay di awal permainan
	$OverlayTabletLock.visible = false
	$GambarTabletHome.visible = false
	$OverlayLaptopZoom.visible = false
	
	# Siapkan monitor laptop agar mulai dari layar login
	$OverlayLaptopZoom/MonitorFrame/LayarLogin.visible = true
	$OverlayLaptopZoom/MonitorFrame/LayarSoftware.visible = false
	
	# Sembunyikan tombol Defuse sampai puzzle selesai
	$OverlayLaptopZoom/MonitorFrame/LayarSoftware/BtnDefuse.visible = false
	reset_puzzle()

# ==========================================
# FUNGSI TABLET (PIN: 1998)
# ==========================================
func _on_tablet_area_pressed():
	$OverlayTabletLock.visible = true

func _on_btn_back_tablet_pressed():
	$OverlayTabletLock.visible = false
	$OverlayTabletLock/GambarTablet/InputPIN.text = ""

func _on_btn_enter_pressed():
	var tebakan = $OverlayTabletLock/GambarTablet/InputPIN.text
	if tebakan == sandi_tablet:
		print("PIN Tablet Benar!")
		$OverlayTabletLock.visible = false
		$GambarTabletHome.visible = true
	else:
		print("PIN Tablet Salah!")
		$OverlayTabletLock/GambarTablet/InputPIN.text = ""

func _on_btn_back_home_pressed():
	$GambarTabletHome.visible = false

# ==========================================
# FUNGSI LAPTOP & LOGIN (Pass: LINKED)
# ==========================================
func _on_laptop_area_pressed():
	$OverlayLaptopZoom.visible = true
	$OverlayLaptopZoom/MonitorFrame/LayarLogin.visible = true
	$OverlayLaptopZoom/MonitorFrame/LayarSoftware.visible = false

func _on_btn_back_laptop_pressed():
	$OverlayLaptopZoom.visible = false
	$OverlayLaptopZoom/MonitorFrame/LayarLogin/InputPassPC.text = ""

func _on_btn_login_pc_pressed():
	var tebakan_pc = $OverlayLaptopZoom/MonitorFrame/LayarLogin/InputPassPC.text.to_upper()
	if tebakan_pc == SANDI_PC_BENAR:
		print("PC UNLOCKED!")
		$OverlayLaptopZoom/MonitorFrame/LayarLogin.visible = false
		$OverlayLaptopZoom/MonitorFrame/LayarSoftware.visible = true
		reset_puzzle() 
	else:
		print("Password PC Salah!")
		$OverlayLaptopZoom/MonitorFrame/LayarLogin/InputPassPC.text = ""

# ==========================================
# LOGIKA PUZZLE PING-PONG BOMB
# ==========================================
func reset_puzzle():
	tahap_defuse = 0
	# Kembalikan warna awal ke Kuning
	$OverlayLaptopZoom/MonitorFrame/LayarSoftware/IndikatorWarna.color = Color.YELLOW
	$OverlayLaptopZoom/MonitorFrame/LayarSoftware/BtnDefuse.visible = false

func _on_btn_kotak_pressed():
	if tahap_defuse == 0:
		tahap_defuse = 1
		$OverlayLaptopZoom/MonitorFrame/LayarSoftware/IndikatorWarna.color = Color.GREEN
		print("Tahap 1 OK! Warna -> Hijau")
	else:
		reset_puzzle()

func _on_btn_lingkaran_pressed():
	if tahap_defuse == 1:
		tahap_defuse = 2
		$OverlayLaptopZoom/MonitorFrame/LayarSoftware/IndikatorWarna.color = Color.RED
		print("Tahap 2 OK! Warna -> Merah")
	else:
		reset_puzzle()

func _on_btn_segitiga_pressed():
	if tahap_defuse == 2:
		tahap_defuse = 3
		# Warna Putih/Mati sebagai tanda rangkaian selesai
		$OverlayLaptopZoom/MonitorFrame/LayarSoftware/IndikatorWarna.color = Color.WHITE
		$OverlayLaptopZoom/MonitorFrame/LayarSoftware/BtnDefuse.visible = true
		print("PUZZLE SELESAI! Tahan tombol Defuse sekarang!")
	else:
		reset_puzzle()

# ==========================================
# MEKANIK TAHAN TOMBOL 5 DETIK
# ==========================================
func _process(delta):
	if tahan_defuse == true:
		waktu_tahan += delta 
		
		if waktu_tahan >= 5.0:
			tahan_defuse = false 
			print("BOMB DEFUSED!!! SELAMAT!")
			# Pindah ke scene kemenangan
			get_tree().change_scene_to_file("res://scenes/congrats_scene.tscn")

func _on_btn_defuse_button_down():
	tahan_defuse = true
	waktu_tahan = 0.0

func _on_btn_defuse_button_up():
	tahan_defuse = false
	if waktu_tahan < 5.0:
		print("Tombol dilepas terlalu cepat!")
	waktu_tahan = 0.0
