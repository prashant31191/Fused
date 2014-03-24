package com.fused.States
{
	import flash.display.Stage;
	import com.fused.Events.KeyEvents;
	import com.fused.Setup.Config;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
    public class Controls 
    {
		private var key:Dictionary;
		private var _stage:Stage;

        public function Controls (_stage:Stage)
        {
			key = new Dictionary();
			this._stage = _stage;

            _stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
        }

       	private function keyDown(evt:KeyboardEvent):void 
		{
			var keyCode:int = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER)
				key['up'] = true;
			else if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				key['down'] = true;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				key['left'] = true;
			else if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				key['right'] = true;

			_stage.dispatchEvent(new KeyEvents(KeyEvents.KEY_DOWN, key));
		}
		
		private function keyUp(evt:KeyboardEvent):void 
		{
			var keyCode:int = evt.keyCode;
			
			if (keyCode == Config.UP_ARROW || keyCode == Config.W_LETTER)
				key['up']  = false;
			else if (keyCode == Config.DOWN_ARROW || keyCode == Config.S_LETTER)
				key['down'] = false;
			if (keyCode == Config.LEFT_ARROW || keyCode == Config.A_LETTER)
				key['left'] = false;
			else if (keyCode == Config.RIGHT_ARROW || keyCode == Config.D_LETTER)
				key['right'] = false;

			_stage.dispatchEvent(new KeyEvents(KeyEvents.KEY_UP, key));
		}
    }
}
