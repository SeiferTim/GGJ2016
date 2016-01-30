package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup.FlxTypedGroupIterator;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxArrayUtil;
import haxe.ds.IntMap;
import haxe.Json;
import openfl.Assets;
using StringTools;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var walls:FlxTypedGroup<FlxTilemap>;
	private var entities:FlxTypedGroup<GameObject>;
	private var wiz:Wiz;
	private var p:Imp;
	private var s:Spell;
	private var objMap:IntMap<GameObject>;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{	
		
		walls  = new FlxTypedGroup<FlxTilemap>();
		entities = new FlxTypedGroup<GameObject>();
		objMap = new IntMap<GameObject>();
		
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
				t.loadMapFromArray(n.data, 40, 19, AssetPaths.test_tile__png , 32, 32, null, 0, 0, 1);
				t.y += 112;
				walls.add(t);
			}
			else if (n.name == "objects")
			{
				for (o in cast(n.objects, Array<Dynamic>))
				{
					var properties:{ triggers:String } = o.properties;
					var trig:Int = -1;
					if (properties.triggers != null)
						trig = Std.parseInt(properties.triggers);
					var ob:GameObject = createEntity(o.type, o.id, trig);
					ob.x = o.x;
					ob.y = o.y+80;
					objMap.set(o.id, ob);
					entities.add(ob);
				}
			}
		}
		
		p = new Imp();
		p.x = 32 * 2;
		p.y = 122 + (32 * 2);
		entities.add(p);
		
		/*
		
		
		
		
		
		
		
		
		var regex:EReg = new EReg("[ \t]*((\r\n)|\r|\n)[ \t]*", "g");
		var lines:Array<String> = regex.split(Assets.getText(AssetPaths.blank_map_objects__csv));
		var rows:Array<String> = lines.filter(function(line) return line != "");
		var row:Int = 0;
		var columns:Array<String>;
		while (row < t.heightInTiles)
		{
			var rowString = rows[row];
			if (rowString.endsWith(","))
				rowString = rowString.substr(0, rowString.length - 1);
			columns = rowString.split(",");
			
			var column = 0;
			while (column < t.widthInTiles)
			{
				var columnString = columns[column];
				
				var curTile = Std.parseInt(columnString);
				if (curTile > -1)
				{
					var e:GameObject = createEntity(curTile);
					if (e!=null)
					{
						entities.add(e);
						e.x = column * 32;
						e.y = t.y + (row * 32);
					}
				}
				column++;
			}
			
			row++;
		}
		
		
		
		
		
		*/
		
		add(walls);
		
		var r:RainbowTrail = new RainbowTrail(p, RainbowTrail.STYLE_RAINBOW);
		add(r);
		add(entities);
		super.create();
	}
	
	public function createEntity(ObjType:String, Id:Int, Triggers:Int=-1):GameObject
	{
		var o:GameObject;
		switch (ObjType)
		{
			case "spikes":
				o = cast new Spikes();
				
			case "button":
				
				o = cast new Button();
			default:
				return null;
		}
		o.id = Id;
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
		if (wiz.casting)
		{
			s.x = wiz.x;
			s.y = wiz.y;
			if (s.alpha < 1)
				s.alpha += elapsed*5;
		}
		else if (s.alpha > 0)
			s.alpha -= elapsed* 5;
		
		FlxG.collide(walls, entities);
		FlxG.overlap(entities, entities, overlappedEntities, checkOverlappedEntities);
		super.update(elapsed);
	}
	
	public function playerHitsSpikes():Void
	{
		p.kill();
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
		}
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
}