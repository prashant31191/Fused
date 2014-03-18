package  {
	
	import flash.display.MovieClip;
	
	
	public class vision extends MovieClip {
		
		
		
		var t:Array= new Array();
		
		public function vision() {
			// constructor code
			
			
			for(var i:int=0; i<numChildren;i++){
				
				
				if(getChildAt(i) is triangle){
					t.push(getChildAt(i));
				}
				
			}
			
			trace(t.length);
			
		}
	}
	
}
