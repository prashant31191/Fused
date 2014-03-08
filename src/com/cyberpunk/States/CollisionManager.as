package com.cyberpunk.States 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import com.cyberpunk.Setup.Config;
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	import flash.geom.Rectangle;
	import com.cyberpunk.States.Protagonists.Character;

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class CollisionManager 
	{
		private var platforms:Array;
		private var bumping:Dictionary;
		private var test:MovieClip;
		
		// private var leftBumpPointArray:Array = [
		// 	new Point(-48, 22)
		// ];

		private var leftBumpPointArray:Array = [
			new Point(-7.5, -13.9), new Point(-9.1, -12.6), new Point(-13.5, -10.5), new Point(-16, -6.5),  new Point(-18.9, -3.2),
			new Point(-18, -1.1),   new Point(-17.4, 0.8),  new Point(-17.6, -4.6),  new Point(16.4, -6.1), new Point(-15.5, -8.1),
			new Point(-13.9, -0.4), new Point(-15.6, -4.1), new Point(-6.2, -1.1),   new Point(-8.2, 0.9),  new Point(-9.5, 2),
			new Point(-10.8, 4.2),  new Point(-12, 6.1),    new Point(-12.9, 6.9),   new Point(-10.2, 8.6), new Point(-8.4, 10.4),
			new Point(-6.4, 12.1),  new Point(-4.6, 14),    new Point(-4, 16.9),     new Point(-3, 18.9),   new Point(-2.5, 19.8),
			new Point(0.6, 22.9),   new Point(1.1, 24.9),   new Point(1.1, 26.1),
			new Point(0.2, -24.4),  new Point(-1, -24),    new Point(1.5, -24),    new Point(3.9, -22.8),  new Point(-2.2, -23.1),
			new Point(-2.9, -20.6), new Point(-2, -18.4),  new Point(-1.4, -16.9), new Point(-1.1, -14.5), new Point(1.9, -14.9),
			new Point(1.4, -16.9),  new Point(2.8, -17.5), new Point(4.1, -15.9),  new Point(-5.6, -15)
		];

		// private var rightBumpPointArray:Array = [
		// 	new Point(48, 12)
		// ];

		private var rightBumpPointArray:Array = [
			new Point(20, 0)
		];

		// private var upBumpPointArray:Array = [
		// 	new Point(-48, -25), new Point(-27, -18), new Point(-14, -14),
		// 	new Point(4, -8),    new Point(18, -2),   new Point(27, 2),
		// 	new Point(35, 5),    new Point(45, 10)
		// ];

		private var upBumpPointArray:Array = [
			new Point(0.2, -24.4)
		];

		// private var downBumpPointArray:Array = [
		// 	new Point(-28, 17), new Point(-20, 19), new Point(-8, 20),
		// 	new Point(-2, 21),  new Point(4, 19),   new Point(14, 20),
		// 	new Point(20, 21),  new Point(27, 19),  new Point(35, 20),
		// 	new Point(44, 20)
		// ];

		private var downBumpPointArray:Array = [
			new Point(1.2, 27.5), new Point(0.8, 29), new Point(1.1, 29.4)
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
			this.test = test;
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
		
		public function update(player:Character):void
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
		}

		private function checkCollision(currentArray:Array, currentDirection:String, player:Character, currentPlatform:MovieClip):void 
		{
			var playerMc:MovieClip = player.playerClip;
			var playerSpeed:Point  = player.currentPlayerSpeed;

			for( var m:int = 0; m < currentArray.length; m++ )
			{
				var playerPos:Point = new Point((playerMc.x + playerSpeed.x) + currentArray[m].x, (playerMc.y + playerSpeed.y) + currentArray[m].y);
				playerPos = playerMc.parent.localToGlobal(playerPos);
				if (currentPlatform.hitTestPoint(playerPos.x, playerPos.y, true)) {
					switch(currentDirection)
					{
						case 'left':
							playerSpeed.x = 0;
							break;
						case 'right':
							playerSpeed.x = 0;
							break;
						case 'up':
							playerSpeed.y = 0;
							break;
						case 'down':
							playerSpeed.y = 0;
							break;
					}
					bumping[currentDirection] = true;
					break;
				} 
			};
		}
	}
}