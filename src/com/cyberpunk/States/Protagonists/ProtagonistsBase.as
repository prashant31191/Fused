package com.cyberpunk.States.Protagonists
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
	import fl.transitions.Tween;
	import fl.motion.easing.Elastic;

    public class ProtagonistsBase extends Sprite
    {
    	protected var currentClip:MovieClip;
    	protected var speed:Point;

        public function ProtagonistsBase (clip:MovieClip)
        {
        	this.currentClip = clip;

        	currentClip.alpha = 1;
        	currentClip.gotoAndStop(1);
        	
            addChild(currentClip);
        }

        public function get clip():MovieClip
		{
			return currentClip;
		}

		public function set playerSpeed(speed:Point):void 
		{
			this.speed = speed;
		}

		public function get currentPlayerSpeed():Point 
		{
			return this.speed;
		}

		public function die():void 
		{
			
		}
    }
}