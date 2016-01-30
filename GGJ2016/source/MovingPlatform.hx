package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxTileblock;

class MovingPlatform extends FlxTileblock
{

	public var objid:Int = 0;
	public var xdist:Int = 0;
	public var ydist:Int = 0;
	private var startPos:FlxPoint;

	public function new(X:Int, Y:Int, Size:Int, XDist:Int, YDist:Int, XSpeed:Int, YSpeed:Int)
	{
		super(X, Y, Size * 32, 32);
		loadTiles(AssetPaths.platform__png, 32, 32, 0);
		startPos = FlxPoint.get(X, Y);
		velocity.set(XSpeed, YSpeed);
		xdist = XDist * 32;
		ydist = YDist * 32;
		moves = true;
		active = true;
		allowCollisions = FlxObject.UP;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if ((velocity.x > 0 && x > startPos.x + xdist) || (velocity.x < 0 && x < startPos.x))
		{
			velocity.x *= -1;
			
		}
		
		if ((velocity.y > 0 && y > startPos.y + ydist) || (velocity.y < 0 && y < startPos.y))
		{
			velocity.y *= -1;
			
		}
		super.update(elapsed);
	}
	
	
	
}