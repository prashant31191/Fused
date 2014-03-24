package com.fused.States.Protagonists
{
	import flash.display.MovieClip;
    import flash.events.Event;
    import com.fused.States.Particles.ParticleHolder;
    import flash.external.ExternalInterface;
    import flash.utils.setTimeout;
    import com.fused.Helpers.Utils;
    import flash.geom.Point;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class Enemy1 extends ProtagonistsBase
    {
    	protected var enemies: Array = [ 'EnemyType1' ];
        protected var bulletShot:Boolean = false;
        protected var lookAt:Point;
        protected var lazer:Lazer;
        protected var trueRotation:Number;
        protected var rotateSpeedMax:Number = 20;
        protected var bullets:Array = [];
        protected var _barrelLength:Number = 20;
        protected var _bulletSpread:Number = 5;
        protected var _endX:Number;
        protected var _endY:Number;
        protected var _bulletSpeed:Number = 10;   
        protected var _maxDistance:Number = 100;
        protected var _isLoaded:Boolean = true;       
        protected var _isFiring:Boolean = false;
        protected var _reloadTimer:Timer;
        protected var _reloadSpeed:Number = 250; //milliseconds

        public function Enemy1 ()
        {
        	EnemyType1;

            super(new EnemyType1());
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
            this.lookAt        = lookAt;
            currentClip.scaleX = currentClip.scaleY = 1.2;
            _isFiring = true;

            updateRotation();
            updateBullets();
            fire();
        }

        public function offAlert():void 
        {
            currentClip.scaleX = currentClip.scaleY = 1;
            _isFiring = false;
        }

        private function updateRotation():void 
        {
            var cx:Number;
            var cy:Number; 
            var degrees:Number;

            cx = currentClip.x - lookAt.x;
            cy = currentClip.y - lookAt.y;

            var rotateTo:Number = Utils.getDegrees(Utils.getRadians(cx, cy)); 

            if (rotateTo > currentClip.rotation + 180) rotateTo -= 360;
            if (rotateTo < currentClip.rotation - 180) rotateTo += 360;

            // ease rotation
            trueRotation = (rotateTo - currentClip.rotation) / rotateSpeedMax;

            // update rotation
            currentClip.rotation += trueRotation; 
        }

        /**
         * Creates a bullet movieclip and sets it's properties
         */
        private function createBullet():void
        {
            var pCos:Number;
            var pSin:Number;
            var startX:Number;
            var startY:Number;

            pCos = Math.cos(currentClip.rotation * Math.PI / 180);
            pSin = Math.sin(currentClip.rotation * Math.PI / 180);
            
            // start X & Y
            // calculate the tip of the barrel
            startX = currentClip.x - _barrelLength * pCos;
            startY = currentClip.y - _barrelLength * pSin;
            
            // end X & Y
            // calculate where the bullet needs to go
            // aim 50 pixels in front of the gun
            _endX = currentClip.x - 50 * pCos + Math.random() * _bulletSpread - _bulletSpread * .5;
            _endY = currentClip.y - 50 * pSin + Math.random() * _bulletSpread - _bulletSpread * .5;
            
            // attach bullet from library
            var tempBullet:MovieClip = new Lazer();
            
            // calculate velocity
            tempBullet.vx = (_endX - startX) / _bulletSpeed;
            tempBullet.vy = (_endY - startY) / _bulletSpeed;
            
            // set position
            tempBullet.x = startX;
            tempBullet.y = startY;
            
            // save starting location
            tempBullet.startX = startX;
            tempBullet.startY = startY;
            
            // set maximum allowed travel distance
            tempBullet.maxDistance = _maxDistance;
            
            // add bullet to bullets array
            bullets.push(tempBullet);
            
            // add to display list
            addChild(tempBullet);
        }

        /**
         * Updates bullets
         */
        private function updateBullets():void
        {
            var i:int;
            var tempBullet:MovieClip;
            
            // loop thru _bullets array
            for (i = 0; i < bullets.length; i++)
            {
                // save a reference to current bullet
                tempBullet = bullets[i];
                
                // update bullet position
                tempBullet.x += tempBullet.vx;
                tempBullet.y += tempBullet.vy;
                
                // check if bullet went too far
                if (Utils.getDistance(tempBullet.startX - tempBullet.x, tempBullet.startY - tempBullet.y) > tempBullet.maxDistance + _barrelLength)
                {
                    destroyBullet(tempBullet);
                }
                
                // check for collision with walls
                // if (checkCollisions(tempBullet.x, tempBullet.y))
                // {
                //     destroyBullet(tempBullet);
                // }
            }
        }

        /**
         * Destroys bullet
         * @param   bullet  Takes bullet movieclip
         */
        private function destroyBullet(bullet:MovieClip):void
        {
            var i:int;
            var tempBullet:MovieClip;
            
            // loop thru _bullets array
            for (i = 0; i < bullets.length; i++)
            {
                // save a reference to current bullet
                tempBullet = bullets[i];
                
                // if found bullet in array
                if (tempBullet == bullet)
                {
                    // remove from array
                    bullets.splice(i, 1);
                    
                    // remove from display list
                    bullet.parent.removeChild(bullet);
                    
                    // stop loop
                    return;
                }
            }
        }

        /**
         * Reload weapon
         */
        private function reloadWeapon():void
        {
            _isLoaded = true;
        }

        /**
         * Fire weapon
         */
        private function fire():void
        {

            // check if firing
            if (!_isFiring) return;
            
            // check if reloaded
            if (!_isLoaded) return;

            // create bullet
            createBullet();
            
            // start reload timer
            _reloadTimer = new Timer(_reloadSpeed);
            _reloadTimer.addEventListener(TimerEvent.TIMER, reloadTimerHandler);
            _reloadTimer.start();
            
            // set reload flag to false
            _isLoaded = false;
        }

        /**
         * Reload timer
         * @param   e   Takes TimerEvent
         */
        private function reloadTimerHandler(e:TimerEvent):void 
        {
            // stop timer
            e.target.stop();
            
            _reloadTimer = null;
            
            reloadWeapon();
        }
    }
}
