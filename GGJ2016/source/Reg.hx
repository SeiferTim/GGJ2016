package;

import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;
import flixel.input.gamepad.FlxGamepadInputID;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	
	public static inline var OBJ_IMP:Int = -1;
	public static inline var OBJ_SPIKES:Int = 0;
	public static inline var OBJ_BUTTON:Int = 1;
	public static inline var OBJ_SIGIL:Int = 2;
	
	
	public static var gamepad:FlxGamepad = null;
	
	public static inline var KEYS_LEFT:Int = 0; // :Array<FlxKey> = [A, LEFT];
	public static inline var KEYS_RIGHT:Int = 1; // Array<FlxKey> = [D, RIGHT];
	public static inline var KEYS_JUMP:Int = 2; // Array<FlxKey> = [W, UP, X];
	
	public static function checkKeyPress(checkKeys:Int):Bool
	{
		
		
		if (gamepad == null)
			gamepad = FlxG.gamepads.getFirstActiveGamepad();
		
		if (gamepad != null)
		{
			
			switch(checkKeys)
			{
				case KEYS_LEFT:
					if (gamepad.anyPressed([DPAD_LEFT]) || gamepad.getXAxis(FlxGamepadInputID.LEFT_ANALOG_STICK) <= -.2)
						return true;
				case KEYS_RIGHT:
					if (gamepad.anyPressed([DPAD_RIGHT]) || gamepad.getXAxis(FlxGamepadInputID.LEFT_ANALOG_STICK) >= .2)
						return true;
				case KEYS_JUMP:
					if (gamepad.anyPressed([DPAD_UP, A]) || gamepad.getYAxis(FlxGamepadInputID.LEFT_ANALOG_STICK) <= -.2)
						return true;
			}
		}
		
		
		var keys:Array<FlxKey> = switch(checkKeys)
		{
			case KEYS_LEFT:
				[A, LEFT];
			case KEYS_RIGHT:
				[D, RIGHT];
			case KEYS_JUMP:
				[X, UP, W];
			default:
				[];
		};
		return FlxG.keys.anyPressed(keys);
	}
	
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}