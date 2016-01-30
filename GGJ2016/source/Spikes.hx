package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Spikes extends GameObject
{
	
	public function new() 
	{
		super();
		objType = Reg.OBJ_SPIKES;
		loadGraphic(AssetPaths.Spike__png, true, 32, 32);
		moves = false;
		immovable = true;
		
	}
	
	override function set_triggered(Value:Bool):Bool 
	{
		if (triggered == Value)
			return triggered;
		
		super.set_triggered(Value);
		
		if (triggered)
		{
			y += 32;
		}
		else
		{
			y -= 32;
		}
		
		return triggered;
	}
	
}