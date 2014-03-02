package com.cyberpunk.States.Protagonists 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import com.cyberpunk.Setup.Config;
	import flash.geom.Point;
	import flash.utils.Timer;	
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Character  extends Sprite
	{
		private var character:MovieClip;
		
		private var xSpeed:int = 0;
		private var ySpeed:int = 0;
		
		public function Character(clip:MovieClip) 
		{
			character 		= clip;
			
			clip.x = (Config.STAGE_WIDTH / 2) -  (clip.width / 2);
			clip.y = (Config.STAGE_HEIGHT / 2) -  (clip.height / 2);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function get playerPos():MovieClip
		{
			return character;
		}
		
		public function set currentXSpeed(xSpeed:int):void
		{
			this.xSpeed = xSpeed;
		}
		
		public function set currentYSpeed(ySpeed:int):void
		{
			this.ySpeed = ySpeed;
		}
		
		private function update(e:Event):void
		{
			character.x += xSpeed;
			character.y += ySpeed;
		}
	}
}
 