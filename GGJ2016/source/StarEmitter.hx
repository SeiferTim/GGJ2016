package;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class StarEmitter extends FlxTypedGroup<Star>
{

	public function new() 
	{
		super();
		var s:Star;
		for (i in 0...50)
		{
			s = new Star(1);
			add(s);
			s.spawn();
			s.x = FlxG.random.float(0, FlxG.width);
			s.y = FlxG.random.float(0, FlxG.height);
			s = new Star(2);
			add(s);
			s.spawn();
			s.x = FlxG.random.float(0, FlxG.width);
			s.y = FlxG.random.float(0, FlxG.height);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		forEachDead(respawnStar);
		super.update(elapsed);
	}
	
	private function respawnStar(S:Star):Void
	{
		S.spawn();
	}
	
}