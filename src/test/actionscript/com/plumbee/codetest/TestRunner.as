package com.plumbee.codetest {
	
	import com.plumbee.codetest.AnagramGameTest;
	import flash.display.Sprite;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;

	public class TestRunner extends Sprite
	{
		private var core:FlexUnitCore;
		
		
		public function TestRunner()
		{
			super();
			
			core = new FlexUnitCore();
			core.addListener( new TraceListener() );
			core.run( AnagramGameTest );

		}
	}
}
