package  {
	
	import flash.display.MovieClip;
	
	
	public class platUp extends MovieClip {
		
		
		var kill=false;
		var posY=y;
		
		var timer:int=0;
		var rtimer=0;
		
		var spawnN=10;
		
		var num:int= Math.round(1+Math.random()*3);
		public function platUp() {
			// constructor code
			gotoAndStop(num);
			
		}
		
		
		public function resetting(){
			
			if(!kill){
				rtimer++;
				
				if(rtimer>200){
					
					kill=false;
					visible=true;
					rtimer=0;
					spawnN=10;
					y=posY;
					
				}
				
				
			}
			
			
		}
		
		public function breaking(){
			
			
			
			if(kill){
				timer++;
			y=posY+Math.random()*10;
			
			if(timer>3){
				
				while(spawnN>0){
				
				var b:blockPart2= new blockPart2();
				parent.addChild(b);
				b.x=x+(-50)+Math.random()*100;
				b.y=y;
				spawnN--;
				}
				
				
				kill=false;
				visible=false;
				timer=0;
				Main.score+=50
				addScore(50);
			}
			
			}
		}
		
		
		public function addScore(num:int=10){
			
			
			var s:textPart= new textPart(num);
			parent.addChild(s);
			s.x=x;
			s.y=y;
			
		}
		
	}
	
}
