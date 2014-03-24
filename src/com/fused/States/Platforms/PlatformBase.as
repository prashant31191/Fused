package com.fused.States.Platforms
{
	import flash.display.MovieClip;
    import flash.external.ExternalInterface;
    import flash.display.Sprite;

	/**
	 * ...
	 * @author LilyDrop
	 */
    public class PlatformBase extends Sprite implements IPlatform
    {
        protected var currentClip:MovieClip;
        protected var brickAmount:Number;
        protected var brickAxis:String;
        protected var brickType:Array;

        public function PlatformBase (clip:MovieClip, brick:Object)
        {
            this.currentClip = clip;

            brickAmount = brick.amount;
            brickAxis   = brick.axis;
            brickType   = brick.brick;
        }

        public function get clip():MovieClip 
        {
            return currentClip;
        }

        public function get numBricksPerPlatform():Number 
        {
            return brickAmount;
        }

        public function get numBricksTypePerPlatform():Number 
        {
            return brickType.length;
        }

        public function get brickArray():Array 
        {
            return brickType;
        }

        public function get brickAxisForPlatform():String 
        {
            return brickAxis;
        }

        // public function get velocity():Number 
        // {
        //     return 0;
        // }

        // public function get platformTypeName():Array 
        // {
        //     return new Array();
        // }
    }
}
