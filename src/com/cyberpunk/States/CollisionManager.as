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

		public function set platformsArray(platforms:Array):void 
		{
			this.platforms = platforms;
		}

		public function get bumpingKeys():Dictionary 
		{
			return this.bumping;
		}
		
		public function update(player:MovieClip):void
		{
			for (var key:String in bumping) {
				bumping[key] = false;
			}

			for (var i:int = 0; i < platforms.length; i++) {

				var playerPos1:Point = new Point(player.x + leftBumpPoint.x, player.y + leftBumpPoint.y);
				var playerPos2:Point = new Point(player.x + rightBumpPoint.x, player.y + rightBumpPoint.y);
				var playerPos3:Point = new Point(player.x + upBumpPoint.x, player.y + upBumpPoint.y);
				var playerPos4:Point = new Point(player.x + downBumpPoint.x, player.y + downBumpPoint.y);

				playerPos1 = player.parent.localToGlobal(playerPos1);
				playerPos2 = player.parent.localToGlobal(playerPos2);
				playerPos3 = player.parent.localToGlobal(playerPos3);
				playerPos4 = player.parent.localToGlobal(playerPos4);

				speed.y = Config.Y_SPEED;

				if (platforms[i].hitTestPoint(playerPos1.x, playerPos1.y, true)) {
					bumping['left']  = true;
				}
				 
				if (platforms[i].hitTestPoint(playerPos2.x, playerPos2.y, true)) {
					bumping['right']  = true;
				}
				 
				if (platforms[i].hitTestPoint(playerPos3.x, playerPos3.y, true)) {
					bumping['up']  = true;
				}

				if (platforms[i].hitTestPoint(playerPos4.x, playerPos4.y, true)) {
					bumping['down']  = true;
				} 
			}
			
			if (bumping['left']) {
				if (speed.x < 0) {
					speed.x += 1;
				}
			}
			 
			if (bumping['right']) {
				if (speed.x > 0) {
					speed.x -= 1;
				}
			}
			 
			if (bumping['up']) {
				if (speed.y < 0) {
					speed.y += 1;
				}
			}
			 
			if (bumping['down']) {
				if (speed.y > 0) {
					speed.y = 0;
				}
			} 
		}
	}
}