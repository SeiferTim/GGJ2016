package;

import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import openfl.display.BitmapData;

class Rainbow extends FlxParticle
{

	public var decayRate:Float = 2;
	public function new() 
	{
		super();
		immovable = true;
		moves  = false;
		kill();
	}
	
	public function spawn(Color:FlxColor, Target:FlxSprite):Void
	{
		
		if (Target != null)
		{
			var bmp:BitmapData = Target.framePixels;
			if (bmp != null)
			{
				
				if (bmp.width != 0 && bmp.height != 0)
				{				
					var c:FlxSprite = new FlxSprite().makeGraphic(Math.ceil(bmp.width), Math.ceil(bmp.height), Color);
					FlxSpriteUtil.alphaMask(this, c.pixels, bmp);
					x = Target.x - Target.offset.x;
					y = Target.y - Target.offset.y;
					angle = Target.angle;
					alpha = 1;
					visible = true;
					revive();
				}
			}
		}
		
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (alive)
		{
			alpha -= elapsed * decayRate;
			if (alpha <= 0)
				kill();
		}
		super.update(elapsed);
	}
	
}