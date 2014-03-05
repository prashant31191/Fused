package com.cyberpunk.States.Particles
{
	import flash.display.Sprite;

    public class ParticleHolder extends Sprite
    {
    	protected var particleArray:Array = [];
		protected var holder:MovieClip;

        public function ParticleHolder (holder:MovieClip)
        {
            this.holder = holder;
        	holder.mouseEnabled = holder.mouseChildren = false;

        	
        }
    }
}