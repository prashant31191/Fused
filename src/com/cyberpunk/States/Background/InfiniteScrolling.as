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
	public class InfiniteScrolling extends ScrollingLayer
	{
		[Embed(source = '../../../../../img/starfield.jpg')]
		private var bitmapClass:Class
			
		public function InfiniteScrolling() 
		{
			scrollingBitmap = new bitmapClass().bitmapData;
		}
	}
}
