package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import openfl.display.BitmapData;
import openfl.geom.Point;
using BitmapUtils;

class FingerSprite extends FlxSprite
{
	private var hue:Float = 0;
	private var topFrame:FlxSprite;
	
	public function new() 
	{
		super();
		loadGraphic(AssetPaths.finger_base__png, false, 48, 48);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		topFrame = new FlxSprite();
		topFrame.loadGraphic(AssetPaths.finger_frame__png, false, 48, 48);
		topFrame.setFacingFlip(FlxObject.LEFT, true, false);
		topFrame.setFacingFlip(FlxObject.RIGHT, false, false);
	}
	
	override public function updateFramePixels():BitmapData
	{
		
		super.updateFramePixels();
		
		var c:FlxColor = FlxColor.fromHSL(Std.int(hue * 360), 1, .5);
		framePixels = framePixels.colorBitmap(c.to24Bit());
		
		if (topFrame != null)
		{
			topFrame.animation.frameIndex  = animation.frameIndex;
			topFrame.calcFrame(true);
			
			framePixels.copyPixels(topFrame.framePixels, topFrame.framePixels.rect, new Point(), topFrame.framePixels, new Point(), true);
			
		}
		
		return framePixels;
	}
	
	override function set_facing(Direction:Int):Int 
	{
		super.set_facing(Direction);
		
		topFrame.facing = facing;
		
		return facing;
	}
	
	override public function update(elapsed:Float):Void 
	{
		
		hue+= elapsed;
		if (hue > 1)
			hue--;
		dirty = true;
		
		super.update(elapsed);
	}
	
	override public function destroy():Void 
	{
		topFrame = FlxDestroyUtil.destroy(topFrame);
		super.destroy();
	}
}