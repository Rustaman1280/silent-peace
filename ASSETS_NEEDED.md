# DAFTAR ASSET YANG DIBUTUHKAN

## Status: 🔴 PLACEHOLDER - Perlu Asset Real

Game saat ini menggunakan **placeholder meshes** (box, sphere, cylinder) untuk semua object. 
Untuk membuat game ini HD dan realistis, diperlukan asset 3D berkualitas tinggi.

---

## 🌳 3D MODELS - PRIORITAS TERTINGGI

### Trees (Pohon) - Min. 5 jenis
📁 Lokasi: `Assets/Models/Trees/`

**Yang dibutuhkan:**
- [ ] Pine Tree (Pohon Pinus) - 3-5 variasi
- [ ] Oak Tree (Pohon Oak) - 3-5 variasi  
- [ ] Birch Tree (Pohon Birch) - 2-3 variasi
- [ ] Dead Tree (Pohon Mati) - 1-2 variasi
- [ ] Young Tree (Pohon Muda) - 2-3 variasi

**Spesifikasi:**
- Format: `.glb` atau `.fbx`
- Polycount: 2000-5000 tris per pohon
- Tekstur: 2048x2048 (Albedo, Normal, Roughness)
- LOD: 3 levels (High, Medium, Low) - sangat direkomendasikan

**Sumber Gratis:**
- Quaternius Ultimate Nature Pack: https://quaternius.com/packs/ultimatenature.html
- Poly Haven Trees: https://polyhaven.com/models?t=tree
- Kenney Nature Kit: https://kenney.nl/assets/nature-kit

---

### Animals (Hewan) - Min. 3 jenis
📁 Lokasi: `Assets/Models/Animals/`

**Yang dibutuhkan:**
- [x] Rabbit (Kelinci) - **PRIORITY 1** ⭐
  - Dengan animasi: idle, walk, run, eat
  - Rigged untuk animasi
- [ ] Deer (Rusa) - PRIORITY 2
  - Dengan animasi: idle, walk, run, graze
- [ ] Fox (Rubah) - PRIORITY 3
- [ ] Birds (Burung) - untuk ambient
  - Simple model untuk terbang jauh

**Spesifikasi:**
- Format: `.glb` dengan armature/bones
- Polycount: 1500-3000 tris
- Tekstur: 1024x1024 atau 2048x2048
- Animasi: Embedded dalam file atau terpisah

**Sumber Gratis:**
- Quaternius Animals: https://quaternius.com/packs/ultimateanimatedanimals.html
- Mixamo (untuk rigging): https://www.mixamo.com
- Sketchfab Free Animals: https://sketchfab.com/search?features=downloadable&q=rabbit&type=models

---

### Props (Dekorasi) - Min. 10 jenis
📁 Lokasi: `Assets/Models/Props/`

**Yang dibutuhkan:**
- [ ] Rocks (Batu) - 5-10 variasi berbeda ukuran
- [ ] Bushes (Semak) - 3-5 variasi
- [ ] Grass Patches (Rumpun Rumput) - 5-7 variasi
- [ ] Flowers (Bunga) - 3-5 jenis
- [ ] Logs (Batang Kayu) - 2-3 variasi
- [ ] Mushrooms (Jamur) - 2-3 variasi
- [ ] Ferns (Pakis) - 2-3 variasi
- [ ] Tree Stumps (Tunggul) - 2 variasi

**Spesifikasi:**
- Format: `.glb` atau `.fbx`
- Polycount: 100-1000 tris (props kecil bisa sangat low poly)
- Tekstur: 512x512 atau 1024x1024

**Sumber Gratis:**
- Poly Haven Props: https://polyhaven.com/models?a=nature
- Kenney Nature Pack: https://kenney.nl/assets/nature-kit
- Free3D Nature: https://free3d.com/3d-models/nature

---

## 🎨 TEXTURES - PRIORITAS TINGGI

### Terrain Textures
📁 Lokasi: `Assets/Textures/Terrain/`

**Yang dibutuhkan:**
- [ ] Grass Texture Set ⭐
  - Albedo (diffuse)
  - Normal map
  - Roughness map
  - Ambient Occlusion (AO)
  - Size: 2048x2048 seamless
  
- [ ] Dirt/Ground Texture Set
  - Same maps as grass
  - For paths and clearings
  
- [ ] Rock/Stone Texture Set
  - For cliffs and boulders

**Format:** PNG atau JPG (PNG lebih baik untuk normal maps)

**Sumber Gratis:**
- Poly Haven Textures: https://polyhaven.com/textures (BEST!)
- CC0 Textures: https://cc0textures.com
- AmbientCG: https://ambientcg.com/list?type=Material

**Rekomendasi Spesifik:**
- Poly Haven: "Forest Ground" atau "Grass 001"
- CC0: Search "grass" atau "forest floor"

---

### Bark & Foliage Textures
📁 Lokasi: `Assets/Textures/Nature/`

**Yang dibutuhkan:**
- [ ] Tree Bark - 3-5 variasi
- [ ] Leaf Textures - dengan alpha channel
- [ ] Moss Texture
- [ ] Bark dengan lumut

Biasanya sudah included dengan 3D tree models.

---

## 🎵 AUDIO FILES - PRIORITAS SEDANG

### Ambient Sounds
📁 Lokasi: `Assets/Audio/`

**Yang dibutuhkan:**
- [ ] `forest_ambience.ogg` - Suara hutan general (1-2 menit loop)
- [ ] `birds.ogg` - Kicau burung (30-60 detik loop)
- [ ] `wind.ogg` - Hembusan angin lembut (30-60 detik loop)
- [ ] `crickets.ogg` - Jangkrik untuk malam (30-60 detik loop)

**Format:** `.ogg` (compressed, bagus untuk game)

**Sumber Gratis:**
- Freesound: https://freesound.org/search/?q=forest+ambience
- OpenGameArt: https://opengameart.org/art-search?keys=forest
- YouTube Audio Library: https://www.youtube.com/audiolibrary/music

**Cara Convert ke OGG:**
- Online: https://convertio.co/mp3-ogg/
- Software: Audacity (Export as OGG Vorbis)

---

### Sound Effects (SFX)
📁 Lokasi: `Assets/Audio/SFX/`

**Yang dibutuhkan:**
- [ ] Footsteps - grass, dirt, leaves (3-5 variasi each)
- [ ] Rabbit sounds - optional
- [ ] Rustle sounds - untuk bushes
- [ ] Bird chirps - individual

---

## 🌤️ SKYBOX - OPSIONAL TAPI BAGUS

📁 Lokasi: `Assets/Textures/Sky/`

**Yang dibutuhkan:**
- [ ] HDR Skybox untuk realistic lighting
- [ ] Cubemap (6 images) atau single HDR file

**Format:** 
- `.hdr` (best for lighting)
- `.exr`
- atau 6x PNG for cubemap

**Sumber Gratis:**
- Poly Haven HDRIs: https://polyhaven.com/hdris (BEST!)
- HDRI Haven: https://hdrihaven.com/

**Rekomendasi:**
- "Forest Slope" dari Poly Haven
- "Kiara Dawn" - untuk sunrise
- "Autumn Forest" - untuk suasana autumn

---

## 📦 CARA MENGINTEGRASIKAN ASSET

### Setelah Download Asset:

1. **Extract dan Organize:**
   ```
   Assets/
   ├── Models/
   │   ├── Trees/
   │   │   ├── pine_tree_01.glb
   │   │   ├── pine_tree_02.glb
   │   │   └── oak_tree_01.glb
   │   ├── Animals/
   │   │   └── rabbit.glb
   │   └── Props/
   │       ├── rock_01.glb
   │       └── bush_01.glb
   ```

2. **Import ke Godot:**
   - Drag & drop files ke folder di Godot FileSystem
   - Godot auto-import
   - Check import settings (klik file → Import tab)

3. **Update Scripts:**
   
   Edit `WorldManager.gd`:
   ```gdscript
   # Ganti bagian ini:
   func create_placeholder_tree() -> Node3D:
	   # OLD CODE - HAPUS
   
   # Dengan ini:
   func create_tree() -> Node3D:
	   var tree_models = [
		   preload("res://Assets/Models/Trees/pine_tree_01.glb"),
		   preload("res://Assets/Models/Trees/oak_tree_01.glb"),
	   ]
	   var random_tree = tree_models[randi() % tree_models.size()]
	   var tree = random_tree.instantiate()
	   tree.rotation.y = randf() * TAU
	   return tree
   ```

4. **Update Rabbit:**
   
   Edit `WorldManager.gd`:
   ```gdscript
   func create_rabbit() -> CharacterBody3D:
	   var rabbit_model = preload("res://Assets/Models/Animals/rabbit.glb")
	   var rabbit = rabbit_model.instantiate()
	   
	   # Add script
	   rabbit.set_script(preload("res://Assets/Scripts/Rabbit.gd"))
	   
	   # Add collision if not in model
	   if not rabbit.has_node("CollisionShape3D"):
		   var collision = CollisionShape3D.new()
		   var shape = CapsuleShape3D.new()
		   shape.radius = 0.25
		   shape.height = 0.5
		   collision.shape = shape
		   rabbit.add_child(collision)
	   
	   return rabbit
   ```

5. **Apply Textures:**
   - Buka MainWorld.tscn
   - Select Ground mesh
   - Di Inspector → Material → New StandardMaterial3D
   - Load texture ke Albedo, Normal, Roughness slots

---

## 🎯 PRIORITAS DOWNLOAD

**Phase 1 - Core Gameplay:**
1. ⭐⭐⭐ Rabbit model dengan animasi
2. ⭐⭐⭐ 2-3 Tree models
3. ⭐⭐ Grass terrain texture
4. ⭐⭐ Forest ambience sound

**Phase 2 - Visual Polish:**
5. ⭐⭐ Rock & bush props
6. ⭐⭐ More tree varieties
7. ⭐ Bark textures
8. ⭐ Bird sounds

**Phase 3 - Extra Polish:**
9. Skybox HDR
10. More animal models
11. Flower & mushroom props
12. Additional SFX

---

## 📊 ESTIMASI DOWNLOAD SIZE

- Trees (5 models): ~50-100 MB
- Animals (3 models): ~30-50 MB
- Props (15 models): ~40-80 MB
- Textures: ~100-200 MB
- Audio: ~20-50 MB
- Skybox: ~10-30 MB

**Total: ~250-510 MB**

Gunakan yang low-poly dulu jika koneksi lambat!

---

## ✅ CHECKLIST SEBELUM PLAY

Minimal yang HARUS ada agar game terlihat bagus:
- [ ] 2-3 jenis pohon 3D
- [ ] 1 model kelinci
- [ ] 1 texture set untuk tanah
- [ ] 1 forest ambience sound

Dengan 4 item di atas, game sudah bisa dimainkan dengan tampilan yang decent!

---

Silakan download asset yang Anda butuhkan, dan saya akan bantu mengintegrasikannya ke dalam game! 🎮🌲
