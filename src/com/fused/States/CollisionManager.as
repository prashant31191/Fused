package com.fused.States 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import com.fused.Setup.Config;
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	import flash.geom.Rectangle;
	import com.fused.States.Protagonists.Character;
	import flash.utils.getQualifiedClassName;
	import com.fused.States.Particles.ParticleHolder;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import flash.utils.getTimer;

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class CollisionManager 
	{
		// private var platforms:Array;
		// private var bumping:Dictionary;
		// private var test:MovieClip;
		// private var brickRemoval:Array;
		// private var platformName:Array;
		// private var brickTween:TweenLite;
		// private var saveCurrentBrick:MovieClip;
		// private var startTime:int;
		
		// private var leftBumpPointArray:Array = [
		// 	new Point(-18, -3),
		// 	new Point(-12.6, 7.4),
		// 	new Point(-6, -16)
		// ];

		// private var rightBumpPointArray:Array = [
		// 	new Point(14.5, -10),
		// 	new Point(19.2, -2.1),
		// 	new Point(8.8, 11.5)
		// ];

		// private var upBumpPointArray:Array = [
		// 	new Point(-2.9, -23.4)
		// ];

		// private var downBumpPointArray:Array = [
		// 	new Point(1.6, 29.1)
		// ];

		// private var directionArray:Array = [
		// 	{array: leftBumpPointArray,  direction:'left'}, 
		// 	{array: rightBumpPointArray, direction:'right'}, 
		// 	{array: downBumpPointArray,  direction:'down'}, 
		// 	{array: upBumpPointArray,    direction:'up'}
		// ];
		
		// private var speed:Point;
		
		// public function CollisionManager() 
		// {
		// 	this.test = test;
		// 	bumping = new Dictionary();
		// }

		// public function set playerSpeed(speed:Point):void 
		// {
		// 	this.speed = speed;
		// }

		// public function set platformsArray(platforms:Array):void 
		// {
		// 	this.platforms = platforms;
		// }

		// public function get bumpingKeys():Dictionary 
		// {
		// 	return this.bumping;
		// }

		// public function set platformsName(platformName:Array):void 
		// {
		// 	this.platformName = platformName;
		// }
		
		// public function update(player:Character):void
		// {
		// 	for (var key:String in bumping) 
		// 	{
		// 		bumping[key] = false;
		// 	}

		// 	for (var i:int = 0; i < platforms.length; i++) 
		// 	{
		// 		for( var z:int = 0; z < directionArray.length; z++ )
		// 		{

		// 			for(var m:int = 0; m < platforms[i].clip.numChildren; m++)
		// 			{
		// 				checkCollision(directionArray[z].array, directionArray[z].direction, player, platforms[i], platforms[i].clip.getChildAt(m));
		// 				// checkBrickCollision(directionArray[z].array, platforms[i].clip.getChildAt(m), player);
		// 			};
		// 		};
		// 	}
		// }

		// private function checkCollision(currentArray:Array, currentDirection:String, player:Character, currentPlatform:Object, brick:MovieClip):void 
		// {
		// 	var playerMc:MovieClip = player.playerClip;
		// 	var playerSpeed:Point  = player.currentPlayerSpeed;

		// 	if (brick.hitTestObject(playerMc)) {
		// 		// ExternalInterface.call('console.log', (playerMc.y - playerSpeed.y));
		// 		if ((brick.y - (playerMc.y - playerSpeed.y)) > -20) {
		// 			bumping['down'] = true;
		// 			currentPlatform.platform.breakPlatform(brick);
		// 		}
		// 		var platformRegex:RegExp = /(.*?)::/;
		// 		var platformClassName:String = getQualifiedClassName(currentPlatform.platform);
		// 		var currentPlatformName:String = platformClassName.replace(platformRegex, "");
		// 		if (currentPlatformName == 'Platform2') {
		// 			bumping['up'] = true;
		// 		}
		// 	}
		// }


		// private function checkBrickCollision(currentArray:Array, currentBrick:MovieClip, player:Character):void 
		// {
		// 	var playerMc:MovieClip = player.playerClip;
		// 	var playerSpeed:Point  = player.currentPlayerSpeed;

		// 	brickRemoval = new Array();

		// 	for(var m:int = 0; m < currentArray.length; m++)
		// 	{
		// 		var playerPos:Point = new Point((playerMc.x + playerSpeed.x) + (currentArray[m].x + 10), (playerMc.y + playerSpeed.y) + (currentArray[m].y + 10));
		// 		playerPos = playerMc.parent.localToGlobal(playerPos);

		// 		if (currentBrick.hitTestObject(playerMc)) {
		// 			startTime = getTimer();
		// 		// if (currentBrick.hitTestPoint(playerPos.x, playerPos.y, true)) {
		// 			// After 1 second
		// 			if (currentBrick != saveCurrentBrick) {
		// 			}
		// 			// currentBrick.parent.removeChild(currentBrick);
		// 			// if (currentBrick != saveCurrentBrick) {
		// 			// 	brickTween = new TweenLite(currentBrick, 0.2, {alpha: 0, visible:false, y: currentBrick.y - 1});
		// 			// }
		// 			saveCurrentBrick = currentBrick;

		// 			// ParticleHolder.
		// 			// brickRemoval.push({platformType: currentBrick.parent, clip: currentBrick});
		// 		}
		// 	};
		// }
	}
}
