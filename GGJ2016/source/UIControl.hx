package;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxInput.FlxInputState;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;
import flixel.util.FlxArrayUtil;
import flixel.util.FlxDestroyUtil;

class UIControl
{

	public static var controls:Array<FlxButton>;	
	public static var currentControl:Int = -1;
	private static var finger:FingerSprite;
	private static var keyDelay:Float = 0;
	public static var mouseless:Bool = false;
	public static var hasGamepad:Bool = false;
	private static var triggered:Float = .66;
	private static var _group:FlxSpriteGroup;
	public static var initialized:Bool = false;
	#if !FLX_NO_GAMEPAD
	public static var gamepad:FlxGamepad = null;
	public static var analogPressed:Array<Bool>;
	#end
	#if !FLX_NO_MOUSE
	private static var mousePos:FlxPoint;
	#end
	
	static public function init(Controls:Array<FlxButton>, ?substate:FlxSubState, ?Group:FlxSpriteGroup):Void
	{
		if (initialized)
			return;
		
		controls = Controls;
		
		_group = Group;
		
		if (finger == null)
		{
			finger = new FingerSprite();
			/*
			finger.loadGraphic(AssetPaths.ui_cursor__png, true, 5, 7);
			finger.animation.add("blink", [0, 1], 5, true);
			finger.animation.play("blink");
			finger.setFacingFlip(FlxObject.LEFT, true, false);
			finger.setFacingFlip(FlxObject.RIGHT, false, false);
			finger.scrollFactor.set();
			*/
		}
		finger.visible = false;
		if (_group != null)
			_group.add(finger);
		else if (substate != null)
			substate.add(finger);
		else
			FlxG.state.add(finger);
			
		#if FLX_NO_MOUSE
		mouseless = true;
		#end
		
		#if !FLX_NO_GAMEPAD
		analogPressed = [false, false, false, false];
		#end
		
		
		keyDelay = 0;
		
		currentControl = -1;
		if (mouseless && controls.length > 0)
		{
			startMouselessControls(true);
		}
		else if (!mouseless)
		{
			#if !FLX_NO_MOUSE
			FlxG.mouse.visible = true;
			#end
		}
		initialized = true;
		
		
	}
	
	static public function startMouselessControls(force:Bool = false):Void
	{
		if (mouseless && !force)
			return;
		if (controls != null)
		{
			for (c in controls)
			{
				c.locked = true;
			}
		}
		#if !FLX_NO_MOUSE
		mousePos = FlxPoint.get(FlxG.mouse.x, FlxG.mouse.y);
		#end
		mouseless = true;
		nextControl();
		#if !FLX_NO_MOUSE
		FlxG.mouse.visible = false;
		#end
		
	}
	
	static public function stopMouselessControls():Void
	{
		#if FLX_NO_MOUSE
		mouseless = true;
		#else
		if (!mouseless)
			return;
		if (controls != null)
		{
			for (c in controls)
			{
				c.locked = false;
			}
		}
		mouseless = false;
		deselectControl();
		FlxG.mouse.visible = true;
		#end
		
	}
	
	static public function deselectControl():Void
	{
		if (currentControl > -1 && currentControl < controls.length)
		{		
			var c:FlxButton = controls[currentControl];
			if (c != null)
			{
				c.status = FlxButton.NORMAL;
			}
		}
		clearControl();
		
	}
	
	static public function selectControl(ID:Int):Void
	{
		deselectControl();
		if (ID <= -1 || ID >= controls.length)
			return;
		var c:FlxButton = controls[ID];
		if (c != null)
		{
			if (c.x < 10)
			{
				// right side
				finger.facing = FlxObject.LEFT;
				finger.x = Std.int(c.x + c.width + 5);
				finger.y = Std.int(c.y + (c.height / 2) - (finger.height / 2));
				finger.visible = true;
			}
			else
			{
				// left side
				finger.facing = FlxObject.RIGHT;
				finger.x = Std.int(c.x - finger.width - 5);
				finger.y = Std.int(c.y + (c.height / 2) - (finger.height / 2));
				finger.visible = true;
			}
			c.status = FlxButton.HIGHLIGHT;
			currentControl = ID;
			finger.visible = true;
			
		}
		else
		{
			finger.visible = false;
			currentControl = -1;
		}
	}
	
	static public function unload():Void
	{
		if (!initialized)
			return;
		controls = null;
		clearControl();
		finger = FlxDestroyUtil.destroy(finger);
		initialized = false;
	}
	
	static public function clearControl():Void
	{
		currentControl = -1;
		finger.visible = false;
	}
	
	static public function nextControl():Void
	{
		var startID:Int = currentControl;
		var cNo:Int = currentControl;
		var c:FlxButton = null;
		if (controls.length == 0)
		{
			clearControl();
		}
		else
		{
			do
			{
				cNo++;
				if (cNo >= controls.length)
				{
					cNo = 0;
				}
				if (cNo >= 0)
				{
					c = controls[cNo];
				}
				
			} while (cNo != startID && !(c.visible && c.alive && c.active && c.exists));
			if (cNo >= -1 && cNo < controls.length)
			{
				selectControl(cNo);
			}
			else if (startID >= 0 && startID < controls.length)
			{
				selectControl(startID);
			}
		}
	}
	
	static public function previousControl():Void
	{
		var startID:Int = currentControl;
		var cNo:Int = currentControl;
		var c:FlxButton = null;
		if (controls.length == 0)
		{
			clearControl();
		}
		else
		{
			do
			{
				cNo--;
				if (cNo < 0)
				{
					cNo = controls.length-1;
				}
				if (cNo < controls.length)
				{
					c = controls[cNo];
				}
				
			} while (cNo != startID && !(c.visible && c.alive && c.active && c.exists));
			if (cNo >= -1 && cNo < controls.length)
			{
				selectControl(cNo);
			}
			else if (startID >= 0 && startID < controls.length)
			{
				selectControl(startID);
			}
		}
	}
	
	static private function fixButtonStates():Void
	{
		for (c in 0...controls.length)
		{
			if (controls[c] != null)
			{
				if (controls[c].status == FlxButton.PRESSED)
				{
					if (c == currentControl)
					{
						controls[c].status = FlxButton.HIGHLIGHT;
					}
					else
					{
						controls[c].status = FlxButton.NORMAL;
					}
				}
			}
		}
	}
	
	static private function scroll():Void
	{
		if (_group != null && currentControl > -1 &&  currentControl < controls.length && controls[currentControl] != null)
		{
			var c:FlxButton = controls[currentControl];
			if (c.y+c.height >= FlxG.height-12)
				_group.y -= 2;
			else if (c.y <= 12)
				_group.y += 2;
		}
	}
	
	static public function getCurrentControl():FlxButton
	{
		if (currentControl < 0 || currentControl >= controls.length || !initialized)
			return null;
		return controls[currentControl];
	}
	
	static public function checkControls(elapsed:Float):Void
	{
		if (!initialized)
			return;
			
		if (keyDelay > 0)
		{
			keyDelay -= elapsed;
		}
		
		if (triggered > 0)
		{
			triggered -= elapsed;
		}
		scroll();
		
		checkGamepad();
		#if !FLX_NO_MOUSE
		if (mouseless)
		{
			if (mousePos.x != FlxG.mouse.x || mousePos.y != FlxG.mouse.y)
			{
				stopMouselessControls();
			}
		}
		#end
		var leftJPressed:Bool = wasJustPressed([Reg.KEY_LEFT, Reg.KEY_UP]); 
		var rightJPressed:Bool = wasJustPressed([Reg.KEY_RIGHT, Reg.KEY_DOWN]); 
		var leftPressed:Bool = isPressed([Reg.KEY_LEFT, Reg.KEY_UP]); 
		var rightPressed:Bool = isPressed([Reg.KEY_RIGHT, Reg.KEY_DOWN]);
	
		if (isPressed([Reg.KEY_JUMP]))
		{
			if (!mouseless)
				startMouselessControls();
			else
				pressButton();
			return;
		}
		if (wasJustReleased([Reg.KEY_JUMP]))
		{
			if (!mouseless)
				startMouselessControls();
			else
				triggerControl();
			return;
		}
		if (controls.length > 0 && mouseless)
		{
			fixButtonStates();
			
		}
		
		if ((leftPressed || leftJPressed) && (rightPressed || rightJPressed))
		{
			startMouselessControls();
			return;
		}
		else if (leftJPressed)
		{
			if (!mouseless)
				startMouselessControls();
			else
				previousControl();
			keyDelay = Reg.KEY_DELAY_BIG;
		}
		else if (leftPressed && keyDelay<=0)
		{
			if (!mouseless)
				startMouselessControls();		
			else
				previousControl();			
			keyDelay = Reg.KEY_DELAY_SMALL;
			
		}
		else if (rightJPressed)
		{
			if (!mouseless)
				startMouselessControls();
			else
				nextControl();
			keyDelay = Reg.KEY_DELAY_BIG;
		}
		else if (rightPressed && keyDelay<=0)
		{
			if (!mouseless)
				startMouselessControls();
			else
				nextControl();
			keyDelay = Reg.KEY_DELAY_SMALL;
		}
		
		
		
	}
	
	static public function checkGamepad():Bool
	{
		#if !FLX_NO_GAMEPAD
		if (!hasGamepad)
		{
			//gamepad = FlxG.gamepads.firstActive;
			for (g in FlxG.gamepads.getActiveGamepads())
			{
				if (g != null && g.anyInput())
				{
					gamepad = g;
					hasGamepad = true;
					break;
					
				}
			}
			
		}
		else if (gamepad == null)
		{
			hasGamepad = false;
		}
		else
		{
			if (FlxG.gamepads.getByID(gamepad.id) == null)
			{
				hasGamepad = false;
				gamepad = null;
			}
		}
		
		
		
		
		#else
		gamepad = null;
		hasGamepad = false;
		#end
		
		return hasGamepad;
	}
		
	static public function isPressed(Commands:Array<Int>):Bool
	{
		var p:Bool = false;
		for (i in Commands)
		{
			p = FlxG.keys.checkStatus(Reg.KEY_BINDS[i], FlxInputState.PRESSED);
			if (p)
				break;
		}
		if (!p && hasGamepad)
		{
			
			for (i in Commands)
			{
				p = gamepad.checkStatus(Reg.BTN_BINDS[i], FlxInputState.PRESSED);
				if (p)
					break;
				switch(i)
				{
					case Reg.KEY_UP:
						if (gamepad.getYAxis(LEFT_ANALOG_STICK) <= -gamepad.deadZone)
						{
							p = true;
							analogPressed[0] = true;
						}
					case Reg.KEY_DOWN:
						if (gamepad.getYAxis(LEFT_ANALOG_STICK) >= gamepad.deadZone)
						{
							p = true;
							analogPressed[1] = true;
						}
					case Reg.KEY_LEFT:
						if (gamepad.getXAxis(LEFT_ANALOG_STICK) <= -gamepad.deadZone)
						{
							p = true;
							analogPressed[2] = true;
						}
					case Reg.KEY_RIGHT:
						if (gamepad.getXAxis(LEFT_ANALOG_STICK) >= gamepad.deadZone)
						{
							p = true;
							analogPressed[3] = true;
						}
					default:
						
				}
			}
			
		}
		return p;
	}
	
	static public function wasJustPressed(Commands:Array<Int>):Bool
	{
		var p:Bool = false;
		for (i in Commands)
		{
			p = FlxG.keys.checkStatus(Reg.KEY_BINDS[i], FlxInputState.JUST_PRESSED);
			if (p)
				break;
		}
		if (!p && hasGamepad)
		{
			
			for (i in Commands)
			{
				p = gamepad.checkStatus(Reg.BTN_BINDS[i], FlxInputState.JUST_PRESSED);
				if (p)
					break;
				switch(i)
				{
					case Reg.KEY_UP:
						if (gamepad.getYAxis(LEFT_ANALOG_STICK) <= -gamepad.deadZone)
						{
							if (!analogPressed[0])
								p = true;
							analogPressed[0] = true;
						}
					case Reg.KEY_DOWN:
						if (gamepad.getYAxis(LEFT_ANALOG_STICK) >= gamepad.deadZone)
						{
							if (!analogPressed[1])
								p = true;
							analogPressed[1] = true;
						}
					case Reg.KEY_LEFT:
						if (gamepad.getXAxis(LEFT_ANALOG_STICK) <= -gamepad.deadZone)
						{
							if (!analogPressed[2])
								p = true;
							analogPressed[2] = true;
						}
					case Reg.KEY_RIGHT:
						if (gamepad.getXAxis(LEFT_ANALOG_STICK) >= gamepad.deadZone)
						{
							if (!analogPressed[3])
								p = true;
							analogPressed[3] = true;
						}
					default:
						
				}
			}
			
		}
		return p;
	}
	
	static public function wasJustReleased(Commands:Array<Int>):Bool
	{
		var p:Bool = false;
		for (i in Commands)
		{
			p = FlxG.keys.checkStatus(Reg.KEY_BINDS[i], FlxInputState.JUST_RELEASED);
			if (p)
				break;
		}
		if (!p && hasGamepad)
		{
			
			for (i in Commands)
			{
				p = gamepad.checkStatus(Reg.BTN_BINDS[i], FlxInputState.JUST_RELEASED);
				if (p)
					break;
				switch(i)
				{
					case Reg.KEY_UP:
						if (!(gamepad.getYAxis(LEFT_ANALOG_STICK) <= -gamepad.deadZone))
						{
							if (analogPressed[0])
								p = true;
							analogPressed[0] = false;
						}
					case Reg.KEY_DOWN:
						if (!(gamepad.getYAxis(LEFT_ANALOG_STICK) >= gamepad.deadZone))
						{
							if (analogPressed[1])
								p = true;
							analogPressed[1] = false;
						}
					case Reg.KEY_LEFT:
						if (!(gamepad.getXAxis(LEFT_ANALOG_STICK) <= -gamepad.deadZone))
						{
							if (analogPressed[2])
								p = true;
							analogPressed[2] = false;
						}
					case Reg.KEY_RIGHT:
						if (!(gamepad.getXAxis(LEFT_ANALOG_STICK) >= gamepad.deadZone))
						{
							if (analogPressed[3])
								p = true;
							analogPressed[3] = false;
						}
					default:
						
				}
			}
			
		}
		return p;
	}
	
	static public function pressButton():Void
	{
		if (currentControl != -1 && triggered <= 0)
		{
			var c:FlxButton = controls[currentControl];
			if (c.status == FlxButton.HIGHLIGHT && c.visible && c.active && c.exists && c.alive)
			{
				c.status = FlxButton.PRESSED;
				c.draw();
			}
		}
	}
	
	static public function triggerControl():Void
	{
		if (currentControl != -1 && triggered <= 0)
		{
			var c:FlxButton = controls[currentControl];
			if (c.status == FlxButton.PRESSED && c.visible && c.active && c.exists && c.alive)
			{
				c.status = FlxButton.HIGHLIGHT;
				c.draw();
				c.onUp.fire();
				
				triggered = Reg.KEY_DELAY_SMALL;
			}
		}
	}

	
}