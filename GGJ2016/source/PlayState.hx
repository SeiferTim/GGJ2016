package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup.FlxTypedGroupIterator;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTileblock;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxArrayUtil;
import haxe.ds.IntMap;
import haxe.Json;
import lime.project.Platform;
import openfl.Assets;
using StringTools;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var walls:FlxTypedGroup<FlxTilemap>;
	private var entities:FlxTypedGroup<GameObject>;
	private var platforms:FlxTypedGroup<MovingPlatform>;
	private var wiz:Wiz;
	private var p:Imp;
	private var s:Spell;
	private var objMap:IntMap<GameObject>;
	private var doorMap:IntMap<Door>;
	private var doors:Array<Door> = [];
	private var castTimer:Float = 0;
	private var spawn:FlxPoint;
	private var death:DeathEmitter;
	private var monster:Monster;
	
	private var impSpawn:FlxSound;
	private var impDie:FlxSound;
	private var wizCast:FlxSound;
	private var doorNoise:FlxSound;
	private var monNoise:FlxSound;
	
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		Reg.playMusic(0);
		impSpawn = FlxG.sound.load(AssetPaths.GiggleFX__wav);
		impDie = FlxG.sound.load(AssetPaths.StarsDescending__wav);
		wizCast = FlxG.sound.load(AssetPaths.CrystalBlast__wav);
		doorNoise = FlxG.sound.load(AssetPaths.DoorSlam__wav);
		monNoise = FlxG.sound.load(AssetPaths.cccreeepy__wav);
		
		spawn = FlxPoint.get();
		add(new FlxSprite(0, 0, AssetPaths.background2__png));
		walls  = new FlxTypedGroup<FlxTilemap>();
		entities = new FlxTypedGroup<GameObject>();
		platforms = new FlxTypedGroup<MovingPlatform>();
		objMap = new IntMap<GameObject>();
		doorMap = new IntMap<Door>();
		
		var d:Door = new Door(350-16, 32+16, 0);
		doorMap.set(0, d);
		doors.push(d);
		add(d);
		d = new Door(640 - 16, 32+16, 1);
		doorMap.set(1, d);
		doors.push(d);
		add(d);
		d = new Door(950-16, 32+16, 2);
		doorMap.set(2, d);
		doors.push(d);
		add(d);
		
		var top:FlxTileblock = new FlxTileblock(0,-16, FlxG.width, 64);
		top.loadTiles(AssetPaths.test_tile__png, 32, 32, 0);
		add(top);
		
		wiz = new Wiz();
		wiz.x = 32;
		wiz.y = 112 - 32;
		add(wiz);
		
		s = new Spell();
		s.alpha = 0;
		add(s);
		
		var j:{ layers:Array<Dynamic> } = Json.parse(Assets.getText(AssetPaths.blank_map__json));
		for (n in j.layers)
		{
			if (n.name == "walls")
			{
				var t:FlxTilemap = new FlxTilemap();
				var a:Array<Int> = n.data;
				for (i in 0...a.length)
				{
					a[i]--;
				}
				
				t.loadMapFromArray(a, 40, 19, AssetPaths.test_tile__png , 32, 32, null, 0, 0, 0);
				t.y += 112;
				walls.add(t);
			}
			else if (n.name == "objects")
			{
				for (o in cast(n.objects, Array<Dynamic>))
				{
					var properties:{ triggers:String, size:String, xdist:String, ydist:String, xspeed:String, yspeed:String } = o.properties;
					var trig:Int = -1;
					if (properties.triggers != null)
						trig = Std.parseInt(properties.triggers);
					
					if (o.type == "spawn")
					{
						spawn.x = o.x;
						spawn.y = o.y+80;
					}
					else if (o.type == "platform")
					{
						var size:Int = 0;
						var xdist:Int = 0;
						var ydist:Int = 0;
						var xspeed:Int = 0;
						var yspeed:Int = 0;
						if (properties.size != null)
							size = Std.parseInt(properties.size);
						if (properties.xdist != null)
							xdist = Std.parseInt(properties.xdist);
						if (properties.ydist != null)
							ydist = Std.parseInt(properties.ydist);
						if (properties.xspeed != null)
							xspeed = Std.parseInt(properties.xspeed);
						if (properties.yspeed != null)
							yspeed = Std.parseInt(properties.yspeed);
						var p:MovingPlatform = new MovingPlatform(o.x, o.y+80, size, xdist, ydist, xspeed, yspeed);
						p.objid = o.id;
						platforms.add(p);
						
					}
					else
					{
						var ob:GameObject = createEntity(o.type, o.id, trig); // , size, xdist, ydist, xspeed, yspeed);
						if (ob != null)	
						{
							ob.angle = o.rotation;
							ob.x = o.x;
							ob.y = o.y+80;
							objMap.set(o.id, ob);
							entities.add(ob);
						}
					}
					
				}
			}
		}
		
		p = new Imp();
		p.x = 32 * 2;
		p.y = 122 + (32 * 2);
		p.kill();
		entities.add(p);
		
		add(platforms);
		add(walls);
		
		var r:RainbowTrail = new RainbowTrail(p, RainbowTrail.STYLE_RAINBOW);
		add(r);
		add(entities);
		
		
		monster = new Monster();
		monster.x = -200;
		monster.y = 112 - 60;
		add(monster);
		
		death = new DeathEmitter();
		add(death);
		super.create();
	}
	
	public function createEntity(ObjType:String, Id:Int, Triggers:Int=-1, ?Size:Int = 0, ?XDist:Int =0, ?YDist:Int =0, ?XSpeed:Int =0, ?YSpeed:Int = 0):GameObject
	{
		var o:GameObject;
		switch (ObjType)
		{
			case "sigil":
				o = cast new Sigil(Triggers);
			case "spikes":
				o = cast new Spikes();
			case "button":
				o = cast new Button();
			default:
				return null;
		}
		o.objid = Id;
		o.triggers = Triggers;
		return o;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		if (monster.x + (monster.width / 2) >= wiz.x)
		{
			monNoise.play();
			openSubState(new GameOverSubState());
		}
		else
		{
			if (p.alive)
			{
				if (wiz.casting)
				{
					if (s.alpha > 0)
						s.alpha -= elapsed * 5;
					else
						wiz.casting = false;
					
				}
				else if ((doors[0].alive && wiz.x + wiz.width >= doors[0].x) || (doors[1].alive && wiz.x + wiz.width >= doors[1].x) || (doors[2].alive && wiz.x + wiz.width >= doors[2].x))
				{
					
					wiz.velocity.x = 0;
					wiz.animation.play("idle");
				}
				else
				{
					wiz.velocity.x = 60;
					wiz.animation.play("walking");
				}
				
				
				
			}
			else 
			{
				if (wiz.casting)
				{
					wizCast.play();
					s.x = wiz.x;
					s.y = wiz.y;
					if (s.alpha < 1)
						s.alpha += elapsed * 5;
					castTimer -= elapsed;
					if (castTimer <= 0) {
						p.reset(spawn.x, spawn.y);
						impSpawn.play();	
					}
				}
				else 
				{
					wiz.velocity.x = 0;
					wiz.casting = true;
					wiz.animation.play("cast");
					castTimer = 1;
				}
			}
			FlxG.collide(walls, entities);
			FlxG.overlap(platforms, entities, null, checkPlatformCollision);
			FlxG.overlap(entities, entities, overlappedEntities, checkOverlappedEntities);
		}
		super.update(elapsed);
	}
	
	public function playerHitsSpikes():Void
	{
		impDie.play();
		p.kill();
		death.spawn(p.x + (p.width/2), p.y + (p.height/2));
	}
	
	public function overlappedEntities(ObjA:GameObject, ObjB:GameObject):Void
	{
		switch (ObjA.objType)
		{
			case Reg.OBJ_IMP:
				switch (ObjB.objType)
				{
					case Reg.OBJ_SPIKES:
						playerHitsSpikes();
					case Reg.OBJ_BUTTON:
						cast(ObjB, Button).pressed = true;
					case Reg.OBJ_SIGIL:
						cast(ObjB, Sigil).collected = true;
						
				}
			case Reg.OBJ_SPIKES:
				switch (ObjB.objType)
				{
					case Reg.OBJ_IMP:
						playerHitsSpikes();
				}
			case Reg.OBJ_BUTTON:
				switch (ObjB.objType)
				{
					case Reg.OBJ_IMP:
						cast(ObjA, Button).pressed = true;
				}
			case Reg.OBJ_SIGIL:
				switch (ObjB.objType)
				{
					case Reg.OBJ_IMP:
						cast(ObjA, Sigil).collected = true;
				}
		}
	}
	
	private function checkPlatformCollision(Plat:MovingPlatform, Obj:GameObject):Bool
	{
		if (Obj.alive && Obj.exists && Plat.alive && Plat.exists)
		{
			if (Obj.objType == Reg.OBJ_IMP)
				return FlxObject.separate(Plat, Obj);
		}
		return false;
	}
	
	public function checkOverlappedEntities(ObjA:GameObject, ObjB:GameObject):Bool
	{
		if (ObjA.alive && ObjA.exists && ObjB.alive && ObjB.exists)
		{
			return true;
		}
		return false;
	}
	
	public function triggerObj(ObjID:Int):Void
	{
		var o:GameObject = objMap.get(ObjID);
		if (o != null)
		{
			o.triggered = true;
		}
	}
	
	public function untriggerObj(ObjID:Int):Void
	{
		var o:GameObject = objMap.get(ObjID);
		if (o != null)
		{
			o.triggered = false;
		}
	}
	
	public function openDoor(ObjID:Int):Void
	{
		var o:Door = doorMap.get(ObjID);
		if (o != null)
		{
			doorNoise.play();
			o.open();
		}
	}
}