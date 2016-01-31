package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.graphics.frames.FlxFrame.FlxFrameType;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import openfl.display.BitmapData;
using BitmapUtils;

class Spell extends FlxSprite
{
	private var hue:Float = 0;
	public function new()
	{
		super();
		loadGraphic(AssetPaths.Spell_Sparkles__png, true, 32, 32);
		animation.add("sparkles", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 12, true);
		animation.play("sparkles");
		useFramePixels = true;
	}
	
	override public function getFlxFrameBitmapData():BitmapData
	{
		
		super.getFlxFrameBitmapData();
		
		var c:FlxColor = FlxColor.fromHSL(Std.int(hue * 360), 1, .5);
		framePixels = framePixels.colorBitmap(c.to24Bit());
		
		return framePixels;
	}
	
	
	override public function update(elapsed:Float):Void 
	{
		hue+= elapsed;
		if (hue > 1)
			hue--;
		
		dirty = true;
		
		super.update(elapsed);
	}
	
}