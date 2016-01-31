package;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFrame;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.graphics.frames.FlxFrame.FlxFrameType;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.addons.util.FlxFSM;
import flixel.util.FlxDestroyUtil;
import openfl.display.BitmapData;
using BitmapUtils;

class Imp extends GameObject
{

	
	public static inline var GRAVITY:Float = 1600;
	private var fsm:FlxFSM<Imp>;
	
	private var hue:Float = 0;
	public var faceFrames:FlxSprite;
	
	
	public function new()
	{
		
		super();
		
		objType = Reg.OBJ_IMP;
		loadGraphic(AssetPaths.Full_Grey__png , true, 32, 32);
		animation.add("standing", [0, 1, 2], 6, false);
		animation.add("jumping", [0, 1, 2], 6, false);
		animation.add("walking", [3,4,5,6,7], 6, false);
		animation.play("standing", true);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip ( FlxObject.RIGHT, false, false);
		width = 28;
		height = 28;
		offset.x = 2;
		offset.y = 4;
			
		
		faceFrames = new FlxSprite();
		faceFrames.loadGraphic(AssetPaths.Full_Color__png, true, 32, 32);
		//faceFrames.animation.add("standing", [0, 1, 2], 12, false);
		//faceFrames.animation.add("jumping", [0, 1, 2], 12, false);
		//faceFrames.animation.add("walking", [3, 4, 5, 6, 7], 12, false);
		//faceFrames.animation.play("standing", true);
		
		faceFrames.setFacingFlip(FlxObject.LEFT, true, false);
		faceFrames.setFacingFlip ( FlxObject.RIGHT, false, false);
		
		acceleration.y = GRAVITY;
		maxVelocity.set(400, GRAVITY);
		
		fsm = new FlxFSM<Imp>(this);
		fsm.transitions
			.add(Idle, Jump, Conditions.jump)
			.add(Jump, Idle, Conditions.grounded)
			.start(Idle);
	}
	
	override public function draw():Void 
	{
		if (!useFramePixels)
			useFramePixels = true;
		dirty = true;
		super.draw();
	}
	
	override public function getFlxFrameBitmapData():BitmapData
	{
		
		var doFlipX:Bool = checkFlipX();
		var doFlipY:Bool = checkFlipY();
		
		if (!doFlipX && !doFlipY && _frame.type == FlxFrameType.REGULAR)
		{
			framePixels = _frame.paint(framePixels, _flashPointZero, false, true);
		}
		else
		{
			framePixels = _frame.paintRotatedAndFlipped(framePixels, _flashPointZero,
				FlxFrameAngle.ANGLE_0, doFlipX, doFlipY, false, true);
		}
		
		if (useColorTransform)
		{
			framePixels.colorTransform(_flashRect, colorTransform);
		}
		
		if (FlxG.renderTile && useFramePixels)
		{
			//recreate _frame for native target, so it will use modified framePixels
			_frameGraphic = FlxDestroyUtil.destroy(_frameGraphic);
			_frameGraphic = FlxGraphic.fromBitmapData(framePixels, false, null, false);
			_frame = _frameGraphic.imageFrame.frame.copyTo(_frame);
		}
		
		
		var c:FlxColor = FlxColor.fromHSB(Std.int(hue * 360), 1, 1);
		framePixels = framePixels.colorBitmap(c.to24Bit());
		
		
		if (faceFrames != null)
		{
			faceFrames.animation.frameIndex  = animation.frameIndex;
			faceFrames.drawFrame(true);
			framePixels.copyPixels(faceFrames.framePixels, faceFrames.framePixels.rect, new Point(), faceFrames.framePixels, new Point(), true);
		}
			
		
		
		
		dirty = false;
		return framePixels;
	}
	
	
	override public function update(elapsed:Float):Void 
	{
		hue+= elapsed;
		if (hue > 1)
			hue--;
		
		dirty = true;
		fsm.update(elapsed);
		super.update(elapsed);
	}
	
	override public function destroy():Void 
	{
		fsm.destroy();
		fsm = null;
		faceFrames.destroy();
		faceFrames = null;
		super.destroy();
	}
	
}

class Conditions
{
	public static function jump(Owner:Imp):Bool
	{
		return (Reg.checkKeyPress(Reg.KEYS_JUMP) && Owner.isTouching(FlxObject.DOWN));
	}
	
	public static function grounded(Owner:Imp):Bool
	{
		return Owner.isTouching(FlxObject.DOWN);
	}
	
}


class Idle extends FlxFSMState<Imp>
{
	override public function enter(owner:Imp, fsm:FlxFSM<Imp>):Void 
	{
		owner.animation.play("standing");
		//owner.faceFrames.animation.play("standing");
		
	}
	
	override public function update(elapsed:Float, owner:Imp, fsm:FlxFSM<Imp>):Void 
	{
		owner.acceleration.x = 0;
		var left:Bool = Reg.checkKeyPress(Reg.KEYS_LEFT);
		var right:Bool = Reg.checkKeyPress(Reg.KEYS_RIGHT);
		if (left != right)
		{
			owner.faceFrames.facing = owner.facing = left ? FlxObject.LEFT : FlxObject.RIGHT;
			owner.animation.play("walking");
			//owner.faceFrames.animation.play("walking");
			if ((owner.velocity.x > 0 && left) || (owner.velocity.x < 0 && right))
			{
				owner.velocity.x = 0;
			}
			owner.acceleration.x = left ? -300 : 300;
		}
		else
		{
			if (Math.abs(owner.velocity.x) >= 0.05)
			{
				owner.animation.play("walking");
				//owner.faceFrames.animation.play("walking");
				owner.velocity.x *= 0.66;
			}
			else
			{
				owner.velocity.x = 0;
				owner.animation.play("standing");
				//owner.faceFrames.animation.play("standing");
			}
			
		}
	}
}


class Jump extends FlxFSMState<Imp>
{
	private var impJump:FlxSound;
	
	
	override public function enter(owner:Imp, fsm:FlxFSM<Imp>):Void 
	{
		impJump = FlxG.sound.load(AssetPaths.ViolinSlideUPM__wav);
		impJump.play();
		owner.animation.play("jumping");
		//owner.faceFrames.animation.play("jumping");
		owner.velocity.y = -600;
		
	}
	
	override public function update(elapsed:Float, owner:Imp, fsm:FlxFSM<Imp>):Void 
	{
		owner.acceleration.x = 0;
		var left:Bool = Reg.checkKeyPress(Reg.KEYS_LEFT);
		var right:Bool = Reg.checkKeyPress(Reg.KEYS_RIGHT);
		if (left != right)
		{
			owner.faceFrames.facing = owner.facing = left ? FlxObject.LEFT : FlxObject.RIGHT;
			owner.acceleration.x = left ? -300 : 300;
			
			if ((owner.acceleration.x > 0 && left) || (owner.acceleration.x < 0 && right))
			{
				owner.velocity.x = 0;
			}
		}
		else
		{
			owner.velocity.x *= 0.66;
		}
	}
}
