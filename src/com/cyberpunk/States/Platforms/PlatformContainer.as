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

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class PlatformContainer extends Sprite
	{
		private var player:MovieClip;
		private var platforms:Array;
		private var platformPlaced:Array;
		private var savedCheckedPlatform:Array;
		private var platformShape:MovieClip;
		private var bricks:Array;
		private var platform:MovieClip;
		private var savedPlatform:*;
		private var hasPlatformGenerated:Boolean = false;
		private var addPlatRect:Rectangle;
		private var removePlatRect:Rectangle;
		private var platformRect:Array = [];
		private var randomPlatform:int;
		private var savedPlayerPos:Point;
		private var clipShape:MovieClip;
		
		public function PlatformContainer(player:MovieClip) 
		{
			this.player = player;

			savedPlayerPos = new Point(player.x, player.y);

			platforms = [ 'com.cyberpunk.States.Platforms.Platform1', 
						  'com.cyberpunk.States.Platforms.Platform2', 
						  'com.cyberpunk.States.Platforms.Platform3'
			];

			randomPlatform       = Utils.getRandomInt(10, 20);
			platformPlaced       = new Array();
			savedCheckedPlatform = new Array();

			var addingPlatformRect:Rectangle = new Rectangle(
				((player.x + (player.width / 2)) - (Config.STAGE_WIDTH / 2)) - Config.STAGE_WIDTH,
				((player.y + (player.height / 2)) - (Config.STAGE_HEIGHT / 2)) - Config.STAGE_HEIGHT,
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT * 3
			);

			ExternalInterface.call('console.log', 'COLLISION: ' + randomPlatform);
			for (var i:int = 0; i < randomPlatform; i++) 
			{
				generatePlatforms(addingPlatformRect);

				// ExternalInterface.call('console.log', checkPlatforms(platformPlaced, platformRect));
				if (!checkPlatforms(platformPlaced, platformRect)) {
					ExternalInterface.call('console.log', 'COLLISION')
					// platform = null;
					// removeChild(clipShape);
					// generatePlatforms(rect);
				}		
				savedCheckedPlatform.push(platformPlaced);
				// platformPlaced.push(platformShape);
				// savedPlatform = bricks;
			}
		}

		public function get platformArray():Array 
		{
			return platformPlaced;
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
		
		private function generatePlatforms(rect:Rectangle):void 
		{
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

			var currentIndexPos:int  = int(Math.random() * platforms.length);
			var ClassReference:Class = getDefinitionByName(platforms[currentIndexPos]) as Class;
			var savedBrickPlatform:MovieClip;

			platform = new ClassReference();
			bricks = new Array();

			var platformClips:Array = [];
			var brickAmount:int = Utils.getRandomInt(2, platform.amountOfBricks);

			for(var i:int = 0; i < platform._instance.numChildren; i++)
			{
				platformClips.push(platform._instance.getChildAt(i));
			};

			for (var z:int = 0; z < brickAmount; z++)
			{
				var randomIndex:int = int(Math.random() * platformClips.length);
				var ClassRef:Class = getDefinitionByName(platform.platformTypeName[randomIndex]) as Class;
				var currentClip:MovieClip = new ClassRef();
				
				currentClip.scaleX = currentClip.scaleY = 0.9;

				if (z == 0) {
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

				addChild(currentClip);
				bricks.push(currentClip);
				savedBrickPlatform = currentClip;
			};

			for(var j:int = bricks.length - 1; j >= 0; j--)
			{
				clipShape = new MovieClip();
			    clipShape.graphics.beginFill(0x333333, 0); 
			    clipShape.graphics.drawRect(bricks[j].x, bricks[j].y, bricks[j].width, bricks[j].height);     
			    clipShape.graphics.endFill();
			    addChild(clipShape);
				platformPlaced.push(clipShape);

				var currentRect:Rectangle = new Rectangle (  
					bricks[j].x, 
					bricks[j].y, 
					bricks[j].width, 
					bricks[j].height
				);

				platformRect.push(currentRect);
			};
		}
		
		private function checkPlatforms(currentPlatformArray:Array, platformRect:Array):Boolean 
		{
			for( var k = 0; k < currentPlatformArray.length; k++ )
			{
				if (currentPlatformArray[k].hitTestObject(player)) {
					return false;
				}

				var xOffset:int = 40;
				var yOffset:int = 40;

				var currentRect:Rectangle = new Rectangle (  
					platformRect[k].x,
					platformRect[k].y,
					platformRect[k].width,
					platformRect[k].height
				);

				currentRect.inflate(xOffset, yOffset);

				for( var l = savedCheckedPlatform.length - 1; l >= 0; l-- )
				{
					var rect:Rectangle = new Rectangle (
						savedCheckedPlatform[l].x,
						savedCheckedPlatform[l].y,
						savedCheckedPlatform[l].width,
						savedCheckedPlatform[l].height
					);

					if (rect.intersects(currentRect)) {
						return false;
					}
				};
			}
		
			return true;
		}
		
		private function addPlatforms():void 
		{
			addPlatRect = new Rectangle(
				(player.x + (player.width / 2)) - Config.STAGE_WIDTH - (Config.STAGE_WIDTH / 2),
				(player.y + (player.height * 2)) + Config.STAGE_HEIGHT,
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT
			);

			randomPlatform = Utils.getRandomInt(5, 8);

			for (var i:int = 0; i < randomPlatform; i++) 
			{
				generatePlatforms(addPlatRect);
				// platformPlaced.push(platformShape);
				// addChild(platform);
				// savedPlatform = platform;
			}
		}

		private function removePlatforms():void 
		{
			removePlatRect = new Rectangle(
				(player.x + (player.width / 2)) - Config.STAGE_WIDTH - (Config.STAGE_WIDTH / 2),
				player.y - (Config.STAGE_HEIGHT * 2),
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT
			);

			for (var i:int = 0; i < platformPlaced.length; i++) {
				if (removePlatRect.contains(platformPlaced[i].x, platformPlaced[i].y)) {
					if (platformPlaced[i]) removeChild(platformPlaced[i]);
				}
			}
		}
	}
}