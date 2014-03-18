package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class BlockPart extends MovieClip {
		
		
		var num:int=1+Math.round(Math.random()*3);
		var speedx=-5+Math.random()*10;
		var speedy=-5+Math.random()*10;
		
		var grav=0;
		var fade=.02;
		var rot:Number=-10+Math.random()*20;
		
		var timer=0;
		
		
		public function BlockPart() {
			// constructor code
			
			gotoAndStop(num);
			rotation=Math.random()*360;
			scaleX=scaleY=.5+Math.random()*1;
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		
		public function loop(e:Event){
			
			
			timer++;
			
			x-=speedx;
			y-=speedy+grav;
			
			rotation-=rot;
			grav-=.5;
			
			alpha-=fade;
			if(timer>40){
				
				removeEventListener(Event.ENTER_FRAME, loop);
				parent.removeChild(this);
			}
		}
	}
	
}
