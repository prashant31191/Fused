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

	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Character extends ProtagonistsBase
	{
		private var key:Dictionary;
		private var bumping:Dictionary;
		private var jump:Boolean = false;
		private var savedPlayerPos:Point;
		private var gravity:Number = 1;

		private var leftTween:TweenLite;
		private var rightTween:TweenLite;

		private var jumpAmount:Number = 5;
		private var jumping:Boolean   = false;

		private static const BASED_JUMP:Number = 5;
		
		public function Character(clip:MovieClip, stage:Stage) 
		{
			super (clip);

			key = new Dictionary();
			
			clip.x = (Config.STAGE_WIDTH / 2) - (clip.width / 2);
			clip.y = (Config.STAGE_HEIGHT / 2) - (clip.height / 2);

			addEventListener(Event.ENTER_FRAME, update);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		public function set bumpingKeys(bumping:Dictionary):void
		{
			this.bumping = bumping;
		}
		
		private function update(e:Event):void
		{
			speed.y = Math.min(Config.Y_SPEED, speed.y + gravity);

			if (bumping && bumping['down']) {
				speed.y = 0;
				jump = false;
			}
			
			if (key['up'] && bumping['down'] && !jump) mainJump();
			
			if (key['left']) {
				speed.x = -8;
				if (clip.rotationY == 0)
					leftTween = new TweenLite(clip, 0.3, {rotationY: 180, ease:Elastic});
			}
			
			else if (key['right']) {
				speed.x = 8;
				if (clip.rotationY == 180)
					rightTween = new TweenLite(clip, 0.3, {rotationY: 0, ease:Elastic});
			}

			else speed.x = 0;

			if (jumping) speed.y -= jumpAmount;
			if (jump) jumpAmount = Math.max(0, jumpAmount - 0.5);

			clip.x += speed.x;
			clip.y += speed.y;
		}

		private function mainJump():void 
		{
			jumping = true;
			jump = true;
		}

		private function keyDown(evt:KeyboardEvent):void 
		{
			var keyCode:int = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER)
				key['up'] = true;
			else if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				key['down'] = true;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				key['left'] = true;
			else if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				key['right'] = true;
		}
		
		private function keyUp(evt:KeyboardEvent):void 
		{
			var keyCode:int = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER) {
				key['up']  = false;
				jumping    = false;
				jumpAmount = BASED_JUMP;
			}
			else if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				key['down'] = false;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				key['left'] = false;
			else if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				key['right'] = false;
		}
	}
}
 // 