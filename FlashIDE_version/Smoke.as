package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Smoke extends MovieClip {
		
		var t:int=0;
		var xx:int=-2+Math.random()*5;
		var yy:int=-4+Math.random()*10;
		var rot=Math.random()*10;
		var num:int= 1+Math.round(Math.random()*2)
		
		public function Smoke(type:int=1) {
			// constructor code
			gotoAndStop(num)
			addEventListener(Event.ENTER_FRAME, loop);
			alpha=0;
			scaleX=scaleY=1+Math.random()*2;
			
		}
		public function loop(e:Event){
			
			x-=xx;
			y-=yy;
			rotation+=rot;
			
			scaleX=scaleY-=(scaleX-2)/10;
			
			t++;
			if(alpha<.2)alpha+=.02;
			
			if(t>50)alpha-=.09;
			scaleX=scaleY+=.08;
			if(t>100){
					
					
					parent.removeChild(this);
					removeEventListener(Event.ENTER_FRAME, loop);
					}
			
			
		}
		
		
	}
	
}
