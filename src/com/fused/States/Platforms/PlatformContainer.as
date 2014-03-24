package com.fused.States.Platforms 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import com.fused.Helpers.Utils;
	import flash.geom.Rectangle;
	import flash.external.ExternalInterface;

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class PlatformContainer extends Sprite
	{
		private var platformContainer:MovieClip;
		private var savedCheckedPlatform:Array;
		private var platforms:Array;
		private var platform:*;
		private var player:Sprite;
		
		public function PlatformContainer() 
		{
			platforms = [ {packageName: 'com.fused.States.Platforms.Platform1', type: 'Platform1'}, 
					      {packageName: 'com.fused.States.Platforms.Platform2', type: 'Platform2'}, 
			 			  {packageName: 'com.fused.States.Platforms.Platform3', type: 'Platform3'}
			];

			Platform1;
			Platform2;
			Platform3;

			platformContainer = new MovieClip();
			addChild(platformContainer);

			savedCheckedPlatform = new Array();
		}

		// Loop through this array of platforms to grab bricks
		public function get platformArray():Array 
		{
			return savedCheckedPlatform;
		}

		public function set playerClip(player:Sprite):void 
		{
			this.player = player;
		}

		public function addPlatforms(newArea:Rectangle, numPlatforms:Number):void 
		{
			for(var i:int = 0; i < numPlatforms; i++)
			{
				var currentPlatform:Sprite = createPlatform(newArea);
				if (!hasPlatformCollided(currentPlatform) && !hasPlayerCollided(currentPlatform)) {
					platformContainer.addChild(currentPlatform);
					savedCheckedPlatform.push(currentPlatform);
				}
			};
		}

		public function removePlatforms(oldArea:Rectangle):void 
		{
			for (var i:int = 0; i < savedCheckedPlatform.length; i++) {
				if (oldArea.contains(savedCheckedPlatform[i].x, savedCheckedPlatform[i].y)) {
					if (savedCheckedPlatform[i]) removeChild(savedCheckedPlatform[i]);
				}
			}

			savedCheckedPlatform = new Array();
		}

		private function hasPlatformCollided(currentPlatform:Sprite):Boolean 
		{
			var rect:Rectangle = currentPlatform.getRect(currentPlatform.parent);
			rect.inflate(40, 40);

			for(var z:int = 0; z < savedCheckedPlatform.length; z++)
			{
				var rect2:Rectangle = savedCheckedPlatform[z].getRect(savedCheckedPlatform[z].parent);
				if (rect.intersects(rect2)) return true;
			};

			return false;
		}

		private function hasPlayerCollided(currentPlatform:Sprite):Boolean 
		{
			var rect:Rectangle       = currentPlatform.getRect(currentPlatform.parent);
			var playerRect:Rectangle = player.getRect(player.parent);

			rect.inflate(40, 40);
			playerRect.inflate(40, 40);

			if (rect.intersects(playerRect)) return true;
			return false;
		}

		private function createPlatform(newArea:Rectangle):MovieClip 
		{
			// Pick a random position inside the given rectangle
			var randomSinglePlatformPosition:Point = new Point(
				Utils.getRandomInt(
					newArea.x,
					newArea.x + newArea.width
				),
				Utils.getRandomInt(
					newArea.y,
					newArea.y + newArea.height
				)
			);

			// Pick a random platform type
			var currentIndex:int = int(Math.random() * platforms.length);
			var ClassReference:Class = getDefinitionByName(platforms[currentIndex].packageName) as Class;

			// Store the current platform type
			platform = new ClassReference();

			var savedBrickPlatform:MovieClip;
			
			// Pick a random amount of bricks for the current platform container
			var brickAmount:int = Utils.getRandomInt(2, platform.numBricksPerPlatform);

			var newPlatform:MovieClip = new MovieClip();

			// Give a position to every brick, relative to the first brick 
			// of the current platform
			for (var z:int = 0; z < brickAmount; z++)
			{
				// Pick a random brick design
				var randomIndex:int = int(Math.random() * platform.numBricksTypePerPlatform);
				var ClassRef:Class  = getDefinitionByName(platform.brickArray[randomIndex]) as Class;
				// Store the current design into currentClip
				var currentClip:MovieClip = new ClassRef();

				if (z == 0) {
					// Random position for the first brick of the platform 
					currentClip.x = randomSinglePlatformPosition.x;
					currentClip.y = randomSinglePlatformPosition.y;
				} else {
					if (platform.brickAxisForPlatform == 'X_AXIS') {
						currentClip.x = savedBrickPlatform.x + currentClip.width;
						currentClip.y = savedBrickPlatform.y;
					} else {
						currentClip.x = savedBrickPlatform.x;
						currentClip.y = savedBrickPlatform.y + currentClip.height;
					}
				}
				// Save previous brick position
				savedBrickPlatform = currentClip;
				newPlatform.addChild(currentClip);
			};

			return newPlatform;
		}
	}
}
