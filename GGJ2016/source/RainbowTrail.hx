package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class RainbowTrail extends FlxTypedGroup<Rainbow>
{

	public static inline var STYLE_RAINBOW:Int = 0;
	public static inline var STYLE_SCARY:Int = 1;
	
	private var _target:FlxSprite;
	private var _hue:Float = 0;
	private var _timer:Float = 0;
	private var _style:Int = 0;
	
	public function new(Target:FlxSprite, Style:Int = 0 ) 
	{
		super(40);
		
		for (i in 0...40)
		{
			add(new Rainbow());
		}
		spawn(Target, Style);
	}
	
	public function spawn(Target:FlxSprite, Style:Int = 0)
	{
		
		_style = Style;
		_target = Target;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (alive)
		{
			
			_timer -= elapsed;
			if (_timer <= 0)
			{
				
				
				if (_style == STYLE_RAINBOW)
				{
					_timer = .012;
					_hue+= elapsed * 200;
					if (_hue > 360)
						_hue-= 360;
				}
				else
				{
					_timer = .06;
				}
				if (_target.alive && _target.exists)
				{
				
					var r:Rainbow = recycle(Rainbow, null, false, false);
					if (!r.alive)
					{
						var cl:FlxColor;
						switch (_style) 
						{
							case STYLE_RAINBOW:
								cl = FlxColor.fromHSB(_hue, 1, 1);
								r.decayRate = 1;
							case STYLE_SCARY:
								cl = 0xff990000;
								r.decayRate = .33;
							default:
								cl = FlxColor.WHITE;
						}
						r.spawn(Std.int(cl), _target);
						if (_style == STYLE_SCARY)
						{
							r.alpha = .5;
						}
						else
						{
							r.alpha = .33;
						}
						add(r);
					}
				}
			}
		}
		
		super.update(elapsed);
	}
	
	
	
}