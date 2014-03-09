package com.cyberpunk.States.Platforms
{
	import flash.display.MovieClip;
	
    public interface IPlatform
    {
        function get _instance()			:MovieClip;	
        function get amountOfBricks()		:Number;	
        function get platformAxis()			:String;	
        function get velocity()				:Number;	
        function get platformTypeName()     :Array; 

        function breakPlatform(targetClip:MovieClip):void;
    }
}