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
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Game 
	{
		private var _stage:Stage;
		private var main:Main;
		private var assets:Assets;
		private var character:Character;
		private var background:InfiniteScrolling;
		private var platformContainer:PlatformContainer;
		private var collisionManager:CollisionManager;
		
		public function Game(main:Main) 
		{
			assets = new Assets();
			_stage = main._stage;
			
			character = new Character(assets.mCharacter, _stage);
			character.playerSpeed = new Point(0, Config.Y_SPEED);

			background        = new InfiniteScrolling();
			platformContainer = new PlatformContainer(character.playerClip);
			collisionManager  = new CollisionManager();

			collisionManager.playerSpeed = character.currentPlayerSpeed;

			_stage.addChild(background);
			_stage.addChild(assets);

			assets.mPlatformContainer.addChild(platformContainer);
			
			_stage.addEventListener(Event.ENTER_FRAME, cameraFollowCharacter);
			_stage.addEventListener(Event.ENTER_FRAME, update);
		}

		private function cameraFollowCharacter(e:Event):void 
		{
 			assets.scrollRect = new Rectangle(
 				character.playerClip.x - _stage.stageWidth / 2, 
 				character.playerClip.y - _stage.stageHeight / 2, 
 				_stage.stageWidth, _stage.stageHeight
 			);
		}
		
		private function update(evt:Event):void 
		{
			var ax:Number = ((_stage.stageWidth / 2) - assets.mouseX ) / (_stage.stageWidth / 2);
			var ay:Number = ((_stage.stageHeight / 2) - assets.mouseY) / (_stage.stageHeight / 2);

			character.calculateSpeed();
			collisionManager.platformsArray = platformContainer.platformArray;			
			collisionManager.update(character);
			character.update();

			background.move(-character.currentPlayerSpeed.x, -character.currentPlayerSpeed.y);
			platformContainer.update();


			character.bumpingKeys = collisionManager.bumpingKeys;
		}
	}
}