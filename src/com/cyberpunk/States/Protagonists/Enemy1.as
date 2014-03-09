package com.cyberpunk.States.Protagonists
{
	import flash.display.MovieClip;

    public class Enemy1 extends ProtagonistsBase
    {
    	protected var enemies:Array = ['EnemyType1'];

        public function Enemy1 ()
        {
        	EnemyType1;

        	addChild(new EnemyType1());

            super(new EnemyType1());
        }
    }
}