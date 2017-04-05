package com.plumbee.codetest {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class WordDictionary extends EventDispatcher implements IWordDictionary { // need constructor for getting the parameters

    var a; // Should include access modifier and class. Change with a better name like wordList -> private wordList:Array;

    public function load():void { // What happens on several load attemps? Flow may be controlled by flags.
        var tl = new URLLoader(); // More meaningful name can be selected like listLoader

        tl.addEventListener(Event.COMPLETE, // Listeners should be removed after load. (for memory leaks and flow control) For this purpose a class function may be used rather than an inline function. 
                function onLoaded(e:Event):void { 
                    a = e.target.data.split(/\n/);
                    dispatchEvent(new Event("loaded")); // An enum class should be preferred for the event name -> dispatchEvent(new DictionaryEvent(DictionaryEvent.LOADED)); 
                }
        );

        tl.load(new URLRequest("http://s3.amazonaws.com/codetest.plumbee.com/codetest/wordlist.txt")); // addres must be parametric to be able change later

    }

    public function contains(word:String):Boolean { // Will create an unhandled exception is called before loading complete. Should be handled at least by throwing a controlled exception.
        return a.indexOf(word) >= 0;
    }

    public function size():int { // This function is not used. Better to be removed if this class is not designed for a common library.
        return a.length;
    }

}

}
