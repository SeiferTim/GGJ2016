package;

import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.graphics.frames.FlxFrame.FlxFrameType;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import openfl.display.BitmapData;
using BitmapUtils;

class RainbowParticles extends FlxParticle
{

	private var hue:Float = 0;
	var animations:Array<String> = [];
	public function new() 
	{
		super();
		loadGraphic(AssetPaths.sparkles__png, true, 32, 32);
	}
	
	override public function onEmit():Void 
	{
		super.onEmit();
		animation.randomFrame();
		hue = FlxG.random.float(0, 1);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (!isOnScreen(FlxG.camera))
		{
			alive = exists = false;
		}
		hue+= elapsed;
		if (hue > 1)
			hue--;
		color = FlxColor.fromHSL(hue * 360, 1, .5);
		
		super.update(elapsed);
	}
	/*
	override public function getFlxFrameBitmapData():BitmapData
	{
		
		var doFlipX:Bool = checkFlipX();
		var doFlipY:Bool = checkFlipY();
		
		if (!doFlipX && !doFlipY && _frame.type == FlxFrameType.REGULAR)
		{
			framePixels = _frame.paint(framePixels, _flashPointZero, false, true);
		}
		else
		{
			framePixels = _frame.paintRotatedAndFlipped(framePixels, _flashPointZero,
				FlxFrameAngle.ANGLE_0, doFlipX, doFlipY, false, true);
		}
		
		if (useColorTransform)
		{
			framePixels.colorTransform(_flashRect, colorTransform);
		}
		
		if (FlxG.renderTile && useFramePixels)
		{
			//recreate _frame for native target, so it will use modified framePixels
			_frameGraphic = FlxDestroyUtil.destroy(_frameGraphic);
			_frameGraphic = FlxGraphic.fromBitmapData(framePixels, false, null, false);
			_frame = _frameGraphic.imageFrame.frame.copyTo(_frame);
		}
		
		
		var c:FlxColor = FlxColor.fromHSB(Std.int(hue * 360), 1, 1);
		framePixels = framePixels.colorBitmap(c.to24Bit());
		
		dirty = false;
		return framePixels;
	}
	*/
	
}