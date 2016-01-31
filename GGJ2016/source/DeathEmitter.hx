package;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxColor;

class DeathEmitter extends FlxEmitter
{

	public function new() 
	{
		super();
		launchMode = FlxEmitterMode.CIRCLE;
		particleClass = RainbowParticles;
		lifespan.set(.33,1);
		acceleration.set(0, 300);
		angle.set(0, 360);
		speed.set(6, 400);
		angularVelocity.set( -200, 200);
		alpha.set(.66, 1, 0, 0);
		
		
		for (i in 0...60)
		{
			add(new RainbowParticles());
		}
	}
	
	public function spawn(X:Float, Y:Float)
	{
		x = X;
		y = Y;
		start(true);
	}
	
	
}