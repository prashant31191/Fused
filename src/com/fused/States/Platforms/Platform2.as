package com.fused.States.Platforms 
{
	import com.fused.Setup.Config;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Platform2 extends PlatformBase
	{
		protected static const MAX_BRICK:Number  = 10;
		protected static const Y_AXIS:String  	 = 'Y_AXIS';

		protected var platforms:Array = [ 'Platform2Type1', 
										  'Platform2Type2', 
										  'Platform2Type3'
		];

		public function Platform2() 
		{
			Platform2Type1;
			Platform2Type2;
			Platform2Type3;

			super(new PlatformType2(), {amount:MAX_BRICK, axis: Y_AXIS, brick: platforms});
		}

		// override public function breakPlatform():void 
		// {
			
		// }

		// override public function get velocity():Number 
		// {
		// 	return VELOCITY;
		// }

		// override public function get platformTypeName():Array 
		// {
		// 	return platforms;
		// }
	}

}
