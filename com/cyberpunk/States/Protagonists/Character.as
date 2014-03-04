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
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Character  extends Sprite
	{
		private var character:MovieClip;
		private var speed:Point;

		private var mainJumping:Boolean = false;
		private var jumpSpeedLimit:int  = 15;
		private var jumpSpeed:Number    = jumpSpeedLimit;
		private var key:Dictionary;
		
		public function Character(clip:MovieClip, stage:Stage) 
		{
			character = clip;
			key = new Dictionary();
			
			clip.x = (Config.STAGE_WIDTH / 2) -  (clip.width / 2);
			clip.y = (Config.STAGE_HEIGHT / 2) -  (clip.height / 2);
			
			addEventListener(Event.ENTER_FRAME, update);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		public function get playerClip():MovieClip
		{
			return character;
		}

		public function set playerSpeed(speed:Point):void 
		{
			this.speed = speed;
		}

		public function get currentPlayerSpeed():Point 
		{
			return this.speed;
		}
		
		private function update(e:Event):void
		{
			if (key['left']) speed.x = -5;
			else if (key['right']) speed.x = 5;
			else if (key['down']) speed.y = 5;
			else if (key['up']) speed.y = -5;
			// else if (upKeyDown || mainJumping) mainJump();
			else {
				speed.x = 0;
				speed.y = Config.Y_SPEED;
			}

			character.x += speed.x;
			character.y += speed.y;
		}

		private function mainJump():void 
		{
			if (!mainJumping) {
				mainJumping = true;
				jumpSpeed = jumpSpeedLimit * -1;
				speed.y = jumpSpeed;
			} else if (jumpSpeed < 0) {
				jumpSpeed *= 1 - jumpSpeedLimit / 75;
				if (jumpSpeed > -jumpSpeedLimit / 5) {
					jumpSpeed *= -1;
				}
			}
			
			if (jumpSpeed > 0) {
				mainJumping = false;
				speed.y = 0;
			} 
		}

		private function keyDown(evt:KeyboardEvent):void 
		{
			var keyCode:int = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER)
				key['up'] = true;
			if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				key['down'] = true;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				key['left'] = true;
			if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				key['right'] = true;
		}
		
		private function keyUp(evt:KeyboardEvent):void 
		{
			var keyCode:int = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER)
				key['up'] = false;
			if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				key['down'] = false;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				key['left'] = false;
			if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				key['right'] = false;
		}
	}
}
 