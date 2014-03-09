package com.cyberpunk.States.Platforms 
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import com.cyberpunk.Helpers.Utils;
	import com.cyberpunk.Setup.Config;
	import flash.geom.Rectangle;
	import flash.external.ExternalInterface;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.utils.getQualifiedSuperclassName;

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class PlatformContainer extends Sprite
	{
		private var player:MovieClip;
		private var platforms:Array;
		private var savedCheckedPlatform:Array;
		private var bricks:Array;
		private var platform:MovieClip;
		private var randomPlatform:int;
		private var savedPlayerPos:Point;
		
		public function PlatformContainer(player:MovieClip) 
		{
			this.player = player;

			savedPlayerPos = new Point(player.x, player.y);

			platforms = [ {packageName: 'com.cyberpunk.States.Platforms.Platform1', type: 'Platform1'}, 
					      {packageName: 'com.cyberpunk.States.Platforms.Platform2', type: 'Platform2'}, 
			 			  {packageName: 'com.cyberpunk.States.Platforms.Platform3', type: 'Platform3'}
			];

			randomPlatform       = Utils.getRandomInt(Config.MIN_PLATFORMS, Config.MAX_PLATFORMS);
			savedCheckedPlatform = new Array();

			var addingPlatformRect:Rectangle = new Rectangle(
				((player.x + (player.width / 2)) - (Config.STAGE_WIDTH / 2)) - Config.STAGE_WIDTH,
				((player.y + (player.height / 2)) - (Config.STAGE_HEIGHT / 2)) - Config.STAGE_HEIGHT,
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT * 3
			);

			for (var i:int = 0; i < randomPlatform; i++) 
			{
				var currentPlatformMc:MovieClip = generatePlatforms(addingPlatformRect);
				checkPlatforms(currentPlatformMc);
			}
		}

		public function get platformArray():Array 
		{
			return savedCheckedPlatform;
		}

		public function get platformsName():Array 
		{
			return platforms;
		}

		public function update():void
		{
			if (player.y >= savedPlayerPos.y + Config.STAGE_HEIGHT) {
				savedPlayerPos.y = player.y;
				addPlatforms();
			} else if (savedPlayerPos.y - Config.STAGE_HEIGHT >= player.y) {
				savedPlayerPos.y = player.y;
				removePlatforms();
			}
		}
		
		private function generatePlatforms(rect:Rectangle):MovieClip 
		{
			// Random position for the platform container
			var randomPoint:Point = new Point(
				Utils.getRandomInt(
					rect.x,
					rect.x + rect.width
				),
				Utils.getRandomInt(
					rect.y,
					rect.y + rect.height
				)
			);

			Platform1;
			Platform2;
			Platform3;

			// Choose a random platform container
			var currentIndexPos:int  = int(Math.random() * platforms.length);
			var ClassReference:Class = getDefinitionByName(platforms[currentIndexPos].packageName) as Class;

			// Store the current platform container
			platform = new ClassReference();

			var savedBrickPlatform:MovieClip;
			bricks = new Array();
			
			// Pick a random amount of bricks for the current platform container
			var brickAmount:int = Utils.getRandomInt(2, platform.amountOfBricks);

			// Store the instances of the current platform container
			var platformClips:Array = [];

			for(var i:int = 0; i < platform._instance.numChildren; i++)
			{
				platformClips.push(platform._instance.getChildAt(i));
			};

			var newPlatform:MovieClip = new MovieClip();

			/*Give a position to every brick, relative to the first brick 
			of the current platform*/
			for (var z:int = 0; z < brickAmount; z++)
			{
				// Pick a random brick design
				var randomIndex:int = int(Math.random() * platformClips.length);
				var ClassRef:Class = getDefinitionByName(platform.platformTypeName[randomIndex]) as Class;
				// Store the current design into currentClip
				var currentClip:MovieClip = new ClassRef();
				currentClip.scaleX = currentClip.scaleY = 0.9;

				if (z == 0) {
					// Random position for the first brick of the platform 
					currentClip.x = randomPoint.x;
					currentClip.y = randomPoint.y;
				} else {
					if (platform.platformAxis == 'X_AXIS') {
						currentClip.x = savedBrickPlatform.x + currentClip.width;
						currentClip.y = savedBrickPlatform.y;
					} else {
						currentClip.x = savedBrickPlatform.x;
						currentClip.y = savedBrickPlatform.y + currentClip.height;
					}
				}
				// Save previous brick position
				savedBrickPlatform = currentClip;
				// Add a brick to the stage
				newPlatform.addChild(currentClip);
				// Keep a track of every bricks for the current platform
				bricks.push(currentClip);		
			};

			return newPlatform;
		}
		
		private function checkPlatforms(currentPlatform:MovieClip):void 
		{			
			var rect:Rectangle       = currentPlatform.getRect(currentPlatform.parent);
			var playerRect:Rectangle = player.getRect(player.parent);

			rect.inflate(40, 40);
			playerRect.inflate(40, 40);

			// Check platform collision on player
			if (rect.intersects(playerRect)) return;

			for(var z:int = 0; z < savedCheckedPlatform.length; z++)
			{
				var rect2:Rectangle = savedCheckedPlatform[z].clip.getRect(savedCheckedPlatform[z].clip.parent);
				// Check platform to platform collision
				if (rect.intersects(rect2)) return;
			};

			addChild(currentPlatform);
			savedCheckedPlatform.push({clip: currentPlatform, platform: platform});
		}
		
		private function addPlatforms():void 
		{
			var addPlatRect:Rectangle = new Rectangle(
				(player.x + (player.width / 2)) - Config.STAGE_WIDTH - (Config.STAGE_WIDTH / 2),
				(player.y + (player.height * 2)) + Config.STAGE_HEIGHT,
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT
			);

			for (var i:int = 0; i < randomPlatform; i++) 
			{
				var currentPlatform:MovieClip = generatePlatforms(addPlatRect);
				checkPlatforms(currentPlatform);
			}
		}

		private function removePlatforms():void 
		{
			var removePlatRect:Rectangle = new Rectangle(
				(player.x + (player.width / 2)) - Config.STAGE_WIDTH - (Config.STAGE_WIDTH / 2),
				player.y - (Config.STAGE_HEIGHT * 2),
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT
			);
			
			for (var i:int = 0; i < savedCheckedPlatform.length; i++) {
				if (removePlatRect.contains(savedCheckedPlatform[i].clip.x, savedCheckedPlatform[i].clip.y)) {
					if (savedCheckedPlatform[i].clip) removeChild(savedCheckedPlatform[i].clip);
				}
			}

			// savedCheckedPlatform = new Array();
		}
	}
}