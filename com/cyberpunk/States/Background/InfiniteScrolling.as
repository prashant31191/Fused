package com.cyberpunk.States.Background 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import com.cyberpunk.Setup.Config;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class InfiniteScrolling extends Sprite
	{
		private var direction:Array = [];
		private var background:Dictionary;
		private var currentBackground:InfiniteBackground;
			
		public function InfiniteScrolling() 
		{
			background = new Dictionary();
			direction  = ['NW', 'N', 'NE', 'W', 'O', 'E', 'SW', 'S', 'SE'];

			for( var i:int = 0; i < direction.length; i++ )
			{
				background[direction[i]] = new InfiniteBackground();
				addChild(background[direction[i]]);
			};

			background['O'].x  = 0;
			background['O'].y  = 0;
			background['W'].x  = background['O'].x - background['W'].width;
			background['W'].y  = 0;
			background['E'].x  = background['O'].x + background['O'].width;
			background['E'].y  = 0;
			background['N'].x  = 0;
			background['N'].y  = background['O'].y - background['N'].height;
			background['NE'].x = background['O'].x + background['O'].width;
			background['NE'].y = background['O'].y - background['NE'].height;
			background['NW'].x = background['O'].x - background['NW'].width;
			background['NW'].y = background['O'].y - background['NE'].height;
		
			currentBackground = background['O'];
		}
		
		public function update(playerPoint:Point, playerSpeed:Point):void
		{
			scroll(playerPoint, playerSpeed);
		}
		
		private function scroll(playerPoint:Point, playerSpeed:Point):void
		{
			if (playerPoint.y >= (Config.STAGE_HEIGHT * 2) && currentBackground == background['O']) {
				background['S'].x = background['O'].x;
				background['S'].y = background['O'].y + background['S'].height;
				currentBackground = background['S'];
			} else if (playerPoint.y >= (Config.STAGE_HEIGHT * 4) && currentBackground == background['S']) {
				background['O'].x = background['S'].x;
				background['O'].y = background['S'].y + background['S'].height;
			}
		}
	}
}
