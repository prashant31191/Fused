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
	
    public class EnemiesContainer 
    {
    	protected var player:MovieClip;
    	protected var enemy:MovieClip;
    	protected var enemyArray:Array;
    	protected var savedCheckedEnemy:Array;
    	protected var randomEnemies:int;
		protected var savedPlayerPos:Point;
		protected var enemies:Array;

        public function EnemiesContainer (clip:MovieClip, player:MovieClip)
        {
        	enemy = clip;
        	this.player = player;

        	enemyArray = new Array();
        	savedCheckedEnemy = new Array();

        	enemies = [ {packageName: 'com.cyberpunk.States.Protagonists.Enemy1', type: 'Enemy1'} ];

			savedPlayerPos = new Point(player.x, player.y);

        	var addingEnemy:Rectangle = new Rectangle(
				((player.x + (player.width / 2)) - (Config.STAGE_WIDTH / 2)) - Config.STAGE_WIDTH,
				((player.y + (player.height / 2)) - (Config.STAGE_HEIGHT / 2)) - Config.STAGE_HEIGHT,
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT * 3
			);

			randomEnemies = Utils.getRandomInt(Config.MIN_ENEMY, Config.MAX_ENEMY);

			// Need a check against platforms
			for (var i:int = 0; i < randomEnemies; i++) 
			{
				var currentEnemy:MovieClip = generateEnemies(addingEnemy);
				enemy.addChild(currentEnemy);
			}
        }

        public function update():void
		{
			if (player.y >= savedPlayerPos.y + Config.STAGE_HEIGHT) {
				savedPlayerPos.y = player.y;
				addEnemies();
			} else if (savedPlayerPos.y - Config.STAGE_HEIGHT >= player.y) {
				savedPlayerPos.y = player.y;
				removeEnemies();
			}
		}

        private function generateEnemies(rect:Rectangle):MovieClip
		{
			var randomPoint:Point = new Point(
				Utils.getRandomInt(
					rect.x,
					rect.x + rect.width
				),
				Utils.getRandomInt(
					rect.y,
					rect.y + rect.height
				)
			);

			Enemy1;

			var currentIndexPos:int   = int(Math.random() * enemies.length);
			var ClassReference:Class  = getDefinitionByName(enemies[currentIndexPos].packageName) as Class;
			var currentClip:MovieClip = new ClassReference();

			currentClip.x = randomPoint.x;
			currentClip.y = randomPoint.y;

			// enemyClip.addChild(currentClip);
			savedCheckedEnemy.push(currentClip);

			return currentClip;
		}

		private function addEnemies():void 
		{
			var addEnemyRect:Rectangle = new Rectangle(
				(player.x + (player.width / 2)) - Config.STAGE_WIDTH - (Config.STAGE_WIDTH / 2),
				(player.y + (player.height * 2)) + Config.STAGE_HEIGHT,
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT
			);

			for (var i:int = 0; i < randomEnemies; i++) 
			{
				var currentClip:MovieClip = generateEnemies(addEnemyRect);
				enemy.addChild(currentClip);
			}
		}

		private function removeEnemies():void 
		{
			var removeEnemyRect:Rectangle = new Rectangle(
				(player.x + (player.width / 2)) - Config.STAGE_WIDTH - (Config.STAGE_WIDTH / 2),
				player.y - (Config.STAGE_HEIGHT * 2),
				Config.STAGE_WIDTH * 3,
				Config.STAGE_HEIGHT
			);
			
			for (var i:int = 0; i < savedCheckedEnemy.length; i++) {
				if (removeEnemyRect.contains(savedCheckedEnemy[i].x, savedCheckedEnemy[i].y)) {
					if (savedCheckedEnemy[i]) enemy.removeChild(savedCheckedEnemy[i]);
				}
			}

			savedCheckedEnemy = new Array();
		}
    }
}