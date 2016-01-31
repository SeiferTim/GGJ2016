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
		acceleration.set(0, 600);
		angle.set(0, 360);
		speed.set(6, 600);
		angularVelocity.set( -100, 100);
		alpha.set(.66, 1, 0, 0);
		
		
		for (i in 0...100)
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