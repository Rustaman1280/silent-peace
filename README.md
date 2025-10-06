# SILENT PEACE - 3D Open World Forest Game

Game open world 3D berlatar hutan dengan sistem day/night cycle, wildlife AI, dan lingkungan yang immersive.

## Fitur Game

### ✅ Yang Sudah Dibuat:
1. **Player Controller**
   - First-person camera control
   - WASD movement
   - Sprint (Shift)
   - Jump (Space)
   - Mouse look

2. **Procedural World Generation**
   - Terrain dengan ukuran 200x200 units
   - 300 pohon (placeholder)
   - 20 kelinci dengan AI
   - 10 bukit
   - Fog system

3. **Wildlife AI (Kelinci)**
   - Wander behavior (jalan-jalan random)
   - Idle behavior (berdiri)
   - Flee behavior (lari dari player)
   - Detection system (deteksi player dalam radius 8 meter)

4. **Day/Night Cycle**
   - Siklus siang malam otomatis
   - Perubahan warna cahaya matahari
   - Perubahan ambient lighting
   - Durasi hari dapat disesuaikan

5. **UI System**
   - FPS counter
   - Crosshair
   - Control hints
   - Info display

6. **Audio System** (siap untuk audio files)
   - Forest ambience player
   - Bird sounds player
   - Wind sounds player

## Kontrol Game

- **WASD** - Bergerak
- **Mouse** - Lihat sekeliling
- **Space** - Lompat
- **Shift** - Sprint
- **ESC** - Toggle mouse capture

## Asset yang Diperlukan

Untuk membuat game ini lebih HD dan realistis, Anda perlu menambahkan asset berikut:

### 🌳 3D Models (Prioritas Tinggi):
1. **Pohon** - Format: .glb atau .fbx
   - Pine trees (pohon pinus)
   - Oak trees (pohon oak)
   - Birch trees (pohon birch)
   - Letakkan di: `Assets/Models/Trees/`

2. **Hewan** - Format: .glb atau .fbx
   - Rabbit model dengan animasi (idle, walk, run)
   - Deer (opsional)
   - Birds (opsional)
   - Letakkan di: `Assets/Models/Animals/`

3. **Environment Props**
   - Rocks (batu-batuan)
   - Bushes (semak-semak)
   - Grass patches (rumput)
   - Flowers (bunga)
   - Logs (batang kayu)
   - Letakkan di: `Assets/Models/Props/`

### 🎨 Textures (Prioritas Tinggi):
1. **Terrain Textures**
   - Grass texture (albedo, normal, roughness) - 2048x2048
   - Dirt path texture
   - Rock texture
   - Letakkan di: `Assets/Textures/Terrain/`

2. **Bark & Foliage Textures**
   - Tree bark textures
   - Leaf textures dengan alpha
   - Letakkan di: `Assets/Textures/Nature/`

### 🎵 Audio Files (Prioritas Sedang):
1. **Ambient Sounds** - Format: .ogg
   - `forest_ambience.ogg` - Suara hutan (burung, serangga, dll)
   - `birds.ogg` - Suara burung berkicau
   - `wind.ogg` - Suara angin sepoi-sepoi
   - Letakkan di: `Assets/Audio/`

2. **Sound Effects**
   - Footsteps (rumput, tanah, daun)
   - Animal sounds (kelinci, dll)
   - Letakkan di: `Assets/Audio/SFX/`

### 🌤️ Skybox (Opsional):
- HDR skybox untuk pencahayaan realistis
- Format: .hdr atau cubemap
- Letakkan di: `Assets/Textures/Sky/`

## Cara Setup Asset

### Setelah mendapat 3D Models:

1. **Import ke Godot:**
   - Drag & drop files ke folder yang sesuai
   - Godot akan otomatis import

2. **Update WorldManager.gd:**
   ```gdscript
   # Di bagian export variables, tambahkan:
   @export var tree_prefab: PackedScene = preload("res://Assets/Models/Trees/pine_tree.glb")
   @export var rabbit_prefab: PackedScene = preload("res://Assets/Models/Animals/rabbit.glb")
   ```

3. **Update fungsi create_placeholder_tree():**
   - Ganti dengan instantiate dari tree_prefab
   - Sesuaikan scale jika perlu

### Setelah mendapat Textures:

1. **Apply ke Terrain:**
   - Buka MainWorld.tscn
   - Select Ground mesh
   - Di Inspector, buat material baru
   - Import texture dan apply

### Setelah mendapat Audio:

1. **Load ke AmbientSound.gd:**
   ```gdscript
   var ambience = preload("res://Assets/Audio/forest_ambience.ogg")
   ambience_player.stream = ambience
   ```

## Struktur Project

```
silent-peace/
├── Assets/
│   ├── Audio/          # Audio files
│   ├── Materials/      # Material files
│   ├── Models/         # 3D models
│   │   ├── Animals/
│   │   ├── Trees/
│   │   └── Props/
│   ├── Scenes/         # Scene files
│   │   └── MainWorld.tscn  # Main game scene
│   ├── Scripts/        # GDScript files
│   │   ├── Player.gd
│   │   ├── WorldManager.gd
│   │   ├── Rabbit.gd
│   │   ├── DayNightCycle.gd
│   │   ├── AmbientSound.gd
│   │   └── GameUI.gd
│   ├── Textures/       # Texture files
│   │   ├── Terrain/
│   │   ├── Nature/
│   │   └── Sky/
│   └── UI/             # UI scenes
│       └── GameUI.tscn
└── project.godot       # Project config
```

## Cara Menjalankan

1. Buka project di Godot 4.x
2. Tekan F5 atau klik tombol Play
3. Game akan load scene MainWorld.tscn

## Tips Optimasi

Untuk performa yang lebih baik:

1. **LOD (Level of Detail)**
   - Gunakan model low-poly untuk objek jauh
   - Gunakan model high-poly untuk objek dekat

2. **Occlusion Culling**
   - Enable di Project Settings
   - Buat OccluderInstance3D untuk area tertutup

3. **Lighting**
   - Bake lighting untuk objek static
   - Gunakan LightmapGI untuk terrain

4. **Instancing**
   - Gunakan MultiMeshInstance3D untuk grass
   - Gunakan untuk rocks dan small props

## Pengembangan Selanjutnya

Fitur yang bisa ditambahkan:

- [ ] Inventory system
- [ ] Crafting system
- [ ] Weather system (hujan, salju)
- [ ] More animals (deer, fox, birds)
- [ ] Quest system
- [ ] Day/night wildlife behavior changes
- [ ] Player hunger/thirst system
- [ ] Shelter building
- [ ] Fishing system
- [ ] Seasons system

## Troubleshooting

### Kelinci tidak bergerak
- Pastikan script Rabbit.gd ter-attach
- Check collision layer settings

### FPS rendah
- Kurangi tree_count di WorldManager
- Disable shadows sementara
- Gunakan renderer mobile

### Mouse tidak ter-capture
- Tekan ESC untuk toggle
- Check Input settings di project.godot

## Resource Gratis untuk Asset

### 3D Models:
- **Poly Haven** - polyhaven.com (trees, rocks, props)
- **Quaternius** - quaternius.com (low-poly animals & nature)
- **Kenney** - kenney.nl (stylized nature assets)
- **Sketchfab** - sketchfab.com (filter: free downloads)

### Textures:
- **Poly Haven** - polyhaven.com/textures
- **CC0 Textures** - cc0textures.com
- **Texture Haven** - texturehaven.com

### Audio:
- **Freesound** - freesound.org
- **OpenGameArt** - opengameart.org
- **BBC Sound Effects** - bbcsfx.acropolis.org.uk

## License

Project ini menggunakan Godot Engine 4.x (MIT License)
Silakan gunakan untuk pembelajaran atau project pribadi.

---

**Dibuat dengan ❤️ menggunakan Godot 4.x**
