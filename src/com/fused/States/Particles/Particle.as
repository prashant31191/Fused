package com.fused.States.Particles
{
	import flash.display.MovieClip;

    public class Particle 
    {
    	protected var particle:MovieClip;
		protected var propertiesUpdate:Object;

		protected var lifeSpan:Number  = 0;
		protected var rateDeath:Number = 0;

        public function Particle (clip:MovieClip, lifeSpan:Number, rateDeath:Number, propertiesUpdate:Object)
        {
        	particle = clip;
        	
            this.lifeSpan 			= lifeSpan;
			this.rateDeath 			= rateDeath;
			this.propertiesUpdate 	= propertiesUpdate;
        }

        public function update():void
		{
			lifeSpan = lifeSpan - rateDeath;

			for (var i:String in propertiesUpdate)
			{
				particle[i] += propertiesUpdate[i];
			}

			if (particle.currentFrame < particle.totalFrames)
                particle.nextFrame();

            if (particle.currentFrame == particle.totalFrames)
            	particle.gotoAndStop(1);
		}

		public function removeClip():void
		{
			particle.parent.removeChild(particle);
		}

		public function get _lifeSpan():Number
		{
			return lifeSpan;
		}
    }
}
