package com.cyberpunk.States.Platforms
{
	import flash.display.MovieClip;
    import flash.external.ExternalInterface;

	/**
	 * ...
	 * @author LilyDrop
	 */
    public class PlatformBase extends MovieClip implements IPlatform
    {
        protected var clip:MovieClip;
        protected var brickAmount:Number;
        protected var brickAxis:String;

        public function PlatformBase (clip:MovieClip, brick:Object)
        {
            this.clip = clip;

            brickAmount = brick.amount;
            brickAxis   = brick.axis;

            addChild(clip);
        }

        public function breakPlatform(targetClip:MovieClip):void 
        {
            //
        }

        public function get _instance():MovieClip 
        {
            return clip;
        }

        public function get amountOfBricks():Number 
        {
            return brickAmount;
        }

        public function get platformAxis():String 
        {
            return brickAxis;
        }

        public function get velocity():Number 
        {
            return 0;
        }

        public function get platformTypeName():Array 
        {
            return new Array();
        }
    }
}