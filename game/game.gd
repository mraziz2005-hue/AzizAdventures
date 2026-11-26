extends Node2D
# Original local platform game. All art and sound effects are generated here.
const W = 1280.0
const H = 720.0
const FLOOR = 600.0
const SPEED = 332.0
const GRAVITY = 1350.0
const JUMP = -665.0
const PLAYER_SIZE = Vector2(34, 44)
const INK = Color("#142637")
const WHITE = Color("#f8fbff")
const GOLD = Color("#ffd374")
const CYAN = Color("#79e5e1")
const STAGES = [
	{"name":"FROSTWIND RIDGE","sub":"01 / Where the journey begins","sky":"#16334e","low":"#a0d7d4","far":"#477e92","near":"#26596a","soil":"#203c56","edge":"#bcf3f5","length":3970,
	"ground":[[0,770],[920,600],[1685,690],[2545,600],[3305,665]],
	"ledges":[[515,485,150],[790,505,105],[1110,460,140],[1465,480,130],[1800,465,140],[2105,405,145],[2395,490,130],[2740,465,145],[3155,488,130],[3500,445,160]],
	"enemies":[[620,750],[1070,1430],[1800,2180],[2660,3010],[3440,3760]],"checkpoint":1715},
	{"name":"AMBER CANYON","sub":"02 / Into the golden sands","sky":"#542d4b","low":"#ffc78b","far":"#b96762","near":"#784551","soil":"#633c4a","edge":"#ffd495","length":4420,
	"ground":[[0,580],[740,420],[1335,520],[2030,570],[2770,490],[3435,985]],
	"ledges":[[390,470,140],[595,490,130],[875,435,145],[1175,505,147],[1460,460,140],[1870,485,145],[2240,430,155],[2615,475,140],[2960,460,150],[3280,495,145],[3630,440,160]],
	"enemies":[[220,475],[805,1070],[1425,1780],[2160,2480],[2840,3150],[3530,3810],[3990,4250]],"checkpoint":2045},
	{"name":"AURORA CORE","sub":"03 / The guardian awaits","sky":"#11142f","low":"#47588a","far":"#353c73","near":"#24264e","soil":"#292c57","edge":"#b3a8ff","length":4800,
	"ground":[[0,570],[745,480],[1395,570],[2145,570],[2875,480],[3525,1275]],
	"ledges":[[355,465,145],[585,490,145],[930,430,150],[1230,485,155],[1555,430,155],[1990,500,140],[2350,440,170],[2725,480,140],[3020,430,160],[3375,480,145],[3680,480,160],[4035,435,150]],
	"enemies":[[260,500],[810,1140],[1470,1870],[2250,2620],[2920,3260]],"checkpoint":2160},
	{"name":"WHISPERWOOD","sub":"04 / The sleeping forest","sky":"#132f37","low":"#92c8a0","far":"#487d62","near":"#25574c","soil":"#284d45","edge":"#b4e69a","length":4860,
	"ground":[[0,640],[805,550],[1515,625],[2305,590],[3065,540],[3785,1075]],
	"ledges":[[495,475,150],[660,505,125],[1000,440,160],[1365,490,145],[1650,445,155],[2150,485,140],[2515,430,170],[2905,480,145],[3270,425,150],[3610,490,145],[3915,455,165],[4190,425,150]],
	"enemies":[[405,605],[895,1275],[1630,2070],[2440,2820],[3160,3510],[3860,4080]],"checkpoint":2325},
	{"name":"EMBERFORGE","sub":"05 / Across the molten valley","sky":"#441d32","low":"#e8894f","far":"#9a4645","near":"#622b40","soil":"#4d2936","edge":"#ffb76b","length":5080,
	"ground":[[0,610],[785,540],[1495,565],[2240,620],[3040,550],[3775,1305]],
	"ledges":[[475,460,140],[620,505,135],[975,445,155],[1340,480,145],[1660,430,170],[2075,490,145],[2460,430,150],[2880,500,140],[3270,450,140],[3600,490,145],[3920,455,165],[4310,425,165]],
	"enemies":[[390,575],[880,1250],[1585,1995],[2390,2800],[3120,3520],[3835,4080]],"checkpoint":2260},
	{"name":"SAPPHIRE GROTTO","sub":"06 / Beneath the mountain","sky":"#141e3c","low":"#3b7390","far":"#3f5380","near":"#253d60","soil":"#233b5c","edge":"#83e3ff","length":5200,
	"ground":[[0,610],[785,500],[1460,590],[2225,610],[3010,585],[3770,1430]],
	"ledges":[[465,465,140],[620,490,145],[955,435,145],[1300,490,145],[1650,435,150],[2070,495,140],[2440,415,160],[2850,480,145],[3230,430,160],[3610,495,145],[3915,455,160],[4400,425,170]],
	"enemies":[[385,575],[875,1205],[1545,1985],[2360,2760],[3110,3520],[3825,4110]],"checkpoint":2245},
	{"name":"THE SILENT CITY","sub":"07 / The last signal","sky":"#29283f","low":"#dc9290","far":"#67556b","near":"#3d354f","soil":"#303448","edge":"#f0bcaa","length":5480,
	"ground":[[0,650],[825,520],[1520,610],[2305,560],[3040,630],[3845,1635]],
	"ledges":[[495,465,145],[665,500,140],[1005,445,155],[1360,480,145],[1760,430,170],[2145,490,145],[2525,440,150],[2885,490,145],[3280,430,160],[3685,480,140],[4050,455,170],[4550,415,165]],
	"enemies":[[400,605],[915,1275],[1615,2030],[2390,2800],[3130,3600],[3915,4210]],"checkpoint":2325}
]
const BOSS_NAMES = ["","","AURORA GUARDIAN","THORN WARDEN","MOLTEN TITAN","CRYSTAL CRAWLER","SIGNAL SENTINEL"]
const BOSS_COLORS = ["#587a9b","#cf7e65","#8c6cd6","#47876a","#e77745","#4aa8cc","#968da9"]
const TROPHIES = [
	["first_gem","BRONZE","Shiny!","Collect your first crystal."],
	["first_stomp","BRONZE","Happy Feet","Defeat an enemy by jumping on it."],
	["first_secret","BRONZE","Curious Penguin","Find your first hidden alcove."],
	["first_clear","BRONZE","The Journey Begins","Complete any stage."],
	["shop","BRONZE","Looking Cool","Purchase an item in the shop."],
	["three","SILVER","Pathfinder","Complete three different stages."],
	["gems100","SILVER","Crystal Collector","Earn 100 crystals from cleared stages."],
	["perfect","SILVER","No Crystal Left Behind","Collect every crystal in one stage."],
	["boss","SILVER","Guardian Down","Defeat any guardian."],
	["speed","SILVER","Snowball Express","Complete a stage in under 32 seconds."],
	["nohit","GOLD","Untouchable","Finish a guardian stage without losing a heart."],
	["all_stages","GOLD","World Wanderer","Complete all seven stages."],
	["all_secrets","GOLD","Beyond the Map","Find the secret in every stage."],
	["legend","GOLD","LEGENDARY","Finish all seven stages on LEGENDARY."],
	["all_bosses","GOLD","Guardian Hunter","Defeat all five guardians."],
	["platinum","PLATINUM","AZIZ THE LEGEND","Unlock all 15 other trophies."]
]
const SHOP = [
	["scarf_blue",35,"Aurora Scarf","A cool turquoise scarf.",Color("#62e6e8")],
	["scarf_gold",55,"Sunrise Scarf","A bright golden scarf.",Color("#ffc65d")],
	["scarf_violet",75,"Royal Scarf","A violet scarf fit for a champion.",Color("#ba9aff")],
	["dash_upgrade",90,"Rocket Flippers","Shorter dash cooldown in Normal.",Color("#fe986a")],
	["double_jump",120,"Sky Flippers","One air jump in Normal mode.",Color("#77c9ff")]
]
const SECRET_ANCHORS = [[220,1],[1010,-1],[1440,1],[2020,-1],[2300,1],[3450,-1],[3920,1]]
var stage = 0
var unlocked = 0
var mode = "menu"
var p = Vector2(100, FLOOR)
var v = Vector2.ZERO
var camera_x = 0.0
var t = 0.0
var grounded = false
var coyote = 0.0
var buffer = 0.0
var face = 1.0
var hp = 3
var coins = 0
var total_coins = 0
var deaths = 0
var elapsed = 0.0
var invul = 0.0
var dash_timer = 0.0
var dash_cd = 0.0
var checkpoint = false
var solids: Array[Rect2] = []
var gems: Array[Dictionary] = []
var mobs: Array[Dictionary] = []
var particles: Array[Dictionary] = []
var boss_hp = 0
var boss_x = 4350.0
var boss_dir = -1.0
var boss_hit = 0.0
var boss_phase = 0.0
var sparks: Array[Dictionary] = []
var message = ""
var message_time = 0.0
var buttons: Array[Dictionary] = []
var focus_index = 0
var menu_stage = 0
var muted = false
var sounds: Dictionary = {}
var rng = RandomNumberGenerator.new()
var font = ThemeDB.fallback_font
var last_jump = false
var last_dash = false
var save_path = "user://aziz_save.cfg"
var testing = false
var legendary = false
var wallet = 0
var lifetime_gems = 0
var owned: Array = []
var equipped_scarf = "default"
var trophies: Array = []
var trophy_queue: Array = []
var trophy_current = ""
var trophy_time = 0.0
var trophy_page = 0
var best_normal: Dictionary = {}
var best_legendary: Dictionary = {}
var completed: Array = []
var legend_completed: Array = []
var secrets_found: Array = []
var bosses_defeated: Array = []
var stage_time = 0.0
var hits_taken = 0
var new_record = false
var air_jump_used = false
var secret_revealed = false
var secret_pos = Vector2(382,225)
var secret_route: Array[Rect2] = []
var boss_max_hp = 0
var boss_y = FLOOR
var boss_age = 0.0
var dash_duration = 0.95
var screen_flash = 0.0
var player_squash = 0.0

func _ready():
	rng.seed = 131
	testing = "--self-test" in OS.get_cmdline_user_args()
	build_sounds()
	if not testing: DisplayServer.window_set_title("Aziz Adventures")
	load_save()
	build_stage(0)
	mode = "menu"
	if testing:
		call_deferred("self_test")
	queue_redraw()

func load_save():
	if testing: return
	var cfg = ConfigFile.new()
	if cfg.load(save_path) == OK:
		unlocked = clampi(int(cfg.get_value("game","unlocked",0)),0,STAGES.size()-1)
		muted = bool(cfg.get_value("settings","muted",false))
		legendary = bool(cfg.get_value("settings","legendary",false))
		wallet = maxi(0,int(cfg.get_value("progress","wallet",0)))
		lifetime_gems = maxi(0,int(cfg.get_value("progress","lifetime_gems",0)))
		owned = cfg.get_value("progress","owned",[])
		equipped_scarf = str(cfg.get_value("progress","scarf","default"))
		trophies = cfg.get_value("progress","trophies",[])
		completed = cfg.get_value("progress","completed",[])
		legend_completed = cfg.get_value("progress","legend_completed",[])
		secrets_found = cfg.get_value("progress","secrets",[])
		bosses_defeated = cfg.get_value("progress","bosses",[])
		best_normal = cfg.get_value("records","normal",{})
		best_legendary = cfg.get_value("records","legendary",{})

func save_game():
	if testing: return
	var cfg = ConfigFile.new()
	cfg.set_value("game","unlocked",unlocked)
	cfg.set_value("settings","muted",muted)
	cfg.set_value("settings","legendary",legendary)
	for item in [["wallet",wallet],["lifetime_gems",lifetime_gems],["owned",owned],["scarf",equipped_scarf],["trophies",trophies],["completed",completed],["legend_completed",legend_completed],["secrets",secrets_found],["bosses",bosses_defeated]]:
		cfg.set_value("progress",item[0],item[1])
	cfg.set_value("records","normal",best_normal)
	cfg.set_value("records","legendary",best_legendary)
	cfg.save(save_path)

func earn(id: String):
	if id in trophies: return
	trophies.append(id)
	trophy_queue.append(id)
	if id!="platinum" and trophies.size()==TROPHIES.size()-1:
		earn("platinum")
	save_game()

func trophy_data(id: String) -> Array:
	for item in TROPHIES:
		if item[0]==id: return item
	return []

func shop_action(id: String):
	for item in SHOP:
		if item[0]!=id: continue
		if id in owned:
			if id.begins_with("scarf"):
				equipped_scarf = "default" if equipped_scarf==id else id
				save_game()
			return
		if wallet<item[1]: return
		wallet-=item[1]
		owned.append(id)
		if id.begins_with("scarf"): equipped_scarf=id
		earn("shop")
		save_game()
		return

func scarf_color() -> Color:
	for item in SHOP:
		if item[0]==equipped_scarf: return item[4]
	return Color("#ff756a")

func time_string(value: float) -> String:
	if value<=0: return "--:--.---"
	var ms=int(value*1000)
	return "%02d:%02d.%03d" % [ms/60000,ms/1000%60,ms%1000]

func best_time(index: int, hard: bool) -> float:
	var records = best_legendary if hard else best_normal
	return float(records.get(str(index),0.0))

func finish_stage():
	total_coins += coins
	wallet += coins
	lifetime_gems += coins
	var records = best_legendary if legendary else best_normal
	var previous = float(records.get(str(stage),0.0))
	new_record = previous<=0 or stage_time<previous
	if new_record: records[str(stage)] = stage_time
	if stage not in completed: completed.append(stage)
	if legendary and stage not in legend_completed: legend_completed.append(stage)
	unlocked = maxi(unlocked,mini(stage+1,STAGES.size()-1))
	earn("first_clear")
	if completed.size()>=3: earn("three")
	if lifetime_gems>=100: earn("gems100")
	if coins==gems.size(): earn("perfect")
	if stage_time<32.0: earn("speed")
	if boss_max_hp>0 and hits_taken==0: earn("nohit")
	if completed.size()==STAGES.size(): earn("all_stages")
	if legend_completed.size()==STAGES.size(): earn("legend")
	save_game(); sfx("win")
	set_mode("victory" if stage==STAGES.size()-1 else "clear")

func build_sounds():
	for spec in [["jump",390.0,820.0,0.12],["coin",880.0,1450.0,0.12],["hit",210.0,80.0,0.21],["stomp",180.0,460.0,0.12],["dash",350.0,120.0,0.16],["win",520.0,1040.0,0.42],["check",620.0,1100.0,0.25]]:
		var stream = AudioStreamWAV.new()
		stream.format = AudioStreamWAV.FORMAT_16_BITS
		stream.mix_rate = 22050
		var n = int(spec[3] * 22050)
		var data = PackedByteArray()
		data.resize(n*2)
		var phase = 0.0
		for i in range(n):
			var u = float(i)/n
			phase += TAU * lerpf(spec[1],spec[2],u)/22050.0
			var envelope = minf(u*30.0,1.0)*pow(1.0-u,2.0)
			var val = int((sin(phase)*0.75+sin(phase*2.0)*0.20)*envelope*10000)
			data.encode_s16(i*2,val)
		stream.data = data
		sounds[spec[0]] = stream

func sfx(which: String):
	if muted or testing: return
	var a = AudioStreamPlayer.new()
	a.stream = sounds[which]
	a.volume_db = -7
	add_child(a)
	a.finished.connect(a.queue_free)
	a.play()

func build_stage(index: int):
	stage = index
	var data = STAGES[stage]
	solids.clear(); gems.clear(); mobs.clear(); particles.clear(); sparks.clear()
	for x in data.ground:
		solids.append(Rect2(x[0],FLOOR,x[1],150))
		for i in range(int((x[1]-130)/105)+1):
			gems.append({"pos":Vector2(x[0]+80+i*105,FLOOR-41),"got":false})
	for x in data.ledges:
		solids.append(Rect2(x[0],x[1],x[2],32))
		for i in range(3):
			gems.append({"pos":Vector2(x[0]+22+i*(x[2]-44)/2.0,x[1]-40),"got":false})
	# Hidden alcoves occupy different places and face different directions.
	var anchor=float(SECRET_ANCHORS[stage][0])
	var direction=float(SECRET_ANCHORS[stage][1])
	secret_route=[Rect2(anchor,480,112,22),Rect2(anchor+direction*75,365,100,22),Rect2(anchor+direction*135,250,108,22)]
	for rect in secret_route: solids.append(rect)
	secret_pos=Vector2(secret_route[2].get_center().x,225)
	for i in range(5):
		gems.append({"pos":secret_pos+Vector2(-40+i*20,-15-sin(i*PI/4)*20),"got":false,"secret":true})
	for x in data.enemies:
		mobs.append({"x":float(x[0]),"a":float(x[0]),"b":float(x[1]),"dir":1.0,"alive":true})
	p = Vector2(100,FLOOR); v = Vector2.ZERO; camera_x = 0.0
	grounded = true; coyote = 0; buffer = 0; face = 1.0
	hp = 1 if legendary else 3; invul = 0; dash_timer = 0; dash_cd = 0
	coins = 0; checkpoint = false
	stage_time=0; hits_taken=0; new_record=false; secret_revealed=false
	air_jump_used=false; player_squash=0; screen_flash=0
	dash_duration=0.64 if "dash_upgrade" in owned and not legendary else 0.95
	boss_max_hp = 0 if stage<2 else (4 if stage==6 else 3)
	boss_hp = boss_max_hp
	boss_x = float(data.length)-450; boss_y=FLOOR; boss_dir = -1; boss_hit = 0; boss_phase = 0; boss_age=0
	message = "LEGENDARY: one heart. No upgrades." if legendary else "Find the beacon. Keep moving!"
	message_time = 3.1
	last_jump = false; last_dash = false

func start_game(idx: int):
	total_coins = 0; elapsed = 0; deaths = 0
	build_stage(idx)
	mode = "play"; focus_index = 0

func set_mode(next: String):
	mode = next; focus_index = 0
	buttons.clear()

func activate(id: String):
	if id.begins_with("buy:"):
		shop_action(id.substr(4)); return
	match id:
		"play": start_game(menu_stage)
		"prev": menu_stage = maxi(0,menu_stage-1); build_stage(menu_stage)
		"next": menu_stage = mini(unlocked,menu_stage+1); build_stage(menu_stage)
		"mute": muted = not muted; save_game()
		"difficulty": legendary=not legendary; build_stage(menu_stage); save_game()
		"shop": set_mode("shop")
		"trophies": trophy_page=0; set_mode("trophies")
		"records": set_mode("records")
		"trophy_prev": trophy_page=maxi(0,trophy_page-1)
		"trophy_next": trophy_page=mini(1,trophy_page+1)
		"default_scarf": equipped_scarf="default"; save_game()
		"back": set_mode("menu"); build_stage(menu_stage)
		"quit": get_tree().quit()
		"resume": set_mode("play")
		"retry": build_stage(stage); set_mode("play")
		"menu": menu_stage = stage; build_stage(menu_stage); set_mode("menu")
		"continue":
			if stage < STAGES.size()-1:
				build_stage(stage+1); set_mode("play")
		"again": start_game(0)

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_F11:
			var full = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if full else DisplayServer.WINDOW_MODE_FULLSCREEN)
		elif event.keycode == KEY_M:
			muted = not muted; save_game()
		elif event.keycode == KEY_ESCAPE:
			if mode == "play": set_mode("pause")
			elif mode == "pause": set_mode("play")
			elif mode in ["shop","trophies","records"]: activate("back")
			elif mode != "menu": activate("menu")
		elif mode != "play":
			if event.keycode in [KEY_DOWN,KEY_RIGHT,KEY_TAB]:
				focus_index = (focus_index+1)%maxi(1,buttons.size())
			elif event.keycode in [KEY_UP,KEY_LEFT]:
				focus_index = posmod(focus_index-1,maxi(1,buttons.size()))
			elif event.keycode in [KEY_ENTER,KEY_SPACE] and buttons.size()>0:
				activate(buttons[clampi(focus_index,0,buttons.size()-1)].id)
	if event is InputEventJoypadButton and event.pressed:
		if event.button_index == JOY_BUTTON_START:
			if mode == "play": set_mode("pause")
			elif mode == "pause": set_mode("play")
		elif mode != "play":
			if event.button_index in [JOY_BUTTON_DPAD_DOWN,JOY_BUTTON_DPAD_RIGHT]:
				focus_index = (focus_index+1)%maxi(1,buttons.size())
			elif event.button_index in [JOY_BUTTON_DPAD_UP,JOY_BUTTON_DPAD_LEFT]:
				focus_index = posmod(focus_index-1,maxi(1,buttons.size()))
			elif event.button_index == JOY_BUTTON_A and buttons.size()>0:
				activate(buttons[clampi(focus_index,0,buttons.size()-1)].id)
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and mode != "play":
		for btn in buttons:
			if btn.rect.has_point(get_global_mouse_position()):
				activate(btn.id); break

func _physics_process(dt):
	t += dt
	screen_flash=maxf(0,screen_flash-dt*3)
	player_squash=move_toward(player_squash,0,dt*4)
	if trophy_time>0: trophy_time-=dt
	if trophy_time<=0 and trophy_queue.size()>0:
		trophy_current=trophy_queue.pop_front()
		trophy_time=4.0
		sfx("win")
	if mode == "play":
		var x = float(Input.is_physical_key_pressed(KEY_RIGHT) or Input.is_physical_key_pressed(KEY_D))-float(Input.is_physical_key_pressed(KEY_LEFT) or Input.is_physical_key_pressed(KEY_A))
		var jump_down = Input.is_physical_key_pressed(KEY_SPACE) or Input.is_physical_key_pressed(KEY_W) or Input.is_physical_key_pressed(KEY_UP)
		var dash_down = Input.is_physical_key_pressed(KEY_SHIFT) or Input.is_physical_key_pressed(KEY_X)
		for pad in Input.get_connected_joypads():
			var axis = Input.get_joy_axis(pad,JOY_AXIS_LEFT_X)
			if absf(axis)>0.22: x = axis
			if Input.is_joy_button_pressed(pad,JOY_BUTTON_DPAD_LEFT): x = -1
			if Input.is_joy_button_pressed(pad,JOY_BUTTON_DPAD_RIGHT): x = 1
			jump_down = jump_down or Input.is_joy_button_pressed(pad,JOY_BUTTON_A)
			dash_down = dash_down or Input.is_joy_button_pressed(pad,JOY_BUTTON_X) or Input.is_joy_button_pressed(pad,JOY_BUTTON_RIGHT_SHOULDER)
		tick(dt,x,jump_down,dash_down)
	for part in particles:
		part.pos += part.vel*dt
		part.vel.y += 430*dt
		part.life -= dt
	particles = particles.filter(func(a): return a.life>0)
	queue_redraw()

func tick(dt: float, x: float, jump_down: bool, dash_down: bool):
	elapsed += dt; stage_time += dt
	invul = maxf(0,invul-dt); dash_cd = maxf(0,dash_cd-dt)
	message_time = maxf(0,message_time-dt)
	boss_hit = maxf(0,boss_hit-dt)
	if grounded: coyote = 0.11
	else: coyote = maxf(0,coyote-dt)
	buffer = maxf(0,buffer-dt)
	if jump_down and not last_jump: buffer = 0.13
	if absf(x)>0.15: face = signf(x)
	if buffer>0 and coyote>0:
		v.y = JUMP; grounded = false; coyote = 0; buffer = 0
		burst(p+Vector2(0,-3),WHITE,8); sfx("jump")
	elif jump_down and not last_jump and not grounded and not air_jump_used and "double_jump" in owned and not legendary:
		v.y=-515; air_jump_used=true; buffer=0; coyote=0
		burst(p-Vector2(0,15),CYAN,12); sfx("jump")
	if not jump_down and last_jump and v.y < -240: v.y = -240
	if dash_down and not last_dash and dash_cd<=0:
		dash_timer = 0.19; dash_cd = dash_duration; v.y = minf(v.y,0); sfx("dash")
	last_jump = jump_down; last_dash = dash_down
	var old = p
	if dash_timer>0:
		dash_timer -= dt; v.x = face*690; v.y += GRAVITY*0.18*dt
		burst(p+Vector2(-face*15,-18),CYAN,1)
	else:
		v.x = move_toward(v.x,x*SPEED,(2250.0 if grounded else 1500.0)*dt)
		v.y = minf(v.y+GRAVITY*dt,960)
	p += v*dt
	p.x = clampf(p.x,20,float(STAGES[stage].length)-25)
	grounded = false
	if v.y >= 0:
		var surface = INF
		for rect in solids:
			if p.x+PLAYER_SIZE.x/2>rect.position.x and p.x-PLAYER_SIZE.x/2<rect.end.x and old.y<=rect.position.y+0.5 and p.y>=rect.position.y:
				surface = minf(surface,rect.position.y)
		if surface < INF:
			p.y = surface; v.y = 0; grounded = true; air_jump_used=false
			if old.y < surface-6: burst(p,WHITE,5); player_squash=0.22
	if p.y>770:
		hurt(true)
		return
	if not secret_revealed and (p-Vector2(0,23)).distance_to(secret_pos)<46:
		secret_revealed=true
		if stage not in secrets_found: secrets_found.append(stage)
		earn("first_secret")
		if secrets_found.size()==STAGES.size(): earn("all_secrets")
		save_game(); notice("Hidden alcove discovered!"); sfx("check")
		burst(secret_pos,GOLD,22)
	for gem in gems:
		if not gem.got and (not gem.get("secret",false) or secret_revealed) and gem.pos.distance_to(p-Vector2(0,23))<32:
			gem.got = true; coins += 1; sfx("coin"); burst(gem.pos,GOLD,7); earn("first_gem")
	var cp = float(STAGES[stage].checkpoint)
	if not checkpoint and p.x >= cp and p.x < cp+120 and p.y > FLOOR-85:
		checkpoint = true
		hp = 1 if legendary else 3
		if not legendary: invul = maxf(invul,0.8)
		sfx("check"); notice("Beacon reached — no respawn in LEGENDARY." if legendary else "Checkpoint activated!")
		burst(Vector2(cp,FLOOR-75),CYAN,18)
	for mob in mobs:
		if not mob.alive: continue
		mob.x += mob.dir*(85+stage*20)*dt
		if mob.x<mob.a or mob.x>mob.b:
			mob.x = clampf(mob.x,mob.a,mob.b); mob.dir *= -1
		if absf(p.x-mob.x)<31 and p.y>FLOOR-34 and p.y-PLAYER_SIZE.y<FLOOR-4:
			if v.y>=0 and old.y<=FLOOR-29:
				mob.alive = false; v.y = -430; grounded = false
				sfx("stomp"); burst(Vector2(mob.x,FLOOR-17),CYAN,14); earn("first_stomp")
			else:
				hurt(false)
				if mode!="play": return
	if boss_hp>0 and p.x>float(STAGES[stage].length)-1030:
		update_boss(dt,old)
		if mode!="play": return
	if p.x>float(STAGES[stage].length)-130 and p.y>FLOOR-90:
		if boss_hp==0: finish_stage()
		elif message_time<0.2: notice("Defeat the guardian to activate the beacon!")
	camera_x = lerpf(camera_x,clampf(p.x-350,0,float(STAGES[stage].length)-W),minf(1,dt*7.5))

func boss_vulnerable() -> bool:
	if stage==3: return boss_y>FLOOR-25
	if stage==4: return boss_phase<0.85
	if stage==5: return fmod(boss_age,3.4)<2.25
	if stage==6: return boss_phase<0.88
	return true

func update_boss(dt: float,old: Vector2):
	var finish=float(STAGES[stage].length)
	boss_phase+=dt; boss_age+=dt
	var speed=110.0+(boss_max_hp-boss_hp)*28
	# Each guardian has a readable, original attack pattern.
	match stage:
		2: speed=125.0+(boss_max_hp-boss_hp)*35
		3: boss_y=FLOOR-maxf(0.0,sin(fmod(boss_age,3.6)/3.6*TAU))*95.0
		4: speed=85.0
		5: speed=290.0 if fmod(boss_age,3.4)>2.25 else 55.0
		6: speed=95.0+(boss_max_hp-boss_hp)*35
	boss_x+=boss_dir*speed*dt
	if boss_x<finish-700 or boss_x>finish-190:
		boss_x=clampf(boss_x,finish-700,finish-190); boss_dir*=-1
	var interval=1.85 if stage==2 else 2.2 if stage==3 else 1.6 if stage==4 else 2.5 if stage==5 else 1.5
	if boss_phase>interval:
		boss_phase=0
		var direction=signf(p.x-boss_x)
		match stage:
			3: # leafy ground pulse on landing
				sparks.append({"pos":Vector2(boss_x,FLOOR-14),"vel":Vector2(direction*205,0),"life":3.0,"gravity":0.0,"kind":"leaf"})
			4: # arcing fireballs
				sparks.append({"pos":Vector2(boss_x,boss_y-35),"vel":Vector2(direction*195,-390),"life":3.0,"gravity":670.0,"kind":"fire"})
			5: # fast crystal shot
				sparks.append({"pos":Vector2(boss_x,FLOOR-17),"vel":Vector2(direction*365,0),"life":2.6,"gravity":0.0,"kind":"crystal"})
			6: # alternating heights
				var height=25 if int(boss_age/interval)%2==0 else 95
				sparks.append({"pos":Vector2(boss_x,FLOOR-height),"vel":Vector2(direction*325,0),"life":3.0,"gravity":0.0,"kind":"signal"})
			_: sparks.append({"pos":Vector2(boss_x,FLOOR-22),"vel":Vector2(direction*250,0),"life":3.0,"gravity":0.0,"kind":"aurora"})
	if absf(p.x-boss_x)<50 and p.y>boss_y-78 and p.y-44<boss_y:
		if v.y>=0 and old.y<=boss_y-62:
			if not boss_vulnerable() or boss_hit>0:
				v.y=-450; grounded=false; p.y=minf(p.y,boss_y-78)
				if not boss_vulnerable(): notice("Shielded! Wait until the core glows green.")
				return
			boss_hp-=1; boss_hit=0.65; v.y=-520; grounded=false
			p.y=minf(p.y,boss_y-78)
			sfx("stomp"); burst(Vector2(boss_x,boss_y-50),GOLD,25)
			if boss_hp==0:
				if stage not in bosses_defeated: bosses_defeated.append(stage)
				earn("boss")
				if bosses_defeated.size()==STAGES.size()-2: earn("all_bosses")
				save_game(); notice("Guardian defeated! Reach the beacon.")
				sfx("win"); sparks.clear()
		elif boss_hit<=0: hurt(false)
	for spark in sparks:
		spark.vel.y+=spark.gravity*dt
		spark.pos+=spark.vel*dt; spark.life-=dt
		if spark.pos.y>FLOOR-10: spark.life=0
		if spark.pos.distance_to(p-Vector2(0,22))<29:
			hurt(false); spark.life=0
	sparks=sparks.filter(func(a): return a.life>0)

func hurt(fall: bool):
	if invul>0 and not fall: return
	hp -= 1; hits_taken+=1; screen_flash=0.7; sfx("hit"); burst(p-Vector2(0,20),Color("#ff8d83"),17)
	if hp<=0:
		deaths+=1; set_mode("lost"); return
	invul = 1.5
	if fall:
		p = Vector2(float(STAGES[stage].checkpoint)+35 if checkpoint else 100,FLOOR-2)
		camera_x = clampf(p.x-350,0,float(STAGES[stage].length)-W)
		v=Vector2.ZERO; notice("Back on solid ground!")
	else:
		v.y=-280; v.x=-face*230

func notice(s: String):
	message=s; message_time=2.8

func burst(where: Vector2, color: Color, amount: int):
	for i in range(amount):
		var a=rng.randf_range(0,TAU); var speed=rng.randf_range(25,140)
		var life=rng.randf_range(0.22,0.56)
		particles.append({"pos":where,"vel":Vector2(cos(a),sin(a))*speed-Vector2(0,25),"life":life,"max":life,"color":color,"size":rng.randf_range(2,5)})

func _draw():
	var data=STAGES[stage]
	var cam=0.0 if mode in ["menu","shop","trophies","records"] else camera_x
	draw_background(data,cam)
	draw_set(data,cam)
	for gem in gems:
		if not gem.got and (not gem.get("secret",false) or secret_revealed) and absf(gem.pos.x-cam-W/2)<W/2+60:
			draw_gem(gem.pos-Vector2(cam,0)+Vector2(0,sin(t*3.2+gem.pos.x*0.025)*5),8)
	for mob in mobs:
		if mob.alive and absf(mob.x-cam-W/2)<W/2+70: draw_mob(Vector2(mob.x-cam,FLOOR),mob.dir,false)
	if boss_hp>0:
		draw_mob(Vector2(boss_x-cam,boss_y),boss_dir,true)
		for spark in sparks:
			var q=spark.pos-Vector2(cam,0)
			var color=Color(BOSS_COLORS[stage])
			draw_circle(q,19,Color(color,0.27)); draw_circle(q,10,color); draw_circle(q,4,WHITE)
	var sq=secret_pos-Vector2(cam,0)
	if not secret_revealed:
		draw_circle(sq,9+sin(t*3)*3,Color(GOLD,0.25))
		draw_circle(sq,3,Color(GOLD,0.9))
	else:
		center(sq+Vector2(30,-45),"HIDDEN ALCOVE",12,GOLD)
	var cp=Vector2(float(data.checkpoint)-cam,FLOOR)
	draw_beacon(cp,checkpoint,false)
	draw_beacon(Vector2(float(data.length)-100-cam,FLOOR),boss_hp==0,true)
	for part in particles:
		var color: Color=part.color
		color.a=clampf(part.life/part.max,0,1)
		draw_circle(part.pos-Vector2(cam,0),part.size,color)
	if mode in ["menu","shop","trophies","records"]:
		draw_penguin(Vector2(1025,563),1.0,2.7,false)
	else:
		if invul<=0 or int(t*14)%2==0:
			draw_penguin(p-Vector2(cam,0),face,1.0,absf(v.x)>20 and grounded)
		draw_hud(data)
		if screen_flash>0: draw_rect(Rect2(0,0,W,H),Color(1,.25,.22,screen_flash*.13))
	buttons.clear()
	match mode:
		"menu": draw_menu()
		"shop": draw_shop()
		"trophies": draw_trophies()
		"records": draw_records()
		"pause": draw_overlay("TAKE A BREATHER","The mountains can wait.",[["resume","RESUME"],["retry","RESTART STAGE"],["menu","MAIN MENU"]])
		"lost": draw_overlay("OH, SNOW!","LEGENDARY: restart from the beginning." if legendary else "Every great adventurer takes a tumble.",[["retry","TRY AGAIN"],["menu","MAIN MENU"]])
		"clear": draw_overlay("BEACON RESTORED!","%d crystals  /  %s%s" % [coins,time_string(stage_time),"  NEW RECORD!" if new_record else ""],[["continue","NEXT STAGE"],["menu","MAIN MENU"]])
		"victory": draw_overlay("ADVENTURE COMPLETE!","%d crystals  /  %s%s" % [coins,time_string(stage_time),"  NEW RECORD!" if new_record else ""],[["again","PLAY AGAIN"],["menu","MAIN MENU"]])
	if trophy_time>0: draw_trophy_popup()

func draw_background(data: Dictionary, cam: float):
	var sky=Color(data.sky); var low=Color(data.low)
	for i in range(65):
		draw_rect(Rect2(0,i*12,W,13),sky.lerp(low,pow(float(i)/64,1.2)))
	var sunpos=Vector2(1000-cam*0.035,191)
	for i in range(8,0,-1):
		draw_circle(sunpos,65+i*10,Color(1.0,0.92,0.76,0.023 if stage!=2 else 0.035))
	draw_circle(sunpos,65,Color("#ffdf9d") if stage!=2 else Color("#c5d4ff"))
	if stage==2:
		for i in range(35):
			var sx=fposmod(i*173.73-cam*0.09,W); var y=62+fposmod(i*77,275)
			draw_circle(Vector2(sx,y),1.3+sin(i+t)*0.6,Color(0.8,0.93,1,0.6))
		for j in range(4):
			var pts=PackedVector2Array()
			for i in range(31):
				var x=i*45.0
				pts.append(Vector2(x,185+j*14+sin(i*0.20+t*0.25+j*0.5)*48+cos(i*.31)*25))
			draw_polyline(pts,Color(0.35,0.93,0.83,0.13),10+j*5,true)
	if stage>=3:
		draw_new_landscape(data,cam)
		return
	for layer in range(2):
		var col=Color(data.far) if layer==0 else Color(data.near)
		var shift=cam*(0.12 if layer==0 else 0.30)
		var step=290.0 if layer==0 else 250.0
		var base=490.0 if layer==0 else 580.0
		for i in range(-2,8):
			var x=i*step-fposmod(shift,step)
			var height=170+sin((i+floor(shift/step))*2.3)*60+(80 if layer==0 else 0)
			var peak=Vector2(x+step*0.54,base-height)
			draw_colored_polygon(PackedVector2Array([Vector2(x-75,base),peak,Vector2(x+step+75,base),Vector2(x+step+75,H),Vector2(x-75,H)]),col)
			draw_colored_polygon(PackedVector2Array([peak,Vector2(x+step+75,base),Vector2(x+step*0.7,base),Vector2(x+step*0.48,peak.y+height*.42)]),col.darkened(.15))
			if stage==0 and layer==0:
				draw_colored_polygon(PackedVector2Array([peak,peak+Vector2(-47,75),peak+Vector2(-12,57),peak+Vector2(10,85),peak+Vector2(48,77)]),Color("#e4f8f6"))
	for i in range(25):
		var x=fposmod(i*97.3-cam*0.5+sin(t*.5+i)*9,W)
		var y=fposmod(i*53.8+t*(9+i%4*5),H)
		var col=Color(1,1,1,0.23) if stage==0 else Color(1,0.81,0.66,0.19)
		draw_circle(Vector2(x,y),1.5+i%3,col)

func draw_new_landscape(data: Dictionary,cam: float):
	if stage==3:
		for layer in range(2):
			var shift=cam*(.14+layer*.18)
			var step=155.0 if layer==0 else 226.0
			var color=Color(data.far if layer==0 else data.near)
			for i in range(-2,11):
				var x=i*step-fposmod(shift,step)
				var seed=i+floor(shift/step)
				var top=165+sin(seed*3.1)*65+layer*45
				draw_rect(Rect2(x+38,top+80,30+layer*8,720-top),color.darkened(.24))
				for k in range(3):
					var q=Vector2(x+53,top+k*65)
					draw_colored_polygon(PackedVector2Array([q,q+Vector2(-80,145),q+Vector2(80,145)]),color.lightened(.04*k))
		for i in range(36):
			var q=Vector2(fposmod(i*99.2+t*16-cam*.35,W),fposmod(i*60.2+t*(25+i%4),H))
			draw_circle(q,2.5,Color(.74,1,.55,.48))
	elif stage==4:
		for i in range(-2,8):
			var x=i*340-fposmod(cam*.19,340)
			var peak=Vector2(x+170,190+sin(i+floor(cam*.19/340))*60)
			draw_colored_polygon(PackedVector2Array([Vector2(x-100,H),peak+Vector2(-30,0),peak+Vector2(30,0),Vector2(x+450,H)]),Color(data.far).darkened(.11))
			draw_colored_polygon(PackedVector2Array([peak+Vector2(-30,0),peak+Vector2(30,0),peak+Vector2(13,100),peak+Vector2(74,230),peak+Vector2(55,300),peak+Vector2(-8,220),peak+Vector2(-20,85)]),Color("#ef7850"))
			for k in range(3):
				draw_circle(peak+Vector2(sin(t*.6+i)*22,-45-k*40),35+k*14,Color(.23,.13,.21,.20))
		for i in range(48):
			var q=Vector2(fposmod(i*53.6-cam*.25+t*9,W),H-fposmod(i*39.4+t*(34+i%5*7),H))
			draw_circle(q,2.3,Color(1,.64,.29,.62))
		draw_rect(Rect2(0,680,W,40),Color("#a4453f"))
		for i in range(12):
			draw_line(Vector2(i*130+sin(t*2+i)*12,690),Vector2(i*130+70+sin(t*2+i)*12,690),Color("#ffbd75"),4,true)
	elif stage==5:
		draw_rect(Rect2(0,0,W,135),Color(data.near))
		for i in range(-2,16):
			var x=i*105-fposmod(cam*.18,105)
			var h=120+sin(i*4.6+floor(cam*.18/105))*66
			draw_colored_polygon(PackedVector2Array([Vector2(x-45,0),Vector2(x+50,0),Vector2(x+12,h)]),Color(data.near))
			var q=Vector2(x,575)
			draw_colored_polygon(PackedVector2Array([q+Vector2(-38,0),q+Vector2(-9,-95-h*.25),q+Vector2(22,-58),q+Vector2(44,0)]),Color(data.far))
			if i%3==0:
				var crystal=q+Vector2(-9,-100-h*.25)
				draw_circle(crystal,30,Color(.39,.85,1,.10))
				draw_colored_polygon(PackedVector2Array([crystal+Vector2(0,-24),crystal+Vector2(14,-7),crystal+Vector2(12,21),crystal+Vector2(-10,12),crystal+Vector2(-16,-6)]),Color("#5d98ba"))
		for i in range(35):
			var x=fposmod(i*139.4-cam*.12,W)
			var y=fposmod(i*57.7+t*18,600)
			draw_circle(Vector2(x,y),2,Color(.49,.9,1,.36))
	else:
		for layer in range(2):
			var shift=cam*(.12+layer*.15)
			var color=Color(data.far if layer==0 else data.near)
			var step=155.0 if layer==0 else 190.0
			for i in range(-2,11):
				var x=i*step-fposmod(shift,step)
				var seed=i+floor(shift/step)
				var top=220+sin(seed*1.7)*120+layer*55
				draw_rect(Rect2(x,top,step-17,H-top),color)
				draw_rect(Rect2(x+17,top-23,step-50,24),color)
				for row in range(5):
					for col in range(3):
						var q=Vector2(x+18+col*(step-40)/3,top+30+row*48)
						draw_rect(Rect2(q,Vector2(19,28)),Color("#e8a86f") if int(seed+row*3+col)%7==0 else color.darkened(.2))
		for i in range(45):
			var x=fposmod(i*97.1-cam*.2+t*60,W); var y=fposmod(i*57.9+t*305,H)
			draw_line(Vector2(x,y),Vector2(x-5,y-18),Color(.72,.81,.94,.19),1,true)

func draw_set(data: Dictionary,cam: float):
	var soil=Color(data.soil); var edge=Color(data.edge)
	for rect in solids:
		var r=Rect2(rect.position-Vector2(cam,0),rect.size)
		if r.end.x<0 or r.position.x>W: continue
		var hidden = rect.size.y==22 and rect.position.y<=365
		var opacity=0.28 if hidden and not secret_revealed and p.y>rect.position.y+90 else 1.0
		draw_rect(r,Color(soil,opacity))
		draw_rect(Rect2(r.position+Vector2(0,12),Vector2(r.size.x,6)),Color(soil.darkened(0.2),opacity))
		draw_rect(Rect2(r.position,Vector2(r.size.x,9)),Color(edge,opacity))
		draw_rect(Rect2(r.position+Vector2(0,9),Vector2(r.size.x,4)),Color(edge.darkened(0.22),opacity))
		draw_rect(Rect2(r.position+Vector2(0,14),Vector2(4,maxf(0,r.size.y-14))),soil.lightened(0.12))
		for i in range(0,int(r.size.x),45):
			var q=r.position+Vector2(i+8,24+(i%3)*10)
			if q.x<r.end.x-12 and q.y<r.end.y-4:
				draw_line(q,q+Vector2(19,0),soil.lightened(0.11),2)
				if r.size.y>50: draw_line(q+Vector2(12,31),q+Vector2(31,31),soil.darkened(.18),2)
		if r.size.y>50:
			for i in range(0,int(r.size.x)-40,95):
				var q=r.position+Vector2(i+30,0)
				if stage==0:
					draw_colored_polygon(PackedVector2Array([q+Vector2(-10,0),q+Vector2(0,-22),q+Vector2(10,0)]),edge.darkened(.17))
				elif stage==1:
					draw_line(q,q+Vector2(-3,-17),edge.darkened(.35),3)
					draw_line(q+Vector2(-3,-12),q+Vector2(10,-19),edge.darkened(.35),3)
				elif stage==3:
					draw_line(q,q+Vector2(-6,-16),edge.darkened(.24),3,true)
					draw_circle(q+Vector2(-8,-16),5,edge.darkened(.10))
					draw_circle(q+Vector2(5,-11),5,edge.darkened(.22))
				elif stage==4:
					draw_line(q+Vector2(-7,0),q+Vector2(5,-7),edge.darkened(.2),3,true)
					draw_line(q+Vector2(5,-7),q+Vector2(10,0),edge.darkened(.2),3,true)
				elif stage==6:
					draw_rect(Rect2(q+Vector2(-3,-13),Vector2(7,13)),edge.darkened(.25))
				else:
					draw_colored_polygon(PackedVector2Array([q+Vector2(-7,0),q+Vector2(4,-25),q+Vector2(12,-9),q+Vector2(10,0)]),edge.darkened(.2))
	# mist under the bottom edge
	draw_rect(Rect2(0,705,W,15),Color(0.04,0.07,0.12,0.4))

func draw_gem(q: Vector2,size: float):
	draw_circle(q,size*2.5,Color(1.0,0.74,0.30,0.11))
	draw_colored_polygon(PackedVector2Array([q+Vector2(0,-size*1.3),q+Vector2(size,0),q+Vector2(0,size*1.3),q+Vector2(-size,0)]),GOLD)
	draw_colored_polygon(PackedVector2Array([q+Vector2(0,-size*1.3),q+Vector2(0,size*1.3),q+Vector2(-size,0)]),Color("#fff0af"))
	draw_circle(q+Vector2(-2,-3),2,WHITE)

func draw_penguin(q: Vector2,dir: float,scale_factor: float,running: bool):
	var step=sin(t*16)*4 if running else 0.0
	var squish=player_squash if scale_factor==1.0 else 0.0
	var lean=0.0
	if scale_factor==1.0:
		if dash_timer>0: lean=dir*.20
		elif not grounded: lean=dir*clampf(v.y/2400.0,-.2,.2)
	draw_set_transform(q,lean,Vector2(dir*scale_factor*(1+squish*.60),scale_factor*(1-squish)))
	paint_ellipse(Vector2(0,1),Vector2(20,4),Color(0.04,0.09,0.14,0.24))
	paint_ellipse(Vector2(-9+step,-2),Vector2(10,5),GOLD)
	paint_ellipse(Vector2(9-step,-2),Vector2(10,5),Color("#ffb75d"))
	paint_ellipse(Vector2(0,-23),Vector2(19,24),INK)
	paint_ellipse(Vector2(2,-19),Vector2(12,17),WHITE)
	paint_ellipse(Vector2(-14,-24),Vector2(6,12),Color("#2b4657"))
	paint_ellipse(Vector2(1,-40),Vector2(16,13),INK)
	paint_ellipse(Vector2(7,-39),Vector2(10,10),WHITE)
	draw_circle(Vector2(10,-42),3.2,INK)
	draw_circle(Vector2(11,-43),1,WHITE)
	draw_colored_polygon(PackedVector2Array([Vector2(15,-39),Vector2(25,-34),Vector2(15,-31)]),Color("#ffb755"))
	var scarf=scarf_color()
	draw_line(Vector2(-13,-31),Vector2(14,-30),scarf,7,true)
	draw_line(Vector2(-12,-30),Vector2(-24,-28+sin(t*8)*3),scarf,6,true)
	draw_line(Vector2(-24,-28+sin(t*8)*3),Vector2(-29,-24+sin(t*8)*4),scarf.darkened(.22),5,true)
	if scale_factor==1.0 and dash_timer>0:
		for i in range(3): draw_line(Vector2(-30-i*6,-12-i*7),Vector2(-49-i*7,-12-i*7),Color(CYAN,.65-i*.15),2,true)
	draw_set_transform(Vector2.ZERO)

func paint_ellipse(q: Vector2, radii: Vector2, col: Color):
	var pts=PackedVector2Array()
	for i in range(32):
		var a=TAU*i/32.0
		pts.append(q+Vector2(cos(a)*radii.x,sin(a)*radii.y))
	draw_colored_polygon(pts,col)

func draw_mob(q: Vector2,dir: float,boss: bool):
	var s=2.15 if boss else 1.0
	draw_set_transform(q,0,Vector2(s*dir,s))
	var color=Color(BOSS_COLORS[stage])
	if boss and boss_hit>0 and int(t*16)%2==0: color=WHITE
	paint_ellipse(Vector2(0,0),Vector2(24,5),Color(0.04,0.09,0.14,0.3))
	paint_ellipse(Vector2(0,-16),Vector2(22,17),color.darkened(.22))
	paint_ellipse(Vector2(0,-19),Vector2(21,17),color)
	for i in range(3):
		var xx=-15+i*13
		draw_colored_polygon(PackedVector2Array([Vector2(xx-6,-30),Vector2(xx,-43-(3 if boss else 0)),Vector2(xx+6,-30)]),color.lightened(.26))
	paint_ellipse(Vector2(6,-19),Vector2(10,7),INK)
	draw_circle(Vector2(10,-20),3.6,GOLD)
	draw_circle(Vector2(11,-21),1.3,WHITE)
	paint_ellipse(Vector2(-11,-2),Vector2(9,4),color.darkened(.36))
	paint_ellipse(Vector2(11,-2),Vector2(9,4),color.darkened(.36))
	if boss:
		match stage:
			3:
				draw_line(Vector2(-14,-36),Vector2(-23,-54),Color("#a3cf82"),5,true)
				draw_line(Vector2(14,-36),Vector2(23,-54),Color("#a3cf82"),5,true)
				draw_circle(Vector2(-12,-28),5,Color("#b5f0a1"))
			4:
				draw_circle(Vector2(0,-20),8,Color("#ffce71"))
				draw_line(Vector2(-16,-8),Vector2(16,-8),Color("#ffb15c"),3,true)
			5:
				draw_colored_polygon(PackedVector2Array([Vector2(-17,-13),Vector2(0,-37),Vector2(17,-13),Vector2(0,-3)]),Color("#91eaff"))
			6:
				draw_rect(Rect2(-19,-29,38,21),Color("#4b4c69"))
				draw_rect(Rect2(-10,-24,23,7),Color("#ff786a"))
				draw_line(Vector2(0,-35),Vector2(0,-54),Color("#c8c9d8"),3)
				draw_circle(Vector2(0,-54),4,Color("#ff786a"))
	draw_set_transform(Vector2.ZERO)
	if boss:
		var core=Color("#78f1a6") if boss_vulnerable() else Color("#ff957c")
		draw_circle(q+Vector2(0,-60),9,Color(core,.28))
		draw_circle(q+Vector2(0,-60),5,core)
		for i in range(boss_max_hp):
			draw_circle(q+Vector2((i-(boss_max_hp-1)/2.0)*20,-115),7,Color("#ff8e8b") if i<boss_hp else INK)

func draw_beacon(q: Vector2,active: bool,goal: bool):
	var col=CYAN if active else Color("#708397")
	draw_rect(Rect2(q+Vector2(-19,-9),Vector2(38,9)),INK)
	draw_rect(Rect2(q+Vector2(-5,-94),Vector2(10,86)),Color("#a5b9bf"))
	draw_rect(Rect2(q+Vector2(-12,-86),Vector2(24,9)),INK)
	draw_circle(q+Vector2(0,-103),34,Color(col,0.09))
	draw_circle(q+Vector2(0,-103),17,Color(col,0.22))
	draw_gem(q+Vector2(0,-103),12 if goal else 8)
	if active:
		draw_circle(q+Vector2(0,-103),23+sin(t*3)*4,Color(col,0.55),false,2,true)
	label(q+Vector2(-42,-125),"EXIT" if goal else "CHECKPOINT",13,col)

func label(q: Vector2,s: String,size: int,col: Color=WHITE):
	draw_string(font,q,s,HORIZONTAL_ALIGNMENT_LEFT,-1,size,col)

func center(q: Vector2,s: String,size: int,col: Color=WHITE):
	var width=font.get_string_size(s,HORIZONTAL_ALIGNMENT_LEFT,-1,size).x
	label(q-Vector2(width/2,0),s,size,col)

func panel(r: Rect2,color: Color,border: Color=Color("#395168"),radius: int=17):
	var style=StyleBoxFlat.new()
	style.bg_color=color
	style.border_color=border
	style.set_border_width_all(1)
	style.set_corner_radius_all(radius)
	draw_style_box(style,r)

func draw_hud(data: Dictionary):
	panel(Rect2(24,22,280,75),Color(INK,.94))
	label(Vector2(43,48),"LEGENDARY" if legendary else "VITALITY",12,Color("#ff9690") if legendary else Color("#9db9cb"))
	for i in range(1 if legendary else 3):
		var q=Vector2(61+i*41,72)
		var color=Color("#ff827c") if i<hp else Color("#34465a")
		draw_circle(q+Vector2(-5,-4),7,color); draw_circle(q+Vector2(5,-4),7,color)
		draw_colored_polygon(PackedVector2Array([q+Vector2(-12,-2),q+Vector2(12,-2),q+Vector2(0,11)]),color)
	draw_gem(Vector2(206,65),8); label(Vector2(222,71),"%02d"%coins,23,GOLD)
	panel(Rect2(445,22,390,75),Color(INK,.94))
	center(Vector2(640,48),"STAGE %02d   /   %s"%[stage+1,data.name],16)
	draw_rect(Rect2(468,65,344,6),Color("#354654"))
	draw_rect(Rect2(468,65,344*clampf(p.x/float(data.length),0,1),6),CYAN)
	draw_circle(Vector2(468+344*clampf(p.x/float(data.length),0,1),68),5,WHITE)
	panel(Rect2(1001,22,254,75),Color(INK,.94))
	label(Vector2(1021,48),"DASH  /  SHIFT",12,Color("#9db9cb"))
	draw_rect(Rect2(1021,64,213,7),Color("#354654"))
	draw_rect(Rect2(1021,64,213*clampf(1.0-dash_cd/dash_duration,0,1),7),CYAN)
	label(Vector2(1030,123),time_string(stage_time),20,WHITE)
	if boss_hp>0 and p.x>float(data.length)-1030:
		panel(Rect2(405,169,470,54),Color(INK,.94),Color("#9c666c"),13)
		center(Vector2(640,190),BOSS_NAMES[stage],15,Color("#ffc29b"))
		draw_rect(Rect2(425,200,430,7),Color("#455166"))
		draw_rect(Rect2(425,200,430*float(boss_hp)/boss_max_hp,7),Color("#ff897c"))
		center(Vector2(640,244),"CORE EXPOSED  /  STOMP!" if boss_vulnerable() else "SHIELDED  /  DODGE",14,Color("#78f1a6") if boss_vulnerable() else Color("#ffad85"))
	if message_time>0:
		panel(Rect2(350,110,580,42),Color(INK,.88),Color("#597b8c"),12)
		center(Vector2(640,137),message,17,CYAN)
	label(Vector2(24,695),"A / D MOVE     SPACE JUMP     SHIFT DASH     ESC PAUSE",14,WHITE)

func btn(id: String,caption: String,r: Rect2,primary: bool=false):
	var selected=focus_index==buttons.size() or r.has_point(get_global_mouse_position())
	var fill=Color("#82e8e2") if primary else Color("#24374b")
	if selected: fill=fill.lightened(.13)
	panel(r,fill,WHITE if selected else Color("#496171"),12)
	center(Vector2(r.get_center().x,r.position.y+r.size.y/2+7),caption,19,INK if primary else WHITE)
	buttons.append({"id":id,"rect":r})

func draw_menu():
	draw_rect(Rect2(0,0,W,H),Color(0.025,0.055,0.095,0.34))
	panel(Rect2(61,37,748,646),Color("#132437"),Color("#486179"),25)
	label(Vector2(103,80),"AZIZ STUDIO   /   THE EXPLORER UPDATE",14,CYAN)
	label(Vector2(100,158),"AZIZ",71,WHITE)
	label(Vector2(100,214),"ADVENTURES",57,GOLD)
	label(Vector2(103,252),"A little penguin. A big adventure.",20,Color("#c0d6e7"))
	draw_line(Vector2(103,271),Vector2(768,271),Color("#385166"),2)
	label(Vector2(103,294),"SELECT STAGE   /   %d OF %d UNLOCKED"%[unlocked+1,STAGES.size()],13,CYAN)
	panel(Rect2(103,307,665,68),Color("#1d3449"),Color("#496171"),12)
	center(Vector2(435,333),"%02d   %s"%[menu_stage+1,STAGES[menu_stage].name],22)
	center(Vector2(435,357),"BEST "+time_string(best_time(menu_stage,legendary)),14,Color("#a6c5d3"))
	btn("play","START ADVENTURE  >",Rect2(103,387,665,59),true)
	if menu_stage>0: btn("prev","< PREVIOUS",Rect2(103,455,200,42))
	if menu_stage<unlocked: btn("next","NEXT >",Rect2(313,455,200,42))
	btn("difficulty","LEGENDARY" if legendary else "NORMAL",Rect2(523,455,245,42))
	btn("shop","SHOP",Rect2(103,509,209,49))
	btn("trophies","TROPHIES  %d/%d"%[trophies.size(),TROPHIES.size()],Rect2(322,509,235,49))
	btn("records","RECORDS",Rect2(567,509,201,49))
	btn("mute","SFX: "+("OFF" if muted else "ON"),Rect2(103,571,320,45))
	btn("quit","QUIT",Rect2(435,571,333,45))
	label(Vector2(103,649),"LEGENDARY: one heart, no upgrades." if legendary else "NORMAL: three hearts, checkpoints and upgrades.",16,Color("#a8c6d6"))
	center(Vector2(1025,111),"THE PENGUIN CHRONICLES",14,WHITE)
	panel(Rect2(887,131,286,54),Color(INK,.94))
	draw_gem(Vector2(921,157),11)
	label(Vector2(943,165),"%d CRYSTALS"%wallet,20,GOLD)
	center(Vector2(1025,592),"READY FOR TAKEOFF?",19,WHITE)
	center(Vector2(1025,618),"Jump • Dash • Explore",15,Color("#d3e6ed"))
	center(Vector2(640,705),"KEYBOARD / GAMEPAD   •   F11 FULLSCREEN   •   OFFLINE   •   NO MUSIC",13,WHITE)

func draw_screen(title: String,sub: String):
	draw_rect(Rect2(0,0,W,H),Color(.025,.055,.095,.86))
	panel(Rect2(126,34,1028,652),Color("#142639"),Color("#527487"),24)
	label(Vector2(163,79),title,33,GOLD)
	label(Vector2(165,111),sub,16,Color("#a5c8d5"))

func draw_shop():
	draw_screen("PENGUIN OUTFITTER","Crystals are banked when you clear a stage. Upgrades are Normal-only.")
	draw_gem(Vector2(962,74),12); label(Vector2(984,82),str(wallet),25,GOLD)
	for i in range(SHOP.size()):
		var item=SHOP[i]
		var y=131+i*89
		panel(Rect2(161,y,958,78),Color("#1e354b"),Color("#3c586d"),12)
		draw_circle(Vector2(202,y+39),25,Color(item[4],.15))
		draw_circle(Vector2(202,y+39),13,item[4])
		label(Vector2(243,y+28),item[2],19,WHITE)
		label(Vector2(243,y+53),item[3],15,Color("#b2c9d7"))
		var caption="%d CRYSTALS"%item[1]
		if item[0] in owned:
			caption=("EQUIPPED" if equipped_scarf==item[0] else "EQUIP") if item[0].begins_with("scarf") else "OWNED"
		elif wallet<item[1]: caption="NEED %d"%item[1]
		btn("buy:"+item[0],caption,Rect2(876,y+14,224,50),item[0] not in owned and wallet>=item[1])
	btn("back","< BACK",Rect2(161,608,265,49))
	btn("default_scarf","ORIGINAL SCARF",Rect2(789,608,330,49))

func rank_color(rank: String) -> Color:
	match rank:
		"BRONZE": return Color("#d8a178")
		"SILVER": return Color("#cadceb")
		"GOLD": return GOLD
		_: return Color("#81e6fa")

func draw_trophy(q: Vector2,rank: String,earned: bool,scale_factor: float=1.0):
	var c=rank_color(rank) if earned else Color("#526477")
	draw_set_transform(q,0,Vector2(scale_factor,scale_factor))
	draw_circle(Vector2.ZERO,27,Color(c,.12))
	draw_rect(Rect2(-11,-9,22,19),c)
	draw_circle(Vector2(-11,-3),8,c,false,3,true); draw_circle(Vector2(11,-3),8,c,false,3,true)
	draw_rect(Rect2(-3,9,6,12),c)
	draw_rect(Rect2(-12,18,24,4),c)
	draw_circle(Vector2(0,-1),4,Color(WHITE,.45))
	draw_set_transform(Vector2.ZERO)

func draw_trophies():
	draw_screen("TROPHY CABINET","%d of %d unlocked  •  Earn every other trophy for Platinum."%[trophies.size(),TROPHIES.size()])
	var start=trophy_page*8
	for i in range(8):
		var item=TROPHIES[start+i]
		var y=132+i*58
		var earned=item[0] in trophies
		panel(Rect2(161,y,958,52),Color("#243c51") if earned else Color("#1a2b3d"),Color("#577185") if earned else Color("#35495c"),9)
		draw_trophy(Vector2(200,y+24),item[1],earned,.78)
		label(Vector2(240,y+22),item[2],18,WHITE if earned else Color("#aeb9c7"))
		label(Vector2(240,y+42),item[3],13,Color("#9bb4c2"))
		label(Vector2(899,y+31),item[1]+"  "+("OK" if earned else "LOCKED"),14,rank_color(item[1]) if earned else Color("#8295a6"))
	btn("back","< BACK",Rect2(161,613,220,44))
	if trophy_page>0: btn("trophy_prev","< PREVIOUS",Rect2(392,613,225,44))
	if trophy_page<1: btn("trophy_next","NEXT >",Rect2(894,613,225,44))
	center(Vector2(745,642),"%d / 2"%(trophy_page+1),16,WHITE)

func draw_records():
	draw_screen("SPEEDRUN RECORDS","Personal bests for each difficulty. Paused time is excluded.")
	label(Vector2(650,145),"NORMAL",15,CYAN)
	label(Vector2(905,145),"LEGENDARY",15,Color("#ff9a92"))
	for i in range(STAGES.size()):
		var y=159+i*62
		panel(Rect2(161,y,958,53),Color("#1e354b"),Color("#3c586d"),10)
		label(Vector2(184,y+33),"%02d  %s"%[i+1,STAGES[i].name],17,WHITE)
		label(Vector2(650,y+33),time_string(best_time(i,false)),21,CYAN)
		label(Vector2(905,y+33),time_string(best_time(i,true)),21,Color("#ff9e95"))
	btn("back","< BACK",Rect2(161,612,260,45))

func draw_trophy_popup():
	var item=trophy_data(trophy_current)
	if item.is_empty(): return
	var slide=clampf(minf(4.0-trophy_time,trophy_time)*5,0,1)
	var y=15-105*(1-slide)
	var q=Vector2(853,y)
	var c=rank_color(item[1])
	panel(Rect2(q,Vector2(409,97)),Color("#142638"),c,15)
	draw_trophy(q+Vector2(48,51),item[1],true,1.08)
	label(q+Vector2(88,27),"TROPHY UNLOCKED / "+item[1],12,c)
	label(q+Vector2(88,56),item[2],22,WHITE)
	label(q+Vector2(88,79),"Aziz Adventures",13,Color("#a7c0d0"))
func draw_overlay(title: String, subtitle: String, actions: Array):
	draw_rect(Rect2(0,0,W,H),Color(0.025,0.055,0.095,0.76))
	var height=240+actions.size()*65
	var top=(H-height)/2
	panel(Rect2(340,top,600,height),Color("#16283b"),Color("#7194a6"),24)
	center(Vector2(640,top+44),"AZIZ ADVENTURES",14,CYAN)
	center(Vector2(640,top+103),title,37,GOLD)
	center(Vector2(640,top+145),subtitle,17,WHITE)
	for i in range(actions.size()):
		btn(actions[i][0],actions[i][1],Rect2(398,top+183+i*65,484,52),i==0)
	center(Vector2(640,top+height-17),"ENTER SELECT    /    ESC BACK",13,Color("#9db9cb"))

func test_gaps():
	var count=0
	for idx in range(STAGES.size()):
		var ground=STAGES[idx].ground
		for i in range(ground.size()-1):
			build_stage(idx); mode="play"
			for mob in mobs: mob.alive=false
			boss_hp=0
			var edge=float(ground[i][0]+ground[i][1])
			var target=float(ground[i+1][0])+30
			p=Vector2(edge-45,FLOOR); v=Vector2(SPEED,0); grounded=true
			tick(1.0/60,1,true,false)
			for frame in range(58):
				tick(1.0/60,1,true,false)
				if p.x>=target and p.y<=FLOOR: break
			assert(p.x>=target and p.y<=FLOOR and hp==3,"gap reachable: "+str(idx)+"/"+str(i))
			count+=1
	print("PASS: ",count," terrain gaps reachable.")

func self_test():
	test_gaps()
	legendary=false; build_stage(0); mode="play"
	for i in range(30): tick(1.0/60,1,false,false)
	assert(p.x>160,"movement")
	var old_y=p.y
	tick(1.0/60,0,true,false)
	for i in range(15): tick(1.0/60,0,true,false)
	assert(p.y<old_y-100,"jump")
	var dx=p.x
	tick(1.0/60,1,true,true)
	for i in range(8): tick(1.0/60,1,true,true)
	assert(p.x>dx+65,"dash")
	# Verify all secret paths physically: jump from ledge to ledge.
	for idx in range(STAGES.size()):
		build_stage(idx); mode="play"
		for mob in mobs: mob.alive=false
		p=Vector2(secret_route[0].get_center().x,FLOOR); v=Vector2.ZERO; grounded=true
		# First ledge by vertical jump, next two by steering.
		for rect in secret_route:
			var target=Vector2(rect.get_center().x,rect.position.y)
			last_jump=false
			tick(1.0/60,0,true,false)
			for f in range(65):
				var direction=clampf((target.x-p.x)*.075,-1.0,1.0)
				tick(1.0/60,direction,true,false)
				if grounded and absf(p.y-target.y)<1: break
			assert(grounded and absf(p.y-target.y)<1,"secret ledge "+str(idx)+" "+str(target)+" got "+str(p))
		assert(secret_revealed,"secret revealed")
	# Verify every stage's boss and exit; clear records and currency.
	for idx in range(STAGES.size()):
		build_stage(idx); mode="play"; p=gems[0].pos+Vector2(0,23)
		tick(1.0/60,0,false,false); assert(coins==1,"gem collection "+str(idx))
		p=Vector2(float(STAGES[idx].checkpoint)+20,FLOOR); tick(1.0/60,0,false,false)
		assert(checkpoint,"checkpoint")
		p.y=780; tick(1.0/60,0,false,false)
		assert(hp==2 and p.y<600,"fall recovery")
		p=Vector2(mobs[0].x,FLOOR-33); v.y=300; invul=0
		tick(1.0/60,0,false,false); assert(not mobs[0].alive,"stomp")
		if boss_hp>0:
			for i in range(boss_max_hp):
				p=Vector2(boss_x,boss_y-77); v=Vector2(0,300); boss_hit=0; boss_age=-1.0; boss_phase=0
				tick(1.0/60,0,false,false)
			assert(boss_hp==0,"boss "+str(idx))
		var previous_wallet=wallet
		p=Vector2(float(STAGES[idx].length)-100,FLOOR); v=Vector2.ZERO
		tick(1.0/60,0,false,false)
		assert(mode==("victory" if idx==STAGES.size()-1 else "clear"),"exit")
		assert(wallet>previous_wallet and best_time(idx,false)>0,"reward and record")
	assert(completed.size()==7 and bosses_defeated.size()==5 and "all_stages" in trophies and "all_bosses" in trophies and "all_secrets" in trophies,"progress")
	# Confirm that the five boss patterns launch different hazards and shield timing.
	for idx in range(2,7):
		build_stage(idx); mode="play"
		p=Vector2(float(STAGES[idx].length)-900,FLOOR); v=Vector2.ZERO
		boss_phase=3.0; boss_age=0
		update_boss(1.0/60,p)
		assert(sparks.size()==1,"boss launches projectile "+str(idx))
		assert(sparks[0].kind==["aurora","leaf","fire","crystal","signal"][idx-2],"distinct projectile")
	build_stage(4); mode="play"; boss_phase=1.1
	var health_before=boss_hp
	p=Vector2(boss_x,boss_y-77); v=Vector2(0,300)
	tick(1.0/60,0,false,false)
	assert(boss_hp==health_before and v.y<0,"shielded stomp bounces")
	# Shop purchase, toggle cosmetic, avoid duplicate purchase, air jump and difficulty.
	wallet=400
	shop_action("scarf_blue"); assert(wallet==365 and equipped_scarf=="scarf_blue","shop")
	shop_action("scarf_blue"); assert(wallet==365 and equipped_scarf=="default","equip toggle")
	shop_action("dash_upgrade"); shop_action("double_jump")
	assert(wallet==155 and "double_jump" in owned and "dash_upgrade" in owned,"upgrade purchase")
	build_stage(0); mode="play"; assert(dash_duration<.95,"normal dash upgrade")
	p=Vector2(150,450); v=Vector2(0,100); grounded=false; coyote=0; last_jump=false
	tick(1.0/60,0,true,false); assert(air_jump_used and v.y<0,"double jump")
	legendary=true; build_stage(0); mode="play"
	assert(hp==1 and dash_duration==.95,"legendary one heart no upgrades")
	p=Vector2(150,450); v=Vector2(0,100); grounded=false; coyote=0; last_jump=false
	tick(1.0/60,0,true,false); assert(not air_jump_used,"legendary air jump disabled")
	p.y=780; tick(1.0/60,0,false,false)
	assert(mode=="lost","legendary death restarts")
	for idx in range(STAGES.size()):
		build_stage(idx); mode="play"; boss_hp=0; stage_time=12; coins=1
		p=Vector2(float(STAGES[idx].length)-100,FLOOR); v=Vector2.ZERO
		tick(1.0/60,0,false,false)
		assert(best_time(idx,true)>0 and best_time(idx,false)>0,"separate best")
	assert("legend" in trophies,"legendary trophy")
	for item in TROPHIES:
		if item[0]!="platinum": earn(item[0])
	assert(trophies.size()==TROPHIES.size() and "platinum" in trophies,"platinum")
	# Verify protected save migration and full round-trip without touching the real save.
	var old_save=save_path
	save_path="user://aziz_selftest_"+str(Time.get_ticks_usec())+".cfg"
	testing=false
	var cfg=ConfigFile.new()
	cfg.set_value("game","unlocked",2)
	cfg.set_value("settings","muted",true)
	assert(cfg.save(save_path)==OK,"legacy save created")
	load_save()
	assert(unlocked==2 and muted and wallet==0 and trophies.is_empty(),"legacy migration")
	wallet=177; lifetime_gems=350; equipped_scarf="scarf_gold"; owned=["scarf_gold"]; trophies=["first_gem"]
	completed=[0,1]; legend_completed=[0]; secrets_found=[2]; bosses_defeated=[2]
	best_normal={"0":10.5}; best_legendary={"0":21.0}; legendary=true; unlocked=4
	save_game()
	wallet=0; owned=[]; trophies=[]; best_normal={}; best_legendary={}; unlocked=0; legendary=false
	load_save()
	assert(wallet==177 and unlocked==4 and legendary and owned==["scarf_gold"] and trophies==["first_gem"] and best_time(0,false)==10.5 and best_time(0,true)==21.0 and equipped_scarf=="scarf_gold","persistence round trip")
	DirAccess.remove_absolute(ProjectSettings.globalize_path(save_path))
	testing=true; save_path=old_save
	# Exercise every rendering path without needing a graphics display.
	for idx in range(STAGES.size()):
		build_stage(idx)
		for m in ["menu","shop","trophies","records","play","pause","lost","clear","victory"]:
			mode=m; queue_redraw(); await get_tree().process_frame
	print("SELF TEST PASSED: 7 stages, 5 bosses, secret routes, shop, upgrades, difficulty, rewards, records and platinum.")
	get_tree().quit(0)
