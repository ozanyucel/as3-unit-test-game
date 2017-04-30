package com.codetest {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class WordDictionary extends EventDispatcher implements IWordDictionary {

    private var wordList:Array;

    public function load():void { 
        var listLoader:URLLoader = new URLLoader(); 

        listLoader.addEventListener(Event.COMPLETE,
                function onLoaded(e:Event):void { 
					listLoader.addEventListener(Event.COMPLETE, onLoaded);
                    wordList = e.target.data.split(/\n/);
                    dispatchEvent(new Event("loaded"));
                }
        );

        listLoader.load(new URLRequest("data/wordlist.txt"));

    }

    public function contains(word:String):Boolean {
        return wordList.indexOf(word) >= 0;
    }

    public function size():int { 
        return wordList.length;
    }
}

}
