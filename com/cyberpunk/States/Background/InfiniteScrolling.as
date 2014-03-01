package com.cyberpunk.States.Background 
{
	import com.cyberpunk.States.Platforms.PlatformContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class InfiniteScrolling extends Sprite
	{
		private var bg1:InfiniteBackground;
		private var bg2:InfiniteBackground;
		private var currentBackground:InfiniteBackground;
		private var platforms:PlatformContainer;
		
		private var ySpeed:Number = 4;
		
		public function InfiniteScrolling() 
		{
			bg1 	= new InfiniteBackground();
			bg2 	= new InfiniteBackground();
			
			// Platforms container - generate type A, B and C
			platforms = new PlatformContainer();
			
			// Add elements to the stage
			
			bg1.x = bg1.y = bg2.x = 0;
			bg2.y = bg1.y + bg1.height;
			
			addChild(bg1);
			addChild(bg2);
			
			bg1.addChild(platforms);
			
			currentBackground = bg1;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		// ySpeed to be based on the character
		public function set _ySpeed(ySpeed:Number):void 
		{
			this.ySpeed = ySpeed; 
		}
		
		private function update(e:Event):void
		{
			scroll();
		}
		
		private function scroll():void
		{
			bg1.y -= ySpeed;
			bg2.y -= ySpeed;
			
			if (currentBackground.y < -currentBackground.height) {
				if (currentBackground == bg1) {
					bg1.y = bg2.y + bg2.height;
					currentBackground = bg2;
				} else {
					bg2.y = bg1.y + bg1.height;
					currentBackground = bg1;
				}
			}
		}
	}
}
