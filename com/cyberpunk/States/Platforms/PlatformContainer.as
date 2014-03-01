package com.cyberpunk.States.Platforms 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class PlatformContainer extends Sprite
	{
		private var typeA:PlatformTypeA;
		private var typeB:PlatformTypeB;
		private var typeC:PlatformTypeC;
		
		public function PlatformContainer() 
		{
			typeA = new PlatformTypeA();
			typeA.x = 0;
			typeA.y = 300;
			addChild(typeA);
		}
		
	}

}