package;
import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;

class GameGroup<T:FlxBasic> extends FlxTypedGroup<T>
{
	public var zMembers:Array<IGameObject>;
	
	public function new(MaxSize:Int = 0)
	{
		super(MaxSize);
		
		zMembers = cast members;
	}
	
	public function updateMembers():Void
	{
		members = cast zMembers;
	}
}