package com.fused.States.Protagonists
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
    import com.fused.Helpers.Utils;
    import com.fused.Setup.Config;
    import com.fused.States.Particles.ParticleHolder;
    import flash.utils.Dictionary;
    import flash.external.ExternalInterface;

    public class Player extends ProtagonistsBase
    {
        private var particleHolder:ParticleHolder;
        private var keyObject:Object;

        public function Player (clip:MovieClip)
        {
            particleHolder = new ParticleHolder(clip);

			super(clip);
        }

        public function generateParticles():void 
        {
            // Lazer;
            
            // particleHolder.create(
            //     'Lazer',
            //     2000, 
            //     30, { 
            //         x: clip.x, 
            //         y: clip.y
            //     }, { 
            //         x: Utils.getRandomInt(-1, 1), 
            //         y: Utils.getRandomInt(-1, 1) 
            //     }
            // );
        }

        public function update():void
        {
            calculateSpeed();

            clip.x += speed.x;
            clip.y += speed.y;
        }

        public function move(keyObject:Object):void 
        {
            this.keyObject = keyObject;
        }

        public function resetMovement(keyObject:Object):void 
        {
            this.keyObject = keyObject;
        }

        private function calculateSpeed():void 
        {
            speed.x = 0;

            if (keyObject) {
                if (keyObject['left']) {
                    speed.x = -Config.X_SPEED;
                }
                else if (keyObject['right']) {
                    speed.x = Config.X_SPEED;
                }
            }
        }
    }
}
