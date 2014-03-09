package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Wafe extends MovieClip {
		
		
		var timer =0;
		
		public function Wafe() {
			// constructor code
			
			addEventListener(Event.ENTER_FRAME, loop)
			
			
		}
		
		
		public function loop(e:Event){
			
			timer++;
			scaleX=scaleY-=(scaleX-10)/5;
			
			alpha-=.1;
			
		if(timer>50){
			
			
			removeEventListener(Event.ENTER_FRAME, loop)
			parent.removeChild(this);
			
		}
			
			
			
			
		}
	}
	
}
