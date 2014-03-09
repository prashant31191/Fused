package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	public class Player extends MovieClip {
		
		var left=false;
		var right=false;
		var up=false;
		var speed=0;
		var fall=0;
		var jump=false;
		public function Player() {
			// constructor code
			
			
			stop();
			addEventListener(Event.ENTER_FRAME,loop);
			
			trace(numChildren)
			
			
			
		}
		
		
		public function fly(){
			
			
			fall-=(fall-30)/5;
			jump=true;
			
		}
		
		public function land(plat:Number){
			
			
			
			
			
			
			if(fall<-20)fall=20;
			
			
			if((plat-y)>(-20)){
				fall=0;
			jump=true;
				y-=(y-plat)/10;
			}
			
		}
		
		
		public function loop(e:Event){
			
			
			
			
			//character movement
				
			if(jump && fall<5 && fall >-5)gotoAndStop(2);
			else if(fall<-5)gotoAndStop(2);
			else gotoAndStop(1);
			if(speed<0)scaleX=1;
			else scaleX=-1;
			
			
			rotation=-speed*2;
			//!!
			if(jump){
				
				
				if(up)fall-=(fall-30),jump=false;
				
			}
			
			y-=fall;
			fall-=(fall+200)/100;
			x-=speed;
			if(left)speed-=(speed-20)/10;
			if(right)speed-=(speed+20)/10;
			if(!left && !right)speed-=speed/5;
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kdown);
			stage.addEventListener(KeyboardEvent.KEY_UP, udown);
			
		}
		
		
		public function kdown(k:KeyboardEvent){
			
			switch(k.keyCode){
				
				case 37://left
				left=true;
				
				break;
				case 38://up
				up=true;
				break;
				case 39://right
				
				right=true;
				break;
				case 32://right
				x=y=0;
				break;
				
			}
			
		}
		
		
		
		public function udown(u:KeyboardEvent){
			
			switch(u.keyCode){
				
				case 37://left
				left=false;
				break;
				case 38://up
				up=false;
				break;
				case 39://right
				right=false;
				break;
				
			}
			
		}
		
	}
	
}
