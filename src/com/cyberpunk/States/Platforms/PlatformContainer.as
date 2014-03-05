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

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class PlatformContainer extends Sprite
	{
		private var player:MovieClip;
		private var platforms:Array;
		private var platformPlaced:Array;
		private var platform:MovieClip;
		private var savedPlatform:*;
		private var hasPlatformGenerated:Boolean = false;
		private var addPlatRect:Rectangle;
		private var removePlatRect:Rectangle;
		private var randomPlatform:int;
		private var savedPlayerPos:Point;
		
		public function PlatformContainer(player:MovieClip) 
		{
			this.player = player;

			savedPlayerPos = new Point(player.x, player.y);

			platforms = [ 'com.cyberpunk.States.Platforms.Platform1', 
						  'com.cyberpunk.States.Platforms.Platform2', 
						  'com.cyberpunk.States.Platforms.Platform3'
			];

			randomPlatform = Utils.getRandomInt(10, 20);
			platformPlaced = new Array();

			var addingPlatformRect:Rectangle = new Rectangle(
				((player.x + (player.width / 2)) - (Config.STAGE_WIDTH / 2)) - Config.STAGE_WIDTH,
				((player.y + (player.height / 2)) - (Config.STAGE_HEIGHT / 2)) - Config.STAGE_HEIGHT,
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT * 3
			);

			for (var i:int = 0; i < randomPlatform; i++) 
			{
				generatePlatforms(addingPlatformRect);
				platformPlaced.push(platform);
				addChild(platform);
				savedPlatform = platform;
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

			platform   = new ClassReference();
			platform.x = randomPoint.x;
			platform.y = randomPoint.y;
			platform.scaleY = platform.scaleX = 0.9;

			if (!checkPlatforms(platform)) {
				platform = null;
				generatePlatforms(rect);
			}
		}
		
		private function checkPlatforms(currentPlatform:*):Boolean 
		{
			if (currentPlatform.hitTestObject(player)) {
				return false;
			}

			var xOffset:int = 40;
			var yOffset:int = 40;

			var currentRect:Rectangle = new Rectangle (  
				currentPlatform.x,
				currentPlatform.y,
				currentPlatform.width,
				currentPlatform.height
			);

			currentRect.inflate(xOffset, yOffset);
			
			for (var i:int = 0; i < platformPlaced.length; i++) {
				var savedPlatform:* = platformPlaced[i];
				var rect:Rectangle = new Rectangle (  
					savedPlatform.x,
					savedPlatform.y,
					savedPlatform.width,
					savedPlatform.height
				);

				rect.inflate(xOffset, yOffset);

				if (rect.intersects(currentRect)) {
					return false;
				}
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
				platformPlaced.push(platform);
				addChild(platform);
				savedPlatform = platform;
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