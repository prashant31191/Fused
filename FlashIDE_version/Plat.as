package  {
	
	import flash.display.MovieClip;
	
	
	public class Plat extends MovieClip {
		
		
		var kill=false;
		var posY=y;
		
		var timer:int=0;
		var rtimer=0;
		
		var spawnN=5;
		
		
		var type=1+Math.round(Math.random()*2)
		
		var num:int= Math.round(1+Math.random()*3);
		
		
		
		
		public function Plat() {
			// constructor code
			gotoAndStop(num);
			
		}
		
		
		public function resetting(){
			
			if(type==1){
			blue_block_light.alpha=.5+Math.random()*.5;
			}
			
			else if(type==2){
				blue_block_light.alpha=1;
				
			}
			else if(type==3){
				  
				  blue_block_light.alpha=.2;
				  
				  }
			if(!kill){
				rtimer++;
				
				if(rtimer>200){
					y=posY;
					kill=false;
					visible=true;
					rtimer=0;
					spawnN=5;
					
				}
				
				
			}
			
			
		}
		
		public function breaking(){
			
			
			
			if(kill){
				timer++;
			y=posY+Math.random()*10;
			
			if(timer>20){
				
				while(spawnN>0){
				
				var b:BlockPart= new BlockPart();
				parent.addChild(b);
				b.x=x;
				b.y=y;
				spawnN--;
				}
				
				
				kill=false;
				visible=false;
				timer=0;
				Main.score+=10
				addScore(10);
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
