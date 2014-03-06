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
		
		private var leftBumpPointArray:Array = [
			new Point(-48, 22)
		];

		private var rightBumpPointArray:Array = [
			new Point(48, 12)
		];

		private var upBumpPointArray:Array = [
			new Point(-48, -25), new Point(-27, -18), new Point(-14, -14),
			new Point(4, -8),    new Point(18, -2),   new Point(27, 2),
			new Point(35, 5),    new Point(45, 10)
		];

		private var downBumpPointArray:Array = [
			new Point(-28, 17), new Point(-20, 19), new Point(-8, 20),
			new Point(-2, 21),  new Point(4, 19),   new Point(14, 20),
			new Point(20, 21),  new Point(27, 19),  new Point(35, 20),
			new Point(44, 20)
		];

		private var directionArray:Array = [
			{array: leftBumpPointArray,  direction:'left'}, 
			{array: rightBumpPointArray, direction:'right'}, 
			{array: downBumpPointArray,  direction:'down'}, 
			{array: upBumpPointArray,    direction:'up'}
		];
		
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
			for (var key:String in bumping) 
			{
				bumping[key] = false;
			}

			for (var i:int = 0; i < platforms.length; i++) 
			{
				for( var z:int = 0; z < directionArray.length; z++ )
				{
					checkCollision(directionArray[z].array, directionArray[z].direction, player, platforms[i]);
				};
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
		}

		private function checkCollision(currentArray:Array, currentDirection:String, player:MovieClip, currentPlatform:MovieClip):void 
		{
			for( var m:int = 0; m < currentArray.length; m++ )
			{
				var playerPos:Point = new Point(player.x + currentArray[m].x, player.y + currentArray[m].y);
				playerPos = player.parent.localToGlobal(playerPos);
				if (currentPlatform.hitTestPoint(playerPos.x, playerPos.y, true)) {
					speed.y = currentPlatform.velocity;
					if (currentPlatform.velocity > 0) 
						bumping[currentDirection] = true;
					break;
				} 
			};
		}
	}
}