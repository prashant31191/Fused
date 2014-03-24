package com.fused 
{
	import com.fused.States.*;
	import com.fused.States.Platforms.PlatformContainer;
	import com.fused.States.Protagonists.*;
	import com.fused.States.Background.*;
	import com.fused.Setup.Config;
	import com.fused.Helpers.Utils;
	import com.fused.Events.KeyEvents;
	import com.fused.States.Protagonists.EnemiesContainer;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import Main;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.utils.Dictionary;

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

			controls = new Controls(_stage);
			scrollingBackground = new ScrollingBackground();

			player   = new Player(assets.mCharacter);
			player.playerSpeed = new Point(0, 0);
			// player.playerSpeed = new Point(0, Config.Y_SPEED);
			player.generateParticles();
			init();

			_stage.addChild(scrollingBackground);
			_stage.addChild(assets);

			assets.addChild(player);
			cameraFollowCharacter();

			platformContainer = new PlatformContainer();
			platformContainer.playerClip = player;

			enemiesContainer = new EnemiesContainer();
			enemiesContainer.savedPlatforms = platformContainer.platformArray;

			// collisionManager    = new CollisionManager();

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
			_stage.addEventListener(KeyEvents.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyEvents.KEY_UP, onKeyUp);
		}

		private function cameraFollowCharacter(e:Event = null):void 
		{
 			assets.scrollRect = new Rectangle(
 				player.clip.x - _stage.stageWidth / 2, 
 				player.clip.y - _stage.stageHeight / 2, 
 				_stage.stageWidth, _stage.stageHeight
 			);
		}

		/*Define two areas, one for adding platforms/enemies,
		the other one to remove platforms/enemies
		and a random amount of platforms to be generated*/
		private function init():void 
		{
			newArea = new Rectangle(
				((player.clip.x + (player.clip.width / 2)) -  (Config.STAGE_WIDTH / 2)) - Config.STAGE_WIDTH,
				((player.clip.y + (player.clip.height / 2)) - (Config.STAGE_HEIGHT / 2)) - Config.STAGE_HEIGHT,
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT * 3
			);

			oldArea = new Rectangle(
				(player.clip.x + (player.clip.width / 2)) - Config.STAGE_WIDTH - (Config.STAGE_WIDTH / 2),
				player.clip.y - (Config.STAGE_HEIGHT * 2),
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

			scrollingBackground.move(-player.currentPlayerSpeed.x / 4, -player.currentPlayerSpeed.y / 4);
			
			player.update();
			enemiesContainer.update();
			playerCloseToEnemies(enemiesContainer.enemiesArray);

			// character.bumpingKeys = collisionManager.bumpingKeys;
		}

		private function playerCloseToEnemies(enemies:Array):void 
		{
			var distance:Number;

			for(var i:int = 0; i < enemies.length; i++)
			{
				for(var j:int = 0; j < enemies[i].numChildren; j++)
				{
					distance = Point.distance(
						new Point(player.clip.x, player.clip.y),
						new Point(enemies[i].getChildAt(j).x, enemies[i].getChildAt(j).y)
					);

					if (distance < 200) {
						enemiesContainer.shootAtPosition(
							new Point(player.clip.x, player.clip.y),
							enemies[i].getChildAt(j)
						);
					} else {
						enemiesContainer.offAlert(enemies[i].getChildAt(j));
					}
				};
			};
		}

		private function onKeyDown(evt:KeyEvents):void 
		{
			player.move(evt.data);
		}

		private function onKeyUp(evt:KeyEvents):void 
		{
			player.resetMovement(evt.data);
		}
	}
}
