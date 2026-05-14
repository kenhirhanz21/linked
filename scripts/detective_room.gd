extends Control

# ==========================================
# VARIABEL GAME STATE
# ==========================================
# Urutan: Api -> Bulan -> Angin -> Matahari
var sandi_brankas = ["Api", "Bulan", "Angin", "Matahari"]
var tebakan_pemain = []
var punya_kunci = false
var brankas_sudah_buka = false

# ==========================================
# SAAT RUANGAN PERTAMA KALI DIBUKA
# ==========================================
func _ready():
	# Sembunyikan semua UI zoom/overlay di awal
	$OverlayFoto.visible = false
	$OverlayBrankas.visible = false
	$OverlayBrankas/GambarBrankasBuka.visible = false
	$NotifKunci.visible = false
	$ZoomKertas.visible = false
	$PesanPintu.visible = false
	
	reset_brankas_visual()

# ==========================================
# FUNGSI ZOOM FOTO BAYI
# ==========================================
func _on_foto_area_pressed():
	$OverlayFoto.visible = true

func _on_btn_back_foto_pressed():
	$OverlayFoto.visible = false

# ==========================================
# FUNGSI BRANKAS & SIMBOL
# ==========================================
func _on_brankas_area_pressed():
	$OverlayBrankas.visible = true
	# Kalau brankas sudah pernah dibuka, langsung tampilkan isinya
	if brankas_sudah_buka:
		$OverlayBrankas/GambarBrankasBuka.visible = true
		_hide_brankas_buttons()

func _on_btn_back_brankas_pressed():
	$OverlayBrankas.visible = false

func cek_sandi():
	if tebakan_pemain.size() == sandi_brankas.size():
		if tebakan_pemain == sandi_brankas:
			print("Brankas Terbuka!")
			brankas_sudah_buka = true
			$OverlayBrankas/GambarBrankasBuka.visible = true
			_hide_brankas_buttons()
		else:
			print("Sandi Salah!")
			# Kasih delay dikit sebelum reset biar pemain sempat lihat tombol terakhir
			await get_tree().create_timer(0.5).timeout
			reset_brankas_visual()

func reset_brankas_visual():
	tebakan_pemain.clear()
	$OverlayBrankas/BtnBulan/EfekGelap.visible = false
	$OverlayBrankas/BtnBintang/EfekGelap.visible = false
	$OverlayBrankas/BtnMatahari/EfekGelap.visible = false
	$OverlayBrankas/BtnAir/EfekGelap.visible = false
	$OverlayBrankas/BtnApi/EfekGelap.visible = false
	$OverlayBrankas/BtnAngin/EfekGelap.visible = false

func _hide_brankas_buttons():
	$OverlayBrankas/BtnBulan.visible = false
	$OverlayBrankas/BtnBintang.visible = false
	$OverlayBrankas/BtnMatahari.visible = false
	$OverlayBrankas/BtnAir.visible = false
	$OverlayBrankas/BtnApi.visible = false
	$OverlayBrankas/BtnAngin.visible = false

# --- Signal Button Simbol ---
func _on_btn_bulan_pressed():
	$OverlayBrankas/BtnBulan/EfekGelap.visible = true
	tebakan_pemain.append("Bulan")
	cek_sandi()

func _on_btn_bintang_pressed():
	$OverlayBrankas/BtnBintang/EfekGelap.visible = true
	tebakan_pemain.append("Bintang")
	cek_sandi()

func _on_btn_matahari_pressed():
	$OverlayBrankas/BtnMatahari/EfekGelap.visible = true
	tebakan_pemain.append("Matahari")
	cek_sandi()

func _on_btn_air_pressed():
	$OverlayBrankas/BtnAir/EfekGelap.visible = true
	tebakan_pemain.append("Air")
	cek_sandi()

func _on_btn_api_pressed():
	$OverlayBrankas/BtnApi/EfekGelap.visible = true
	tebakan_pemain.append("Api")
	cek_sandi()

func _on_btn_angin_pressed():
	$OverlayBrankas/BtnAngin/EfekGelap.visible = true
	tebakan_pemain.append("Angin")
	cek_sandi()

# ==========================================
# INTERAKSI ISI BRANKAS (Kunci & Kertas)
# ==========================================

func _on_btn_kunci_pressed():
	punya_kunci = true
	$OverlayBrankas/GambarBrankasBuka/BtnKunci.visible = false
	$NotifKunci.visible = true
	await get_tree().create_timer(2.0).timeout
	$NotifKunci.visible = false

func _on_btn_kertas_pressed():
	$OverlayBrankas.visible = false
	$ZoomKertas.visible = true

func _on_btn_back_kertas_pressed():
	$ZoomKertas.visible = false
	$OverlayBrankas.visible = true

func _on_btn_tumpuk_kertas_pressed():
	# Memuat gambar kertas yang sudah digabung
	var tex = load("res://assets/images/kertas_gabung.png")
	$ZoomKertas/GambarKertas.texture = tex

# ==========================================
# FUNGSI PINTU (Pindah ke Ruang Bom)
# ==========================================
func _on_pintu_area_pressed():
	if punya_kunci:
		print("Kunci ada, pindah ke Ruang Bom!")
		# Pastikan path ini benar sesuai folder kamu
		get_tree().change_scene_to_file("res://scenes/ruang_bom.tscn")
	else:
		# Notif kalau kunci belum diambil
		$PesanPintu.visible = true
		await get_tree().create_timer(2.0).timeout
		$PesanPintu.visible = false
