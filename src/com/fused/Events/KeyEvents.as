package com.fused.Events
{
    import flash.events.Event;

    public class KeyEvents extends Event
    {
        public static const KEY_DOWN: String = "onKeyDown";
        public static const KEY_UP: String   = "onKeyUp";

        public var data: Object;

        public function KeyEvents(type:String, data: Object, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);

            this.data = data;
        }

        override public function clone():Event
        {
            return new KeyEvents (type, data, bubbles, cancelable);
        }

    }
}
