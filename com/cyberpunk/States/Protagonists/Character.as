package com.cyberpunk.States.Protagonists 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import com.cyberpunk.Setup.Config;
	
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Character  extends MovieClip
	{
		private var character:MovieClip;
		
		private var upPressed:Number 		= 0;
		private var downPressed:Number 	= 0;
		private var leftPressed:Number 		= 0;
		private var rightPressed:Number 		= 0;
		
		public function Character(clip:MovieClip) 
		{
			clip.x = (640 / 2) -  (clip.width / 2);
			clip.y = (360 / 2) -  (clip.height / 2);
		}
		
		private function changeAnim() :void 
		{
			
		}
	}
}
 