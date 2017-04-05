package com.plumbee.codetest
{
	import flash.events.Event;

public class AnagramGame implements IAnagramGame
{
	static private const POINTS_PER_LETTER:Number = 1;
	static public const MAX_NUM_OF_HIGH_SCORES:int = 10;
	
	private var _dictionary:IWordDictionary;
	private var _baseWord:String;
	private var _ready:Boolean;			// ready flag is better to be in worddictionary class. check it from there.
	private var _wordsToSubmit:Array;
	private var _highScoreList:Array;

	public function AnagramGame(baseWord : String, dictionary : IWordDictionary) // input control (regular expressions, to be sure it is lowercase, no whitespace, no special characters)
	{
		_ready = false;
		
		_baseWord = baseWord;
		_dictionary = dictionary;
		
		_wordsToSubmit = new Array();
		_highScoreList = new Array();
		
		_dictionary.addEventListener("loaded", onDictionaryLoaded); // load may be triggered internally after submit word
	}
	
	/**
	 * 
	 * @param	e
	 */
	private function onDictionaryLoaded(e:Event):void 
	{
		_dictionary.removeEventListener("loaded", onDictionaryLoaded);
		
		for (var i:int = 0; i < _wordsToSubmit.length; i++) {
			processSubmit(_wordsToSubmit[i]);
		}
		
		_wordsToSubmit.length = 0;
		
		_ready = true;
	}

	/**
	 * @inheritDoc
	 * @param word
	 */
	public function submitWord(word : String) : void  // input control (regular expressions, to be sure it is lowercase, no whitespace, no special characters)
	{
		if (!isValidInBaseWord(word))
			return;
		
		if (!_ready)
			_wordsToSubmit.push(word);
		else processSubmit(word);
	}
	
	/**
	 * 
	 * @param	word
	 */
	private function processSubmit(word:String):void  // input control (regular expressions, to be sure it is lowercase, no whitespace, no special characters)
	{
		var score:int = getScoreForWord(word);
		if (score == 0)
			return;

		addNewHighScore(word, score);
	}
	
	/**
	 * 
	 * @param	newWord
	 * @param	newScore
	 */
	private function addNewHighScore(newWord:String, newScore:int):void 
	{
		for (var i:int = 0; i < _highScoreList.length; i++) {
			var oldScoreInfo:HighScoreInfo = _highScoreList[i];
			if (newScore > oldScoreInfo.score)
				break;
		}
		
		_highScoreList.splice(i, 0, new HighScoreInfo(newWord, newScore)); // keep the discarded highscore info to use again. like pooling.
		
		if (_highScoreList.length > MAX_NUM_OF_HIGH_SCORES)
			_highScoreList.length = MAX_NUM_OF_HIGH_SCORES;
	}

	/**
	 * @inheritDoc
	 * @param word
	 * @return
	 */
	public function evaluateWord(word : String) : int
	{
		if (!isValidInBaseWord(word))
			return 0;
		
		return getScoreForWord(word);
	}
	
	/**
	 * 
	 * @param	word
	 * @return
	 */
	private function getScoreForWord(word : String):int 
	{
		if (_dictionary.contains(word))
			return word.length * POINTS_PER_LETTER;
		else return 0;		
	}
	
	/**
	 * 
	 * @param	word
	 * @return
	 */
	private function isValidInBaseWord(word : String):Boolean 
	{
		var wordLetters:Array = word.split("");
		var tempBaseWord:String = _baseWord;  // may also be split. need to compare performances of substring and array.split. (also allocations like concat)
		
		for each (var letter:String in wordLetters) 
		{
			var index:int = tempBaseWord.indexOf(letter);
			
			if (index == -1)
				return false;
				
			tempBaseWord = tempBaseWord.substring(0, index) + tempBaseWord.substring(index + 1, tempBaseWord.length);
		}
		
		return true;
	}

	/**
	 * @inheritDoc
	 * @param position
	 * @return
	 */
	public function getScoreAtPosition(position : int) : int
	{
		var scoreInfo:HighScoreInfo = _highScoreList[position];
		if (!scoreInfo)
			return 0; // wrong! must be -1
		
		return scoreInfo.score;
	}

	/**
	 * @inheritDoc
	 * @param position
	 * @return
	 */
	public function getWordAtPosition(position : int) : String
	{
		var scoreInfo:HighScoreInfo = _highScoreList[position];
		if (!scoreInfo)
			return null;
		
		return scoreInfo.word;
	}
}
}
