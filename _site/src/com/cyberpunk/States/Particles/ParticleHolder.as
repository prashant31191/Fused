package com.cyberpunk.States.Particles
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;

    public class ParticleHolder extends Sprite
    {
    	protected var particleArray:Array = [];
		protected var holder:MovieClip;

        public function ParticleHolder (holder:MovieClip)
        {
            this.holder = holder;
        	holder.mouseEnabled = holder.mouseChildren = false;

			addEventListener(Event.ENTER_FRAME, update);
        }

        protected function update(e:Event):void
		{
			updateParticles();
		}

		protected function updateParticles():void
		{
			for (var i:Number = particleArray.length -1; i >= 0; i--)
			{
				particleArray[i].update();

				if (particleArray[i]._lifeSpan <= 0)
				{
					remove(i);
				}
			}
		}

		public function create(lifeSpan:Number, deathRate:Number, clipParams:Object, updateParams:Object):void
		{
			var particleGraphics:Class = holder.loaderInfo.applicationDomain.getDefinition("CharacterParticle") as Class;
			var clip:MovieClip = new particleGraphics() as MovieClip;

			for (var i:String in clipParams)
			{
				clip[i]	= clipParams[i];
			}

			holder.addChild(clip);

			var particle:Particle = new Particle(clip, lifeSpan, deathRate, updateParams);

			add(particle);
		}

		protected function add(particle:Particle):void	
		{
			particleArray.push(particle);
		}

		protected function remove(index:Number):void
		{
			particleArray[index].removeClip();
			particleArray.splice(index, 1);
		}

		public function get _clip():MovieClip
		{
			return holder;
		}
    }
}