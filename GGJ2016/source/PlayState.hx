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
import openfl.Assets;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var walls:FlxTypedGroup<FlxTilemap>;
	private var entities:FlxTypedGroup<FlxSprite>;
	private var wiz:Wiz;

	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{	
		
		walls  = new FlxTypedGroup<FlxTilemap>();
		entities = new FlxTypedGroup<FlxSprite>();
		
		var t:FlxTilemap = new FlxTilemap();
		t.loadMapFromCSV(Assets.getText(AssetPaths.blank_map__csv), AssetPaths.test_tile__png, 32, 32, null, 0, 0, 1);
		t.y += 112;
		walls.add(t);
		
		var p:Imp = new Imp();
		p.x = 32 * 2;
		p.y = 122 + (32 * 2);
		
		wiz = new Wiz();
		wiz.x = 32;
		wiz.y = 112 - 32;
		add(wiz);
		
		entities.add(p);
		
		add(walls);
		
		var r:RainbowTrail = new RainbowTrail(p, RainbowTrail.STYLE_RAINBOW);
		add(r);
		add(entities);
		
		
		super.create();
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
		FlxG.collide(walls, entities);
		super.update(elapsed);
	}	
}