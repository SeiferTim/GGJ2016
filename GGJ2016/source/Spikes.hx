package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;

class Spikes extends GameObject
{
	private var spikesMove:FlxSound;
	
	public function new() 
	{
		super();
		objType = Reg.OBJ_SPIKES;
		loadGraphic(AssetPaths.Spike__png, true, 32, 32);
		
		spikesMove = FlxG.sound.load(AssetPaths.SpikesM__wav);
		
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
			spikesMove.play();
			y += 32;
		}
		else
		{
			spikesMove.play();
			y -= 32;
		}
		
		return triggered;
	}
	
}