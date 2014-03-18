package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.sensors.Accelerometer;
	import flash.geom.Point;
	
	
	public class Main extends MovieClip {
		
		static var life:Number=350;
		var ship:Ship= new Ship();
		var shipSpeed=0;
		var shipGrav=0;
		
		var pA:Array= new Array();
		var puA:Array= new Array();
		var eA:Array= new Array();
		var tA:Array= new Array();
		
		var elecA:Array= new Array();
		
		var shootTime:int=0;
		
		static var p:Player= new Player();
		
		
		var fog:vision;
		var center:Point= new Point(0,0);
		static var score:Number=0;
		var high:Number=0;
		
		
		public function Main() {
			// constructor code
			addChild(p);
			addChild(ship);
			ship.x=5000;
			
			
			
			
			
			
			
			for(var i:int=0; i<numChildren;i++){
				
				
				if(getChildAt(i) is Plat){
					pA.push(getChildAt(i));
				}
				
				if(getChildAt(i) is platUp){
					puA.push(getChildAt(i));
				}
				
				if(getChildAt(i) is Elec){
					elecA.push(getChildAt(i));
				}
				if(getChildAt(i) is Tur){
					tA.push(getChildAt(i));
				}
				
				
			}
			
			fog = new vision();
			addChild(fog);
			
			addEventListener(Event.ENTER_FRAME, loop)
			
		}
		
		
		public function loop(e:Event){
			
			//score
			scoreText.text="SCORE "+score;
			highText.x=scoreText.x=p.x-300;
			scoreText.y=p.y-230;
			highText.y=p.y-210;
			//highscore
			
			if(high<score)high=score;
			highText.text="SCORE "+high;
			
			
			
			life-=(life-350)/100;
			
			
			
			
			fog.x=p.x;
			fog.y=p.y;
			
			
			shootTime++;
			
			if(shootTime>10){
			var l:Lazer= new Lazer(ship.rotation+90);
			addChild(l);
			l.x=ship.x;
			l.y=ship.y;
			shootTime=0;
			}
			
			//smoke
			/*
			var s:Smoke= new Smoke();
			addChild(s);
			s.x=ship.x;
			s.y=ship.y;
			
			//spacehip
			lookAt(ship,p);
			
			ship.x-=shipSpeed;
			ship.y-=shipGrav;
			
			if(ship.x<p.x)shipSpeed-=(shipSpeed+40)/100;
			if(ship.x>p.x)shipSpeed-=(shipSpeed-40)/100;
			if(ship.y>p.y)shipGrav-=(shipGrav-40)/100;
			if(ship.y<p.y)shipGrav-=(shipGrav+40)/100;
			*/
			//---end!
			
			
			for each( var tr in fog.t){
				
				
				tr.alpha=-1+(hyp(center,tr)/life);//10 min,300 max 
				
				
				
			}
			
			
			//plat
			for each(var tur in tA){
				
				
				if(hyp(p,tur)<300)tur.look(p)
				else tur.t=0;
				
				tur.resetting();
				tur.breaking();
				
				
				if(p.hitTestObject(tur)){
					
					
					if(tur.visible){
						if(p.y<tur.y-20){
						tur.kill=true;
					p.land(tur.y);
					
					sparks();
						}
					}
					
				}
				
				
			}
			
			
			
			
			x=(-p.x+320);
			y=(-p.y+240);
			
			
			if(p.y>2000)damage();
			
			
			
			for(var i:int=0; i<pA.length;i++){
				
				
				pA[i].resetting();
				pA[i].breaking();
				
				
				
				if(p.hitTestObject(pA[i])){
					
					
					if(pA[i].visible){
						pA[i].kill=true;
					p.land(pA[i].y);
					
					sparks();
					
					}
				}
				
			}
			
			//electro box!
			
			for(var k:int=0; k<elecA.length;k++){
				
				elecA[k].resetting();
				if(elecA[k].kill==true){
					
					elecA[k].breaking();
				}
				
				
				
				
				
				
				//
				
				
				if(p.hitTestObject(elecA[k])){
					
					
					
					
					if(elecA[k].visible){
						elecA[k].kill=true;
					p.land(elecA[k].y);
					sparks();
					}
				}
				
				//
				
				
				
				
				
				
			}
			
			
			
			
			
			//plat up!!
			
			for(var j:int=0; j<puA.length;j++){
				
				puA[j].resetting();
				if(puA[j].kill==true){
					
					puA[j].breaking();
				}
				
				if(p.hitTestObject(puA[j])){
					
					
					
					
					if(puA[j].visible){
						puA[j].kill=true;
					p.fly();
					sparks(2);
					}
					
					
					
					
				}
				
			}
			
			
		}
		
		public static function damage(){
			
			life-=(life-5)/10;
			
			
			if(life<60){
				score=0;
				p.x=p.y=0;
				p.fall=0;
				life=300;
			}
			
			
		}
		public static function hyp(obj,obj2):Number{
			var dx=obj.x-obj2.x;//finds hypotenuse
			var dy=obj.y-obj2.y;
			var hyp=Math.sqrt((dx*dx)+(dy*dy));
			return hyp;
		}
		
		public function lookAt(fromObj,toObj){
			
			var cy:Number =  fromObj.y-toObj.y; 
			var cx:Number =  fromObj.x-toObj.x;
			// find out the angle
			var Radians:Number = Math.atan2(cy,cx);
			// convert to degrees to rotate
			var Degrees:Number = Radians * 180 / Math.PI;
			// rotate
			fromObj.rotation = Degrees+90;
			
		}
		
		
		public function moveToRot(obj,speed:Number=2){
			var angle:Number = obj.rotation * Math.PI / 180-90;//- 90 is the right angle
			obj.x = obj.x + speed * Math.cos(angle);
			obj.y = obj.y + speed* Math.sin(angle);
			
		}
		
		public function sparks(type:int=1){
			
			
			var pa:Part= new Part(type);
			addChild(pa);
			pa.x=p.x-15+Math.random()*30
			pa.y=p.y-15+Math.random()*30
			
		}
		
	}
	
}
