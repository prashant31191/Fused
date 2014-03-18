package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Part extends MovieClip {
		
		var t:int=0;
		var xx:int=-10+Math.random()*20;
		var yy:int=-10+Math.random()*20;
		
		public function Part(type:int=1) {
			// constructor code
			gotoAndStop(type)
			addEventListener(Event.ENTER_FRAME, loop);
			scaleX=scaleY=.5+Math.random()*1;
			alpha=.5+Math.random()*.5;
			
		}
		public function loop(e:Event){
			
			x-=xx;
			y-=yy;
			
			
			
			
			
			t++;
			alpha-=.05;
			
			if(t>100){
					
					
					parent.removeChild(this);
					removeEventListener(Event.ENTER_FRAME, loop);
					}
			
			
		}
		
		
	}
	
}
