package com.cyberpunk.States.Platforms 
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.cyberpunk.Helpers.Utils;
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class PlatformContainer extends Sprite
	{
		private var typeA:PlatformTypeA;
		private var typeB:PlatformTypeB;
		private var typeC:PlatformTypeC;
		
		private var platforms:Array;
		private var shuffledPlatforms:Array;
		private var randomPlatform:int;
		
		private var ySpeed:Number = 0;
		
		public function PlatformContainer() 
		{
			typeA = new PlatformTypeA();
			typeB = new PlatformTypeB();
			typeC = new PlatformTypeC();
			
			platforms = [typeA, typeB, typeC];
			shuffledPlatforms = new Array(platforms.length);
			
			var randomPos:int = 0;
			var savedRandomPos:Array = [];
			
			// Random integer between 4 and 8 to generate 
			randomPlatform = Utils.getRandomInt(4, 8);
			trace(randomPlatform);
			var randomNumber:int;
			
			
			for (var i:int = 0; i < randomPlatform; i++) 
			{
				randomNumber = Utils.getRandomInt(0, 360);
				typeA.y = randomNumber;
				addChild(typeA);
			}
			
			/*
			for (var z:int = 0; z < randomPlatform; z++) 
			{
				var array:Array = [];
				
				for (var i:int = 0; i < platforms.length; i++)
				{
					randomPos = int(Math.random() * platforms.length);
					if (!savedRandomPos.indexOf(randomPos)) {
						shuffledPlatforms[i] = platforms.splice(randomPos, 1)[0];
					} else {
						randomPos = int(Math.random() * platforms.length);
						shuffledPlatforms[i] = platforms.splice(randomPos, 1)[0];
					}
					savedRandomPos.push(randomPos);
					array.push(shuffledPlatforms[i]);
				}
				trace(array);
			}*/
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function set _ySpeed(ySpeed:Number):void 
		{
			this.ySpeed = ySpeed; 
		}
		
		private function update(evt:Event):void
		{
			this.y -= ySpeed;
		}
		
	}

}