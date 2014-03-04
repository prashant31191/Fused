package com.cyberpunk.States 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import com.cyberpunk.Setup.Config;
	import flash.external.ExternalInterface;
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class CollisionManager 
	{
		private var platforms:Array;
		
		private var leftBumping:Boolean  = false;
		private var rightBumping:Boolean = false;
		private var upBumping:Boolean    = false;
		private var downBumping:Boolean  = false;
		
		private var leftBumpPoint:Point  = new Point(-20, 0);
		private var rightBumpPoint:Point = new Point(20, 0);
		private var upBumpPoint:Point    = new Point(0, -20);
		private var downBumpPoint:Point  = new Point(0, 20);
		
		private var speed:Point;
		
		public function CollisionManager() 
		{

		}

		public function set playerSpeed(speed:Point):void 
		{
			this.speed = speed;
		}

		public function get currentSpeed():Point 
		{
			return speed;
		}

		public function set platformsArray(platforms:Array):void 
		{
			this.platforms = platforms;
		}
		
		public function update(player:MovieClip):void
		{
			leftBumping 	= false;					
			rightBumping 	= false;
			upBumping 		= false;
			downBumping 	= false;

			for (var i:int = 0; i < platforms.length; i++) {
				if (platforms[i].hitTestPoint(player.x + leftBumpPoint.x, player.y + leftBumpPoint.y, true)) {
					ExternalInterface.call('console.log', 'leftBumping');
					// leftBumping = true;
				}
				 
				if (platforms[i].hitTestPoint(player.x + rightBumpPoint.x, player.y + rightBumpPoint.y, true)) {
					ExternalInterface.call('console.log', 'rightBumping');
					// rightBumping = true;
				}
				 
				if (platforms[i].hitTestPoint(player.x + upBumpPoint.x, player.y + upBumpPoint.y, true)) {
					ExternalInterface.call('console.log', 'upBumping');
					// upBumping = true;
				} 
				 
				if (platforms[i].hitTestPoint(player.x + downBumpPoint.x, player.y + downBumpPoint.y, true)) {
					ExternalInterface.call('console.log', 'downBumping');
					// downBumping = true;
				} 	
			}
			
			/*if (leftBumping) {
				if (speed.x < 0) {
					speed.x *= -0.5;
				}
			}
			 
			if (rightBumping) {
				if (speed.x > 0) {
					speed.x *= -0.5;
				}
			}
			 
			if (upBumping) {
				if (speed.y < 0) {
					speed.y *= -0.5;
				}
			}
			 
			if (downBumping) {
				if (speed.y > 0) {
					speed.y *= -0.5;
				}
			}*/
		}
	}
}