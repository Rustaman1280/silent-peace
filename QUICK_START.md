# 🚀 QUICK START GUIDE - SILENT PEACE

## Langkah-Langkah Menjalankan Game

### 1️⃣ Buka Project di Godot

1. Download & Install **Godot 4.x** dari https://godotengine.org/
2. Buka Godot Engine
3. Klik "Import"
4. Pilih folder `silent-peace`
5. Pilih file `project.godot`
6. Klik "Import & Edit"

### 2️⃣ Jalankan Game

**Cara 1 - Main Scene:**
- Tekan `F5` atau klik tombol ▶️ Play di kanan atas
- Game akan langsung jalan dengan placeholder graphics

**Cara 2 - Current Scene:**
- Buka `Assets/Scenes/MainWorld.tscn`
- Tekan `F6` atau klik tombol ▶️ dengan icon scene

### 3️⃣ Kontrol Game

```
⌨️ KEYBOARD:
W A S D     - Gerak (depan, kiri, belakang, kanan)
SHIFT       - Sprint (lari cepat)
SPACE       - Lompat
MOUSE       - Lihat sekeliling (first-person)
ESC         - Lepas/tangkap mouse

🎮 TIPS:
- Dekati kelinci untuk membuat mereka lari
- Jelajahi hutan dan bukit-bukit
- Perhatikan siklus siang-malam
```

---

## 🎨 Tampilan Saat Ini (Placeholder)

Game saat ini menggunakan **geometric shapes**:
- 🟤 **Pohon** = Cylinder (batang) + Sphere (daun)
- 🐰 **Kelinci** = Box (badan) + Sphere (kepala)  
- 🟢 **Tanah** = Plane berwarna hijau
- ⛰️ **Bukit** = Sphere yang diflat

**Ini NORMAL!** Asset placeholder akan diganti dengan model 3D HD setelah Anda download.

---

## 📥 Cara Menambahkan Asset 3D

### Step 1: Download Asset
Lihat file `ASSETS_NEEDED.md` untuk link download gratis.

**Minimal yang dibutuhkan:**
- 1-2 model pohon (.glb)
- 1 model kelinci (.glb)
- 1 texture rumput (PNG/JPG)

### Step 2: Import ke Godot

1. **Copy file asset:**
   ```
   Models:   Assets/Models/Trees/pine_tree.glb
   Textures: Assets/Textures/Terrain/grass.png
   Audio:    Assets/Audio/forest_ambience.ogg
   ```

2. **Drag & Drop:**
   - Buka Godot File System (panel kiri bawah)
   - Drag files dari Windows Explorer ke folder yang sesuai
   - Godot akan auto-import

### Step 3: Update Scripts

**Untuk Tree Models:**
Buka `Assets/Scripts/WorldManager.gd`, cari fungsi `generate_forest()` dan ganti:

```gdscript
# Ganti ini:
var tree = create_placeholder_tree()

# Dengan ini:
var tree = create_real_tree()
```

Lalu tambahkan fungsi baru:

```gdscript
func create_real_tree() -> Node3D:
    var tree_models = [
        preload("res://Assets/Models/Trees/pine_tree.glb"),
        # Tambahkan model lain di sini
    ]
    var random_tree = tree_models[randi() % tree_models.size()]
    var tree_instance = random_tree.instantiate()
    tree_instance.rotation.y = randf() * TAU
    return tree_instance
```

**Untuk Rabbit Model:**
Similar, ganti `create_placeholder_rabbit()` dengan real model.

### Step 4: Test!
Tekan F5 dan lihat hasilnya! 🎉

---

## 🎵 Cara Menambahkan Audio

1. **Download audio:**
   - Forest ambience (forest_ambience.ogg)
   - Bird sounds (birds.ogg)
   - Wind (wind.ogg)

2. **Import ke Godot:**
   - Letakkan di `Assets/Audio/`

3. **Update AmbientSound.gd:**
   
   Buka `Assets/Scripts/AmbientSound.gd`, tambahkan di fungsi `setup_audio_players()`:

   ```gdscript
   # Setelah create audio players, tambahkan:
   var forest_audio = preload("res://Assets/Audio/forest_ambience.ogg")
   ambience_player.stream = forest_audio
   ambience_player.play()
   
   var bird_audio = preload("res://Assets/Audio/birds.ogg")
   bird_player.stream = bird_audio
   bird_player.play()
   ```

4. **Test audio:**
   Jalankan game, Anda akan dengar suara!

---

## 🌿 Fitur yang Sudah Berfungsi

✅ **World Generation:**
- Terrain 200x200 meter
- 300 pohon random placement
- 10 bukit dengan procedural generation
- Fog system

✅ **Player System:**
- First-person controller
- Mouse look
- Sprint & jump
- Smooth movement

✅ **AI System:**
- 20 kelinci dengan AI
- Wander behavior (jalan-jalan)
- Idle behavior (istirahat)
- Flee behavior (lari dari player)
- Detection radius 8 meter

✅ **Environment:**
- Day/Night cycle (10 menit real-time)
- Dynamic sun position
- Dynamic lighting & colors
- Fog changes based on time

✅ **Effects:**
- Grass system (5000 blades using MultiMesh)
- Particle effects (fireflies, dust)
- Optimized rendering

✅ **UI:**
- FPS counter
- Control hints
- Crosshair
- Info labels

---

## ⚙️ Optimasi Performance

Jika game lag/FPS rendah:

### Di Script WorldManager.gd:

```gdscript
# Kurangi jumlah objects:
@export var tree_count: int = 100  # dari 300
@export var rabbit_count: int = 10  # dari 20
@export var grass_density: int = 2000  # dari 5000
```

### Di Project Settings:

1. **Rendering → Quality:**
   - Shadow Atlas Size: 2048 → 1024
   - Directional Shadow Size: 2048 → 1024

2. **Rendering → Performance:**
   - Max FPS: 60

3. **Disable fitur:**
   - Komentar particle effects di MainWorld.tscn
   - Komentar GrassGenerator

---

## 🐛 Troubleshooting

### Game tidak jalan:
- Pastikan menggunakan Godot 4.x (bukan 3.x)
- Check console untuk error (View → Output)

### Mouse tidak bisa gerak:
- Tekan ESC untuk toggle mouse capture
- Pastikan game window dalam focus

### Kelinci tidak bergerak:
- Check apakah script Rabbit.gd sudah attach
- Lihat console untuk error

### FPS rendah:
- Ikuti panduan optimasi di atas
- Tutup aplikasi lain
- Lower tree_count & grass_density

### Scene kosong:
- Pastikan MainWorld.tscn terbuka
- Check WorldManager script sudah attach
- Lihat console untuk generation messages

---

## 📁 Struktur File Penting

```
silent-peace/
├── project.godot              ← Konfigurasi project
├── README.md                  ← Dokumentasi lengkap
├── ASSETS_NEEDED.md          ← Daftar asset & cara download
├── QUICK_START.md            ← File ini
│
└── Assets/
    ├── Scenes/
    │   └── MainWorld.tscn    ← SCENE UTAMA
    │
    ├── Scripts/
    │   ├── WorldManager.gd   ← Generate world
    │   ├── Player.gd         ← Player controller
    │   ├── Rabbit.gd         ← AI kelinci
    │   ├── DayNightCycle.gd  ← Siang/malam
    │   └── ...
    │
    ├── Models/     ← LETAKKAN 3D MODELS DI SINI
    ├── Textures/   ← LETAKKAN TEXTURES DI SINI
    └── Audio/      ← LETAKKAN SOUNDS DI SINI
```

---

## 🎯 Next Steps

**Untuk pemula:**
1. ✅ Jalankan game dengan placeholder (sudah bisa sekarang!)
2. 📥 Download 1-2 tree models dari Poly Haven
3. 🔧 Import & test dengan real models
4. 🎵 Tambahkan forest ambience sound
5. 🎨 Tambahkan grass texture

**Untuk advanced:**
- Modifikasi WorldManager untuk custom world size
- Tambah jenis hewan baru (deer, fox)
- Buat weather system (hujan, kabut tebal)
- Implement inventory system
- Buat quest system

---

## 📚 Resources

**Tutorial Godot:**
- Official Docs: https://docs.godotengine.org/
- GDQuest: https://www.gdquest.com/
- Heartbeast YouTube: https://www.youtube.com/@uheartbeast

**Free Assets:**
- Poly Haven: https://polyhaven.com/
- Quaternius: https://quaternius.com/
- Kenney: https://kenney.nl/

**Community:**
- Godot Forum: https://forum.godotengine.org/
- Godot Discord: https://discord.gg/godot
- r/godot: https://reddit.com/r/godot

---

## 🆘 Butuh Bantuan?

Jika ada error atau masalah:

1. **Check Console Output:**
   - View → Output (atau Ctrl+Alt+O)
   - Lihat pesan error berwarna merah

2. **Check Scene Tree:**
   - Pastikan semua nodes ada
   - Pastify scripts ter-attach (icon skrip di node)

3. **Re-import Asset:**
   - Klik kanan file → Reimport

4. **Restart Godot:**
   - Kadang perlu restart setelah import besar

---

**Selamat bermain dan mengembangkan SILENT PEACE! 🌲🦌🌲**

> Game ini dibuat sebagai template. Silakan modifikasi sesuai kreativitas Anda!
