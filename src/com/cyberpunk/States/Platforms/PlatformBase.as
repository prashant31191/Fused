package com.cyberpunk.States.Platforms
{
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author LilyDrop
	 */
    public class PlatformBase extends MovieClip
    {
        public function PlatformBase (clip:MovieClip)
        {
            addChild(clip);
        }

        public function lightOff():void 
        {
            
        }

    }
}