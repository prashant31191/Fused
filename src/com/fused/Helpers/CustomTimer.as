package com.fused.Helpers
{
	import flash.display.Sprite;
	import flash.events.Event;
    import flash.utils.getTimer;
    import flash.external.*;
    import flash.external.ExternalInterface;
    
    public class CustomTimer extends Sprite
    {
        private var running:Boolean;
    	private var timeElapsed:Number;
        private var endTime:Number;
        private var completed:Boolean;

        private var startTime:Number;
        private var lastTime:Number;

        public function CustomTimer(endTime:Number = 1)
        {
            this.endTime = endTime * 1000;
            timeElapsed = 0;
            running = false;
            completed = false;
        }

        public function getTimeProgress():Number
        {
            return timeElapsed / endTime;
        }

        public function start():void 
        {
            if(!running)
            {
            	running = true;
                startTime = getTimer();
                lastTime = startTime;
                timeElapsed = 0;

            	addEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
        }

        public function reset():void
        {
            running = false;
            timeElapsed = 0;
            lastTime = 0;
            completed = false;
            stop();
        }

        public function stop():void
        {
            running = false;
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(e:Event):void
        {
            update();
        }

        protected function complete():void
        {
            running = false;
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            completed = true;

            dispatchEvent(new Event(Event.COMPLETE));
        }

        protected function update():void 
        {
            var timeNow:Number = getTimer();
            var delta:Number = timeNow - lastTime;

            timeElapsed += delta;

            if(timeElapsed >= endTime)
            {
                complete();
            }

            lastTime = timeNow;
        }
    }
}
