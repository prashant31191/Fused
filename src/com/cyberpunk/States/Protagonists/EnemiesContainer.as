package com.cyberpunk.States.Protagonists
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import com.cyberpunk.Setup.Config;
	import com.cyberpunk.Helpers.Utils;
	import flash.utils.getDefinitionByName;
	import flash.geom.Point;
	import com.cyberpunk.Helpers.CustomTimer;
	import flash.utils.setTimeout;
	import flash.events.Event;
	import com.cyberpunk.States.Particles.ParticleHolder;

    public class EnemiesContainer extends Sprite
    {
    	protected var enemyContainer:MovieClip;
    	protected var savedCheckedEnemy:Array;
		protected var enemies:Array;
		protected var platforms:Array;
		protected var enemy:*;
		protected var lookAt:Point;
		protected var currentEnemies:Array = [];

        public function EnemiesContainer ()
        {
        	enemies = [ {packageName: 'com.cyberpunk.States.Protagonists.Enemy1', type: 'Enemy1'} ];

        	Enemy1;

			enemyContainer    = new MovieClip();
			savedCheckedEnemy = new Array();

			addChild(enemyContainer);
        }

        public function set savedPlatforms(platforms:Array):void 
		{
			this.platforms = platforms;
		}

		public function get enemiesArray():Array 
		{
			return savedCheckedEnemy;
		}

        public function addEnemies(newArea:Rectangle, numEnemies:Number):void 
		{
			for(var i:int = 0; i < numEnemies; i++)
			{
				var currentEnemy:Sprite = createEnemy(newArea);
				if (!hasPlatformCollided(currentEnemy) && !hasEnemyCollided(currentEnemy)) 
					enemyContainer.addChild(currentEnemy);
			};
		}

		public function removeEnemies(oldArea:Rectangle):void 
		{
			for (var i:int = 0; i < savedCheckedEnemy.length; i++) {
				if (oldArea.contains(savedCheckedEnemy[i].x, savedCheckedEnemy[i].y)) {
					if (savedCheckedEnemy[i]) removeChild(savedCheckedEnemy[i]);
				}
			}

			savedCheckedEnemy = new Array();
		}

		public function update():void 
		{
			for(var m:int = 0; m < savedCheckedEnemy.length; m++)
			{
				for(var z:int = 0; z < savedCheckedEnemy[m].numChildren; z++)
				{
					savedCheckedEnemy[m].getChildAt(z).rotate();
				};
			};
		}

		public function shootAtPosition(lookAt:Point, currentEnemy:*):void 
		{
			this.lookAt = lookAt;
			currentEnemies.push(currentEnemy);
			addEventListener(Event.ENTER_FRAME, updateEnemiesBehaviour);
		}

		public function offAlert(currentEnemy:*):void 
		{
			currentEnemy.offAlert();
		}

		private function updateEnemiesBehaviour(e:Event):void 
		{
			for(var i:int = 0; i < currentEnemies.length; i++)
			{
				currentEnemies[i].changeBehaviour(lookAt);
			};

			currentEnemies = new Array();
			removeEventListener(Event.ENTER_FRAME, updateEnemiesBehaviour);
		}

		private function createEnemy(newArea:Rectangle):MovieClip 
		{
			// Pick a random position inside the given rectangle
			var randomSinglePlatformPosition:Point = new Point(
				Utils.getRandomInt(
					newArea.x,
					newArea.x + newArea.width
				),
				Utils.getRandomInt(
					newArea.y,
					newArea.y + newArea.height
				)
			);

			// // Pick a random enemy type
			var currentIndex:int = int(Math.random() * enemies.length);
			var ClassReference:Class = getDefinitionByName(enemies[currentIndex].packageName) as Class;

			// // Store the current enemy type
			enemy = new ClassReference();
			var newEnemy:MovieClip = new MovieClip();

			enemy.x = randomSinglePlatformPosition.x;
			enemy.y = randomSinglePlatformPosition.y;

			newEnemy.addChild(enemy);
			return newEnemy;
		}

		private function hasPlatformCollided(currentEnemy:Sprite):Boolean 
		{
			var rect:Rectangle = currentEnemy.getRect(currentEnemy.parent);
			rect.inflate(40, 40);

			for(var z:int = 0; z < platforms.length; z++)
			{
				var rect2:Rectangle = platforms[z].getRect(platforms[z].parent);
				if (rect.intersects(rect2)) return true;
			};

			return false;
		}

		private function hasEnemyCollided(currentEnemy:Sprite):Boolean 
		{
			var rect:Rectangle = currentEnemy.getRect(currentEnemy.parent);
			rect.inflate(40, 40);

			for(var z:int = 0; z < savedCheckedEnemy.length; z++)
			{
				var rect2:Rectangle = savedCheckedEnemy[z].getRect(savedCheckedEnemy[z].parent);
				if (rect.intersects(rect2)) return true;
			};

			savedCheckedEnemy.push(currentEnemy);
			return false;
		}
    }
}