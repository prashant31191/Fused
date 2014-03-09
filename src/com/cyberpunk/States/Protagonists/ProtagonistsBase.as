package com.cyberpunk.States.Protagonists
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
	import fl.transitions.Tween;
	import fl.motion.easing.Elastic;

    public class ProtagonistsBase extends MovieClip
    {
    	protected var clip:MovieClip;
    	protected var speed:Point;

        public function ProtagonistsBase (clip:MovieClip)
        {
        	this.clip = clip;
        }

        public function get playerClip():MovieClip
		{
			return clip;
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