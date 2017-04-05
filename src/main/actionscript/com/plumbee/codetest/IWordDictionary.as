package com.plumbee.codetest {
import flash.events.IEventDispatcher;

public interface IWordDictionary extends IEventDispatcher {

	/**
	 * loads the dictionary
	 */
	function load():void;

    /**
     * @param word
     * @return true if the dictionary contains the word
     */
    function contains(word:String):Boolean;

	/**
	 *
	 * @return number of words in the dictionary
	 */
	function size():int;

}
}
