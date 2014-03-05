package com.cyberpunk.States.Particles
{
	import flash.display.MovieClip;

    public class Particle 
    {
    	protected var particle:PauseableMovieClip;
		protected var propertiesUpdate:Object;

		protected var lifeSpan:Number  = 0;
		protected var rateDeath:Number = 0;

        public function Particle (clip:MovieClip, lifeSpan:Number, rateDeath:Number, propertiesUpdate:Object)
        {
            this.lifeSpan 			= lifeSpan;
			this.rateDeath 			= rateDeath;
			this.propertiesUpdate 	= propertiesUpdate;
        }

        public function update():void
		{
			lifeSpan = lifeSpan - rateDeath;

			for (var i:String in propertiesUpdate)
			{
				particle.clip[i] += propertiesUpdate[i];
			}

			if (particle.frame < particle.numFrames)
            {
                particle.nextFrame();
            }

            if (particle.frame == particle.numFrames)
            {
            	particle.gotoAndStop(1);
            }
		}

		public function removeClip():void
		{
			particle.clip.parent.removeChild(particle.clip);
		}

		public function get _lifeSpan():Number
		{
			return lifeSpan;
		}
    }
}