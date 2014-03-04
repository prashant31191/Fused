package com.cyberpunk.States 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import com.cyberpunk.Setup.Config;
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class CollisionManager 
	{
		private var platforms:Array;
		private var bumping:Dictionary;
		
		private var leftBumpPoint:Point  = new Point(-20, 0);
		private var rightBumpPoint:Point = new Point(20, 0);
		private var upBumpPoint:Point    = new Point(0, -20);
		private var downBumpPoint:Point  = new Point(0, 20);
		
		private var speed:Point;
		
		public function CollisionManager() 
		{
			bumping = new Dictionary();
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
			bumping['left']  = false;
			bumping['right'] = false;
			bumping['up']    = false;
			bumping['down']  = false;

			for (var i:int = 0; i < platforms.length; i++) {
				if (platforms[i].hitTestObject(player))
				{
					platforms[i].parent.removeChild(platforms[i])
				}
				// if (platforms[i].hitTestPoint(player.x + leftBumpPoint.x, player.y + leftBumpPoint.y, true)) {
				// 	ExternalInterface.call('console.log', 'leftBumping');
				// 	platforms[i].parent.removeChild(platforms[i])
				// 	bumping['left']  = true;
				// }
				 
				// if (platforms[i].hitTestPoint(player.x + rightBumpPoint.x, player.y + rightBumpPoint.y, true)) {
				// 	ExternalInterface.call('console.log', 'rightBumping');
				// 	platforms[i].parent.removeChild(platforms[i])
				// 	bumping['right']  = true;
				// }
				 
				// if (platforms[i].hitTestPoint(player.x + upBumpPoint.x, player.y + upBumpPoint.y, true)) {
				// 	ExternalInterface.call('console.log', 'upBumping');
				// 	platforms[i].parent.removeChild(platforms[i])
				// 	bumping['up']  = true;
				// } 
				 
				// if (platforms[i].hitTestPoint(player.x + downBumpPoint.x, player.y + downBumpPoint.y, true)) {
				// 	ExternalInterface.call('console.log', 'downBumping');
				// 	platforms[i].parent.removeChild(platforms[i])
				// 	bumping['down']  = true;
				// } 	
			}
			
			/*if (bumping['left']) {
				if (speed.x < 0) {
					speed.x *= -0.5;
				}
			}
			 
			if (bumping['right']) {
				if (speed.x > 0) {
					speed.x *= -0.5;
				}
			}
			 
			if (bumping['up']) {
				if (speed.y < 0) {
					speed.y *= -0.5;
				}
			}
			 
			if (bumping['down']) {
				if (speed.y > 0) {
					speed.y *= -0.5;
				}
			}*/
		}
	}
}