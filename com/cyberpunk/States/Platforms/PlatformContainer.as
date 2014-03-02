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

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class PlatformContainer extends Sprite
	{
		private var ySpeed:int 	= 0;
		private var xSpeed:int 	= 0;
		private var player:MovieClip;
		private var platforms:Array;
		private var platformPlaced:Array;
		private var platform:*;
		private var savedPlatform:*;
		private var backPos:Point;
		private var hasPlatformGenerated:Boolean = false;
		
		public function PlatformContainer(playerMc:MovieClip) 
		{
			var randomPlatform:int;
			player = playerMc;
			
			/* 
			* Add any platorms you want to see on screen, 
			* As we are grabbing a random platform each time, 
			* we might not see it on screen straight away.
			**/
			
			PlatformType1;
			PlatformType2;
			PlatformType3;
			
			platforms = ['PlatformType1', 'PlatformType2', 'PlatformType3'];
			randomPlatform = Utils.getRandomInt(10, 20);
			platformPlaced = new Array();
			
			for (var i:int = 0; i < randomPlatform; i++) 
			{
				generatePlatforms();
				platformPlaced.push(platform);
				addChild(platform);
				savedPlatform = platform;
			}
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function set currentYSpeed(ySpeed:Number):void 
		{
			this.ySpeed = ySpeed; 
		}
		
		public function set currentXSpeed(xSpeed:Number):void 
		{
			this.xSpeed = xSpeed; 
		}
		
		public function get gameYSpeed():Number 
		{
			return ySpeed;
		}
		
		public function set backgroundPos(pos:Point):void 
		{
			backPos = pos;
		}
		
		public function get platformArray():Array
		{
			return platformPlaced;
		}
		
		private function generatePlatforms():void
		{
			var randomNumberPosX:int;
			var randomNumberPosY:int;
			var currentIndexPos:int;
			var ClassReference:Class;
			
			// Create a radius around the player position 
			var minPos:Point = new Point(
				player.x - Config.STAGE_WIDTH,
				player.y - Config.STAGE_HEIGHT
			);
			
			var maxPos:Point = new Point(
				player.x + Config.STAGE_WIDTH,
				player.y + Config.STAGE_HEIGHT
			);
			
			// Choose random positions
			randomNumberPosY 	= Utils.getRandomInt(minPos.y, maxPos.y);
			randomNumberPosX 	= Utils.getRandomInt(minPos.x, maxPos.x);
			
			// Grab a random index from our platforms array
			currentIndexPos = int(Math.random() * platforms.length);
			ClassReference  = getDefinitionByName(platforms[currentIndexPos]) as Class;
			platform = new ClassReference();
			platform.y = randomNumberPosY;
			platform.x = randomNumberPosX;
			
			if (!checkPlatforms(platform)) {
				platform = null;
				generatePlatforms();
			}
		}
		
		private function checkPlatforms(currentPlatform:*):Boolean {
			if (currentPlatform.hitTestObject(player)) {
				return false;
			}
			
			for (var i:int = 0; i < platformPlaced.length; i++) {
				var savedPlatform:* = platformPlaced[i];
				var xOffset:int = 40;
				var yOffset:int = 40;
				
				var obj:Object = {  
					x:  savedPlatform.x - xOffset,
					y:  savedPlatform.y - yOffset,
					w: savedPlatform.width + (xOffset * 2),
					h: savedPlatform.height + (yOffset * 2)
				};
				
				var hitBox:MovieClip = new MovieClip();
				hitBox.graphics.beginFill(0xFFCC00);
				hitBox.graphics.lineStyle(0, 0x666666);
				hitBox.graphics.drawRect(obj.x, obj.y, obj.w, obj.h);
				hitBox.graphics.endFill();
				//addChild(hitBox);
				
				if (hitBox.hitTestObject(currentPlatform)) {
					//removeChild(hitBox);
					return false;
				}
			}
			return true;
		}
		
		private function update(evt:Event):void
		{
			this.y -= ySpeed;
			this.x += xSpeed;
			checkRadius();

		}
		
		private function checkRadius():void
		{
			if (y <= - 200 && !hasPlatformGenerated) {
				hasPlatformGenerated = true;
				for (var i:int = 0; i < 20; i++) 
				{
					generatePlatforms();
					platformPlaced.push(platform);
					addChild(platform);
					savedPlatform = platform;
				}
			}
		}
	}
}