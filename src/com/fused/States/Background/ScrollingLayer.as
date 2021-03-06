package com.fused.States.Background
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Zachary Foley
	 */
	public class ScrollingLayer extends Sprite
	{
		protected var bitmapResource:Class;
		protected var scrollingBitmap:BitmapData;
		protected var _parallaxAmount:Number = 1;
		protected var graphPaperBmp:BitmapData;
		protected var canvas:Graphics;
		protected var matrix:Matrix;

		public function ScrollingLayer()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
 
		protected function init(e:Event):void
		{
			matrix = this.transform.matrix.clone();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			canvas = this.graphics;
			drawCanvas();
			stage.addEventListener(Event.RESIZE, handleResize);
		}
 
		protected function handleResize(e:Event):void
		{
			drawCanvas();
		}
 
		public function move(dx:Number, dy:Number):void
		{
			matrix.translate(dx * _parallaxAmount, dy * _parallaxAmount);

			if(dx!=0)
				matrix.tx %= scrollingBitmap.width;
			if(dy!=0)
				matrix.ty %= scrollingBitmap.height;

			drawCanvas();
		}
 
		public function get dy():Number { return matrix.ty; }
 
		public function set dy(value:Number):void
		{
			matrix.ty = value * _parallaxAmount;
			drawCanvas();
		}
 
		protected function drawCanvas():void
		{
			canvas.clear();
			canvas.beginBitmapFill(scrollingBitmap, matrix, true, true);
			canvas.drawRect(stage.x,stage.y,stage.stageWidth, stage.stageHeight);
		}
 
		public function get dx():Number { return matrix.tx; }
 
		public function set dx(value:Number):void
		{
			matrix.tx = value * _parallaxAmount;
			drawCanvas();
		}
 
		public function get parallaxAmount():Number { return _parallaxAmount; }
 
		public function set parallaxAmount(value:Number):void
		{
			_parallaxAmount = value;
		}
 
	}
 
}
