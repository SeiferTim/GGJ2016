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
	
	public static inline var MUS_MENU:Int = 0;
	public static inline var MUS_PLAY:Int = 1;
	
	public static var cur_music:Int = -1;
	
	public static function playMusic(newSong:Int):Void {
		
		if (newSong != cur_music) {
			
			switch (newSong) {
				case MUS_MENU:
					#if flash
					FlxG.sound.playMusic(AssetPaths.GameJam3Louder__mp3, 1, true);
					#else
					FlxG.sound.playMusic(AssetPaths.GameJam3Louder__ogg, 1, true);
					#end
				case MUS_PLAY:
					#if flash
					FlxG.sound.playMusic(AssetPaths.GameJam1LOUDER__mp3, 1, true);
					#else
					FlxG.sound.playMusic(AssetPaths.GameJam1LOUDER__ogg, 1, true);
					#end
			}
			
			cur_music = newSong;
		}
		
	}
	
	public static var gamepad:FlxGamepad = null;
	
	
	static public var DEFAULT_KEYS_JUMP:FlxKey = X;
	static public var DEFAULT_KEYS_UP:FlxKey = UP;
	static public var DEFAULT_KEYS_DOWN:FlxKey = DOWN;
	static public var DEFAULT_KEYS_LEFT:FlxKey = LEFT;
	static public var DEFAULT_KEYS_RIGHT:FlxKey = RIGHT;
	
	static public var DEFAULT_BTNS_JUMP:FlxGamepadInputID = A;
	static public var DEFAULT_BTNS_UP:FlxGamepadInputID = DPAD_UP;
	static public var DEFAULT_BTNS_DOWN:FlxGamepadInputID = DPAD_DOWN;
	static public var DEFAULT_BTNS_LEFT:FlxGamepadInputID = DPAD_LEFT;
	static public var DEFAULT_BTNS_RIGHT:FlxGamepadInputID = DPAD_RIGHT;
	
	
	static public var KEY_JUMP:Int = 0;
	static public var KEY_SHOOT:Int = 1;
	static public var KEY_PAUSE:Int =2;
	static public var KEY_VOL_UP:Int = 3;
	static public var KEY_VOL_DOWN:Int = 4;
	static public var KEY_VOL_MUTE:Int = 5;
	static public var KEY_UP:Int = 6;
	static public var KEY_DOWN:Int = 7;
	static public var KEY_LEFT:Int = 8;
	static public var KEY_RIGHT:Int = 9;
	
	static public var KEY_BINDS:Array<FlxKey>;
	static public var BTN_BINDS:Array<FlxGamepadInputID>;
	
	static public var keyDelay:Float = 0;
	
	static public inline var KEY_DELAY_BIG:Float = 0.5;
	static public inline var KEY_DELAY_SMALL:Float = 0.05;
	
	static public function initKeys():Void
	{
		KEY_BINDS = [];
		BTN_BINDS = [];
		
		KEY_BINDS[KEY_UP] = DEFAULT_KEYS_UP;
		KEY_BINDS[KEY_DOWN] = DEFAULT_KEYS_DOWN;
		KEY_BINDS[KEY_LEFT] = DEFAULT_KEYS_LEFT;
		KEY_BINDS[KEY_RIGHT] = DEFAULT_KEYS_RIGHT;
		KEY_BINDS[KEY_JUMP] = DEFAULT_KEYS_JUMP;
		
		#if !FLX_NO_GAMEPAD
		BTN_BINDS[KEY_UP] = DEFAULT_BTNS_UP;
		BTN_BINDS[KEY_DOWN] = DEFAULT_BTNS_DOWN;
		BTN_BINDS[KEY_LEFT] = DEFAULT_BTNS_LEFT;
		BTN_BINDS[KEY_RIGHT] = DEFAULT_BTNS_RIGHT;
		BTN_BINDS[KEY_JUMP] = DEFAULT_BTNS_JUMP;
		#end
		
		
	}
	
	static public function toggleFullscreen():Void
	{
		FlxG.fullscreen = !FlxG.fullscreen;
	}
}