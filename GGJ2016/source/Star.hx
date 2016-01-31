package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.graphics.frames.FlxFrame.FlxFrameType;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import openfl.display.BitmapData;
using BitmapUtils;

class Star extends FlxSprite
{

	private var hue:Float = 0;
	private var colorChangeSpeed:Float = 1;
	
	public function new(Size:Int=1) 
	{
		super();
		switch(Size)
		{
			case 1:
				loadGraphic(AssetPaths.star_50__png, false, 50, 50);
			case 2:
				loadGraphic(AssetPaths.star_100__png, false, 100, 100);
		}
		
	}
	
	public function spawn():Void
	{
		
		var newX:Float = 0;
		var newY:Float = 0;
		if (FlxG.random.bool())
		{
			newX = FlxG.random.float(0, FlxG.width);
			newY = FlxG.height;
		}
		else
		{
			newX = FlxG.width;
			newY = FlxG.random.float(0, FlxG.height);
			
		}
		hue = FlxG.random.float(0, 1);
		colorChangeSpeed = FlxG.random.float(1,5) * .5;
		reset(newX, newY);
		
		var a:Float = FlxG.random.float( -165, -105);
		velocity.set(FlxG.random.int(1, 5) * 200, 0);
		
		velocity.rotate(FlxPoint.weak(), a);
		angularVelocity = FlxG.random.float( 1, 4) * 60 * FlxG.random.sign();
		
		useFramePixels = true;
	}

	override public function draw():Void 
	{
		
		super.draw();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (x < -width || y < -height)
		{
			kill();
		}
		
		hue+= elapsed*colorChangeSpeed;
		if (hue > 1)
			hue--;
		
		dirty = true;
		
		super.update(elapsed);
	}
	
	override public function getFlxFrameBitmapData():BitmapData
	{
		
		super.getFlxFrameBitmapData();
		
		var c:FlxColor = FlxColor.fromHSL(Std.int(hue * 360), 1, .5);
		framePixels = framePixels.colorBitmap(c.to24Bit());
		
		return framePixels;
	}
}