package com.cyberpunk 
{
	import com.cyberpunk.States.CollisionManager;
	import com.cyberpunk.States.Platforms.PlatformContainer;
	import com.cyberpunk.States.Protagonists.Character;
	import com.cyberpunk.States.Background.InfiniteScrolling;
	import com.cyberpunk.Setup.Config;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import Main;

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Game 
	{
		private var _stage:Stage;
		private var main:Main;
		private var assets:MovieClip;
		private var character:Character;
		private var background:InfiniteScrolling;
		private var platformContainer:PlatformContainer;
		private var collisionManager:CollisionManager;
		
		private var leftKeyDown:Boolean 		= false;
		private var upKeyDown:Boolean 		= false;
		private var rightKeyDown:Boolean 	= false;
		private var downKeyDown:Boolean 	= false;
		
		private var mainJumping:Boolean = false;
		private var jumpSpeedLimit:int = 15;
		private var jumpSpeed:Number = jumpSpeedLimit;

		public function Game(main:Main) 
		{
			assets = main.mAssets;
			_stage = main._stage;
			
			character = new Character(assets.mCharacter);
			platformContainer = new PlatformContainer(character.playerPos);
			
			// Scrolling background
			background = new InfiniteScrolling();
			background.currentYSpeed = platformContainer.gameYSpeed;
			
			collisionManager = new CollisionManager(assets.mCharacter, platformContainer.platformArray, _stage);
			
			assets.mBackground.addChild(background);
			assets.mBackground.addChild(platformContainer);
			
			_stage.addEventListener(Event.ENTER_FRAME, update);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function update(evt:Event):void 
		{
			background.currentYSpeed = platformContainer.gameYSpeed;
			platformContainer.currentXSpeed = collisionManager.speedX;
			platformContainer.currentYSpeed = collisionManager.speedY;
			
			if (leftKeyDown) platformContainer.currentXSpeed = 5;
			else if (rightKeyDown) platformContainer.currentXSpeed = -5;
			else if (upKeyDown || mainJumping) mainJump();
		}
		
		private function mainJump():void
		{
			if (!mainJumping) {
				mainJumping = true;
				jumpSpeed = jumpSpeedLimit * -1;
				platformContainer.currentYSpeed = jumpSpeed;
			} else {
				if (jumpSpeed < 0) {
					jumpSpeed *= 1 - jumpSpeedLimit / 75;
					if (jumpSpeed > -jumpSpeedLimit / 5) {
						jumpSpeed *= -1;
					}
				}
			}
			
			if (jumpSpeed > 0) {
				mainJumping = false;
				platformContainer.currentYSpeed = 0;
			} 
		}
		
		private function keyDown(evt:KeyboardEvent):void 
		{
			var keyCode = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER)
				upKeyDown = true;
			if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				downKeyDown = true;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				leftKeyDown = true;
			if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				rightKeyDown = true; 
		}
		
		private function keyUp(evt:KeyboardEvent):void 
		{
			var keyCode = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER)
				upKeyDown = false;
			if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				downKeyDown = false;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				leftKeyDown = false;
			if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				rightKeyDown = false; 
		}
	}
}