package com.plumbee.codetest {
import flash.events.Event;
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertTrue;
import org.flexunit.async.Async;

/**
 * This class is a FlexUnit class which you can run to check if AnagramGame is working correctly.
 * Running it is not part of the code test and if you are not familiar with FlexUnit,
 * please make sure you complete the test before trying to set it up.
 */
public class AnagramGameTest {

	private var dictionary : IWordDictionary;
	private var game : IAnagramGame;

	[Before]
	public function setUp() : void {
		dictionary = new WordDictionary();
		game = new AnagramGame("areallylongword", dictionary);
	}
	
	//[Test]
	//public function dummyTest():void {
		//assertTrue(true);
	//}

	[Test(async)]
    public function afterDictionaryIsLoaded_wordsAreEvaluatedCorrectly():void {

		Async.handleEvent(this, dictionary, "loaded", checkIfWordsAreEvaluatedCorrectly, 15000);
		dictionary.load();
    }

	private function checkIfWordsAreEvaluatedCorrectly(event : Event, passThroughObject : Object) : void {
		assertEquals(2, game.evaluateWord("no"));
		assertEquals(4, game.evaluateWord("grow"));
		assertEquals(0, game.evaluateWord("bold"));
		assertEquals(0, game.evaluateWord("glly"));
		assertEquals(6, game.evaluateWord("woolly"));
		assertEquals(0, game.evaluateWord("adder"));
	}

	[Test(async)]
	public function wordsSubmittedBeforeDictionaryIsLoaded_areNotDiscarded() : void {
		game.submitWord("no");
		game.submitWord("grow");
		game.submitWord("bold");
		game.submitWord("glly");
		game.submitWord("woolly");
		game.submitWord("adder");
		Async.handleEvent(this, dictionary, "loaded", checkIfWordsWereSubmittedCorrectly, 15000);
		dictionary.load();

	}

	private function checkIfWordsWereSubmittedCorrectly(event : Event, passThroughObject : Object) : void {
		assertHighscoreEntry(0, "woolly", 6);
		assertHighscoreEntry(1, "grow", 4);
		assertHighscoreEntry(2, "no", 2);
	}

	private function assertHighscoreEntry (index : int, expectedWord : String, expectedScore : int) : void {
		assertEquals(expectedWord, game.getWordAtPosition(index));
		assertEquals(expectedScore, game.getScoreAtPosition(index));
	}

}
}
