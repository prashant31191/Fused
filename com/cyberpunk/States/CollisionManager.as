package com.cyberpunk.States 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import com.cyberpunk.Setup.Config;
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class CollisionManager 
	{
		private var player:MovieClip;
		private var platforms:Array;
		private var _stage:Stage;
		
		private var leftBumping:Boolean 		= false;
		private var rightBumping:Boolean 	= false;
		private var upBumping:Boolean 		= false;
		private var downBumping:Boolean 	= false;
		
		private var leftBumpPoint:Point 		= new Point(0, 20);
		private var rightBumpPoint:Point 		= new Point(40, 20);
		private var upBumpPoint:Point 		= new Point(20, 0);
		private var downBumpPoint:Point 	= new Point(20, 40);
		
		private var xSpeed:int = 0;
		private var ySpeed:int = 0;
		
		public function CollisionManager(player:MovieClip, platforms:Array, stage:Stage) 
		{
			this.player 		= player;
			this.platforms 	= platforms;
			
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function get speedX():int
		{
			return xSpeed;
		}
		
		public function get speedY():int
		{
			return ySpeed;
		}
		
		private function update(evt:Event):void
		{
			ySpeed = Config.Y_SPEED;
			
			for (var i:int = 0; i < platforms.length; i++) {
				if (platforms[i].hitTestPoint(player.x + leftBumpPoint.x, player.y + leftBumpPoint.y, true)) {
					trace("leftBumping");
					leftBumping = true;
				} else {
					leftBumping = false;
				}
				 
				if (platforms[i].hitTestPoint(player.x + rightBumpPoint.x, player.y + rightBumpPoint.y, true)) {
					trace("rightBumping");
					rightBumping = true;
				} else {
					rightBumping = false;
				}
				 
				if (platforms[i].hitTestPoint(player.x + upBumpPoint.x, player.y + upBumpPoint.y, true)) {
					trace("upBumping");
					upBumping = true;
				} else {
					upBumping = false;
				}
				 
				if (platforms[i].hitTestPoint(player.x + downBumpPoint.x, player.y + downBumpPoint.y, true)) {
					trace("downBumping");
					downBumping = true;
				} else {
					downBumping = false;
				}
					
				if (leftBumping) {
					if (xSpeed < 0) {
						xSpeed *= -0.5;
					}
				}
				 
				if (rightBumping) {
					if (xSpeed > 0) {
						xSpeed *= -0.5;
					}
				}
				 
				if (upBumping) {
					if (ySpeed < 0) {
						ySpeed *= -0.5;
					}
				}
				 
				if (downBumping) {
					if (ySpeed > 0) {
						ySpeed *= -0.5;
					}
				}
			}
		}
	}
}