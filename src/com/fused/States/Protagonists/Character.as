package com.fused.States.Protagonists 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import com.fused.Setup.Config;
	import com.fused.States.Particles.*;
	import flash.geom.Point;
	import flash.utils.Timer;	
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.fused.Helpers.Utils;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Character extends ProtagonistsBase
	{
		private var key:Dictionary;
		private var bumping:Dictionary;
		private var jump:Boolean = false;
		private var isPlayerVisible:Boolean = false;
		private var jumpUp:Boolean = false;
		private var jumpingUp:Boolean = false;
		private var savedPlayerPos:Point;
		private var gravity:Number = 1;

		private var leftTween:TweenLite;
		private var rightTween:TweenLite;

		private var jumpAmount:Number = 8;
		private var jumping:Boolean   = false;

		private var particleHolder:ParticleHolder;
		private var particle:MovieClip;

		private static const BASED_JUMP:Number = 5;
		
		public function Character(clip:MovieClip, stage:Stage) 
		{
			super (clip);

			key = new Dictionary();

			particleHolder    = new ParticleHolder(clip);
			particle 		  = particleHolder._clip;

			clip.gotoAndStop(1);

			clip.x = (Config.STAGE_WIDTH / 2) - (clip.width / 2);
			clip.y = (Config.STAGE_HEIGHT / 2) - (clip.height / 2);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		public function set bumpingKeys(bumping:Dictionary):void
		{
			this.bumping = bumping;
		}

		public function calculateSpeed():void 
		{
			if (speed.y < Config.Y_SPEED) {
				speed.y += gravity;
			}
			
			// CODE IS AWFUL - NEED TO TIDY AFTER THE GAME JAM!!!!!!!!
			if (bumping != null && (bumping['down'] && !jumpUp)) {
				jumpAmount = 8;
				clip.gotoAndStop(1);
				speed.y = 0;
				jump = false;
				jumpUp = false;
			}

			if (key['up'] && bumping['down'] && !jump) mainJump();
			if (bumping && bumping['up'] && !jumpUp) mainJumpUp();
			if (jumping && !jumpingUp) speed.y -= jumpAmount;
			if (jumpingUp) speed.y -= 1.5;
			if (jump) jumpAmount = Math.max(0, jumpAmount - 2);
			if (jumpUp) jumpAmount = Math.max(0, jumpAmount - 2);

			if (bumping != null && !bumping['up'] && jumpUp) {
				jumpingUp    = false;
				jumpUp    = false;
				clip.gotoAndStop(1);
				jumpAmount = BASED_JUMP;
				key['up'] = false;
			}

			speed.x = 0;

			if (key['left']) {
				if (bumping['down']) speed.x = -Config.X_SPEED * 1.5;
				else speed.x = -Config.X_SPEED;
				leftTween = new TweenLite(clip, 0.3, {rotation: -40, ease:Elastic});
			}
			else if (key['right']) {
				if (bumping['down']) speed.x = Config.X_SPEED * 1.5;
				else speed.x = Config.X_SPEED;
				rightTween = new TweenLite(clip, 0.3, {rotation: 40, ease:Elastic});
			}
			else var originTween:TweenLite = new TweenLite(clip, 0.3, {rotation: 0, ease:Elastic});
		}

		public function update():void
		{
			if (!isPlayerVisible) {
				clip.alpha = 1;
				isPlayerVisible = true;
			}

			clip.x += speed.x;
			clip.y += speed.y;
		}

		private function mainJumpUp():void 
		{
			clip.gotoAndStop(2);
			jumpingUp = true;
			jumpUp = true;
		}

		private function mainJump():void 
		{
			clip.gotoAndStop(2);
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
				jumpingUp    = false;
				clip.gotoAndStop(1);
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
