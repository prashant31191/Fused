package com.cyberpunk 
{
	import com.cyberpunk.States.*;
	import com.cyberpunk.States.Platforms.PlatformContainer;
	import com.cyberpunk.States.Protagonists.*;
	import com.cyberpunk.States.Background.*;
	import com.cyberpunk.Setup.Config;
	import com.cyberpunk.Helpers.Utils;
	import com.cyberpunk.States.Protagonists.EnemiesContainer;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import Main;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.events.Event;

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Game 
	{
		private var _stage:Stage;
		private var main:Main;
		private var assets:Assets;

		private var player:Player;
		private var platformContainer:PlatformContainer;
		private var enemiesContainer:EnemiesContainer;
		private var scrollingBackground:ScrollingBackground;
		private var collisionManager:CollisionManager;
		private var controls:Controls;

		// Variables for platforms
		private var newArea:Rectangle;
		private var oldArea:Rectangle;
		private var numPlatforms:Number;
		private var numEnemies:Number;
		private var currentEnemy:*;
		
		public function Game(main:Main) 
		{
			assets = new Assets();
			_stage = main._stage;

			player = new Player(assets.mCharacter);
			init();

			_stage.addChild(assets);
			assets.addChild(player);
			cameraFollowCharacter();

			platformContainer = new PlatformContainer();
			platformContainer.playerClip = player;

			enemiesContainer = new EnemiesContainer();
			enemiesContainer.savedPlatforms = platformContainer.platformArray;

			// scrollingBackground = new ScrollingBackground();
			// collisionManager    = new CollisionManager();
			// controls 			= new Controls(_stage);

			platformContainer.addPlatforms(newArea, numPlatforms);
			enemiesContainer.addEnemies(newArea, numEnemies);

			// var platformCollisionEvent:String = 'platform_collision';
			// var enemyCollisionEvent:String    = 'enemy_collision';

			// collisionManager.addEventListener(platformCollisionEvent, onPlatformCollision);
			// collisionManager.addEventListener(enemyCollisionEvent, onEnemyCollision);

			// collisionManager.detectCollision(platformsArray, player, platformCollisionEvent);
			// collisionManager.detectCollision(enemiesArray, player, enemyCollisionEvent);

			// character.changeSpeed();

            // dispatchEvent(new Event(eventName));
			
			// character = new Character(assets.mCharacter, _stage);
			// character.playerSpeed = new Point(0, Config.Y_SPEED);

			// enemiesContainer = new EnemiesContainer(assets.mEnemies, character.playerClip);

			// background        = new InfiniteScrolling();
			// platformContainer = new PlatformContainer(character.playerClip);
			// collisionManager  = new CollisionManager();

			// collisionManager.platformsName = platformContainer.platformsName;
			// collisionManager.playerSpeed   = character.currentPlayerSpeed;

			// _stage.addChild(background);
			
			assets.addChild(platformContainer);
			assets.addChild(enemiesContainer);

			_stage.addEventListener(Event.ENTER_FRAME, update);
			_stage.addEventListener(Event.ENTER_FRAME, cameraFollowCharacter);
		}

		private function cameraFollowCharacter(e:Event = null):void 
		{
 			assets.scrollRect = new Rectangle(
 				player.x - _stage.stageWidth / 2, 
 				player.y - _stage.stageHeight / 2, 
 				_stage.stageWidth, _stage.stageHeight
 			);
		}

		/*Define two areas, one for adding platforms/enemies,
		the other one to remove platforms/enemies
		and a random amount of platforms to be generated*/
		private function init():void 
		{
			newArea = new Rectangle(
				((player.x + (player.width / 2)) - (Config.STAGE_WIDTH / 2)) - Config.STAGE_WIDTH,
				((player.y + (player.height / 2)) - (Config.STAGE_HEIGHT / 2)) - Config.STAGE_HEIGHT,
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT * 3
			);

			oldArea = new Rectangle(
				(player.x + (player.width / 2)) - Config.STAGE_WIDTH - (Config.STAGE_WIDTH / 2),
				player.y - (Config.STAGE_HEIGHT * 2),
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT
			);

			numPlatforms = Utils.getRandomInt(2, 10);
			numEnemies   = Utils.getRandomInt(1, 200);
		}

		private function onPlatformCollision(evt:Event):void 
		{
			
		}
		
		private function update(evt:Event):void 
		{
			// character.calculateSpeed();
			// collisionManager.platformsArray = platformContainer.platformArray;			
			// collisionManager.update(character);
			// character.update();

			// background.move(-character.currentPlayerSpeed.x / 4, -character.currentPlayerSpeed.y / 4);
			
			enemiesContainer.update();
			playerCloseToEnemies(enemiesContainer.enemiesArray);

			// character.bumpingKeys = collisionManager.bumpingKeys;
		}

		private function playerCloseToEnemies(enemies:Array):void 
		{
			var distance:Number;

			for(var i:int = 0; i < enemies.length; i++)
			{
				for( var j = 0; j < enemies[i].numChildren; j++ )
				{
					distance = Point.distance(
						new Point(player.x, player.y),
						new Point(enemies[i].getChildAt(j).x, enemies[i].getChildAt(j).y)
					);
					if (distance < 300) {
						enemiesContainer.shootAtPosition(
							new Point(player.x, player.y),
							enemies[i].getChildAt(j)
						);
					}
				};
			};
		}
	}
}