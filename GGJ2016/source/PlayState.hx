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
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{	
		
		walls  = new FlxTypedGroup<FlxTilemap>();
		entities = new FlxTypedGroup<GameObject>();
		
		var t:FlxTilemap = new FlxTilemap();
		t.loadMapFromCSV(Assets.getText(AssetPaths.blank_map_walls__csv), AssetPaths.test_tile__png, 32, 32, null, 0, 0, 1);
		t.y += 112;
		walls.add(t);
		
		p = new Imp();
		p.x = 32 * 2;
		p.y = 122 + (32 * 2);
		
		wiz = new Wiz();
		wiz.x = 32;
		wiz.y = 112 - 32;
		add(wiz);
		
		s = new Spell();
		s.alpha = 0;
		add(s);
		
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
		
		
		entities.add(p);
		
		add(walls);
		
		var r:RainbowTrail = new RainbowTrail(p, RainbowTrail.STYLE_RAINBOW);
		add(r);
		add(entities);
		
		
		super.create();
	}
	
	public function createEntity(EntityID:Int):GameObject
	{
		switch (EntityID)
		{
			case 0:
				return cast new Spikes();
			case 1:
				return cast new Button();
		}
		return null;
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
}