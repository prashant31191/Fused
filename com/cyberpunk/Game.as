package com.cyberpunk 
{
	import com.cyberpunk.States.Platforms.PlatformContainer;
	import com.cyberpunk.States.Protagonists.Character;
	import com.cyberpunk.States.Background.InfiniteScrolling;
	import com.cyberpunk.Setup.Config;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import Main;

	/**
	 * ...
	 * @author Caroline Aubry <caroline@carolineaubry.com>
	 */
	public class Game 
	{
		private var _stage:Stage;
		private var main:Main;
		private var assets:MovieClip;
		private var character:Character;
		private var background:InfiniteScrolling;
		private var platforms:PlatformContainer;
		
		private var upPressed:Number 		= 0;
		private var downPressed:Number 	= 0;
		private var leftPressed:Number 		= 0;
		private var rightPressed:Number 		= 0;
		
		public function Game(main:Main) 
		{
			assets = main.mAssets;
			_stage = main._stage;
			
			// Main character
			character 		= new Character(assets.mCharacter);
			// Scrolling background
			background 	= new InfiniteScrolling();
			// Platforms container - generate type A, B and C
			//platforms 		= new PlatformContainer();
			
			// Add elements to the stage
			//assets.mBackground.addChild(platforms);
			assets.mBackground.addChild(background);
			
			_stage.addEventListener(Event.ENTER_FRAME, update);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function update(evt:Event):void 
		{
			
		}
		
		private function keyDown(evt:KeyboardEvent):void 
		{
			var keyCode = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER)
				upPressed = 1;
			if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				downPressed = 1;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				leftPressed = 1;
			if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				rightPressed = 1; 
		}
		
		private function keyUp(evt:KeyboardEvent):void 
		{
			var keyCode = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER)
				upPressed = 0;
			if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				downPressed = 0;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				leftPressed = 0;
			if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				rightPressed = 0; 
		}
	}
}