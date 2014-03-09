package  {
	
	import flash.display.MovieClip;
	
	
	public class Tur extends MovieClip {
		
		var t:int=0;
		
		
		
		var kill=false;
		var posY=y;
		
		var timer:int=0;
		var rtimer=0;
		
		var spawnN=1;
		
		
		
		
		
		
		public function Tur() {
			// constructor code
		}
		
		
		public function inside(obj){
			
			
			obj.alpha=Math.random()*.5;
			obj.rotation=Math.random()*360;
			obj.scaleX=obj.scaleY=Math.random()*1;
			
			
		}
		
		public function rotate(obj){
			
			obj.rotation=Math.random()*360;
			obj.alpha=.5+Math.random()*.2;
		}
		
		
		public function look(toObj){
			
			
			inside(light);
			inside(light2);
			inside(light3);
			rotate(inart);
			
			
			
			var cy:Number =  y-toObj.y; 
			var cx:Number =  x-toObj.x;
			// find out the angle
			var Radians:Number = Math.atan2(cy,cx);
			// convert to degrees to rotate
			var Degrees:Number = Radians * 180 / Math.PI;
			// rotate
			rotation = Degrees+90;
			
			scaleX=scaleY-=(scaleX-1)/10;
			
			
			t++;
			if(t>20 && visible){
				scaleX=scaleY=1.2;
			var l:Lazer= new Lazer(rotation+90);
			parent.addChild(l);
			l.x=this.x;
			l.y=this.y;
			t=0;
			}
			
		}
		
		public function resetting(){
			
			
			if(!kill){
				rtimer++;
				
				if(rtimer>200){
					y=posY;
					kill=false;
					visible=true;
					rtimer=0;
					spawnN=1;
					
				}
				
				
			}
			
			
		}
		
		public function breaking(){
			
			
			
			if(kill){
				timer++;
			y=posY+Math.random()*10;
			
			if(timer>3){
				
				while(spawnN>0){
				
				var b:Wafe= new Wafe();
				parent.addChild(b);
				b.x=x;
				b.y=y;
				spawnN--;
				}
				
				
				
				
				
				kill=false;
				visible=false;
				timer=0;
				Main.score+=500
				addScore(500);
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
