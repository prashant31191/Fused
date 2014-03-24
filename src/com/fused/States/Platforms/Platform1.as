package com.fused.States.Platforms 
{
	import com.fused.Setup.Config;
	import com.fused.Helpers.CustomTimer;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.fused.States.Particles.ParticleHolder;
	import flash.geom.Point;
	import com.fused.Helpers.Utils;

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Platform1 extends PlatformBase
	{
		protected static const MAX_BRICK:Number  = 5;
		protected static const VELOCITY:Number   = -1;
		protected static const X_AXIS:String  	 = 'X_AXIS';

        protected var customTimer:CustomTimer;
        protected var targetClip:MovieClip;
        protected var savedTarget:MovieClip;
        protected var alphaClip:TweenLite;
        protected var savedPos:Point;
        protected var particleHolder:ParticleHolder;

		protected var platforms:Array = [ 'Platform1Type1', 
										  'Platform1Type2', 
										  'Platform1Type3',
										  'Platform1Type4'
		];

		public function Platform1() 
		{
			Platform1Type1;
			Platform1Type2;
			Platform1Type3;
			Platform1Type4;

		// 	customTimer = new CustomTimer(0.1);

			super(new PlatformType1(), {amount: MAX_BRICK, axis: X_AXIS, brick: platforms});
			// super(new PlatformType1(), {amount:MAX_BRICK, axis: X_AXIS});
		}

		// override public function breakPlatform(target:MovieClip):void 
		// {
		// 	super.breakPlatform(target);
		// 	this.targetClip = target;
		// 	particleHolder = new ParticleHolder(targetClip.parent as MovieClip);
  //           customTimer.addEventListener(Event.COMPLETE, onComplete);
		// 	customTimer.start();
		// }

		// override public function get velocity():Number 
		// {
		// 	return VELOCITY;
		// }

		// override public function get platformTypeName():Array 
		// {
		// 	return platforms;
		// }

		// protected function onComplete(e:Event):void 
		// {
		// 	alphaClip = new TweenLite(targetClip, 0.3, {alpha:0, visible:false, onComplete:removeTarget});
		// 	savedPos = new Point(targetClip.x, targetClip.y);
		// 	createParticleEffects();
		// }

		// protected function removeTarget():void 
		// {
		// 	if (targetClip != savedTarget) {
		// 		// targetClip.parent.removeChild(targetClip);
		// 		savedTarget = targetClip;
		// 	}
		// }

		// protected function createParticleEffects():void 
		// {
		// 	var particle:Platform1Particle = new Platform1Particle();
		// 	var randomFrame:Number = Utils.getRandomInt(1, 4);
		// 	particle.gotoAndStop(1);
		// 	var scaleRandomNbr:int = Math.random() * (1 - 0.5) + 0.5

		// 	particleHolder.create(particle, 1000, 10, {
		// 			x: savedPos.x,
		// 			y: savedPos.y,
		// 			scaleX: scaleRandomNbr,
		// 			scaleY: scaleRandomNbr,
		// 			alpha: Math.random() * (1 - 0.5) + 0.5
		// 		}, {
		// 			x: Math.random() * (1 - (-1)) + -1, 
		// 			y: Math.random() * (1 - (-1)) + -1
		// 		}
		// 	);
		// }
	}
}
