package com.cyberpunk.States.Protagonists
{
	import flash.display.MovieClip;
    import flash.events.Event;
    import com.cyberpunk.States.Particles.ParticleHolder;
    import flash.external.ExternalInterface;
    import flash.utils.setTimeout;
    import com.cyberpunk.Helpers.Utils;
    import flash.geom.Point;

    public class Enemy1 extends ProtagonistsBase
    {
    	protected var enemies: Array = [ 'EnemyType1' ];
     //    protected var particleHolder:ParticleHolder;
     //    protected var playerPos:Point;

        public function Enemy1 ()
        {
        	EnemyType1;

            super(new EnemyType1());

         //    clip = new EnemyType1();
        	// addChild(clip);
         //    super(clip);

         //    var bulletContainer:MovieClip = new MovieClip();
         //    addChild(bulletContainer);

         //    particleHolder = new ParticleHolder(bulletContainer);

         //    addEventListener(Event.ENTER_FRAME, update);
        }

        public function rotate():void 
        {
            currentClip.rotation = Math.random() * 360;
            currentClip.alpha    = 0.5 + Math.random() * 0.2;

            currentClip.mLight.alpha    = Math.random() * 0.5;
            currentClip.mLight.rotation = Math.random() * 360;
            currentClip.mLight.scaleX   = clip.mLight.scaleY = Math.random() * 1;
        }

        public function changeBehaviour(lookAt:Point):void 
        {
            var cx:Number;
            var cy:Number; 
            var degrees:Number;

            cx = currentClip.x - lookAt.x;
            cy = currentClip.y - lookAt.y;

            degrees = Math.atan2(cy, cx) * 180 / Math.PI;
            currentClip.rotation = degrees + 90;
            currentClip.scaleX   = currentClip.scaleY = 1.2;
        }

        public function offAlert():void 
        {
            currentClip.scaleX = currentClip.scaleY = 1;
        }

        // public function update(e:Event):void 
        // {
        //     rotateEnemy();
        //     setTimeout(function(){shoot()}, 2000); 
        // }

        // public function set playerPosition(playerPos:Point):void 
        // {
        //     this.playerPos = playerPos;
        // }

        // protected function rotateEnemy():void 
        // {
        //     clip.rotation = Math.random() * 360;
        //     clip.alpha = 0.5 + Math.random() * 0.2;

        //     clip.mLight.alpha = Math.random() * 0.5;
        //     clip.mLight.rotation = Math.random() * 360;
        //     clip.mLight.scaleX = clip.mLight.scaleY = Math.random() * 1;
        // }

        // public function shoot():void 
        // {
        //     var scaleRandomNbr:Number = Utils.getRandomInt(0.5, 1);
        //     var test:Number = Utils.getRandomInt(-20, 20);


        //     // particleHolder.create(new Lazer(), 1000, 10, {
        //     //     x: clip.x,
        //     //     y: clip.y,
        //     //     scaleX: scaleRandomNbr,
        //     //     scaleY: scaleRandomNbr
        //     // } ,{
        //     //     x: playerPos.x - clip.x, 
        //     //     y: playerPos.y - clip.y
        //     // });
        // }
    }
}