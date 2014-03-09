package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Lazer extends MovieClip {
		
		var life:int=0;
		public function Lazer(rot:Number) {
			// constructor code
		rotation=rot;
			addEventListener(Event.ENTER_FRAME, loop);
			
		}
		
		
		public function moveToRot(obj,speed:Number=2){
			var angle:Number = obj.rotation * Math.PI / 180;// is the right angle
			obj.x = obj.x + speed * Math.cos(angle);
			obj.y = obj.y + speed* Math.sin(angle);
			
		}
		public function loop(e:Event){
			
			
			if(this.hitTestObject(Main.p)){
				
				Main.damage();
			}
			
			life++;
			
			if(life>50){
				
				
					parent.removeChild(this);
					removeEventListener(Event.ENTER_FRAME, loop);
			}
			moveToRot(this,10);
			
		}
	}
	
}
