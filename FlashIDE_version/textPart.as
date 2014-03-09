package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class textPart extends MovieClip {
		
		var timer:int=0;
		
		
		public function textPart(score=10) {
			// constructor code
			enterText.text=score;
			
			addEventListener(Event.ENTER_FRAME,loop);
		}
		
		public function loop(e:Event){
			
			
			
			y-=1;
			alpha-=.06;
			scaleX=scaleY+=.3;
			
			timer++;
			
			if(timer>10){
				
				removeEventListener(Event.ENTER_FRAME,loop);
				parent.removeChild(this);
				
			}
			
			
		}
		
	}
	
}
