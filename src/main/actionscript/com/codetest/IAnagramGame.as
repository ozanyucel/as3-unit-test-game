package com.codetest {
/**
 * Service to provide an anagram game.
 * <p/>
 * The game is constructed with a base set of letters, e.g. the string "areallylongword",
 * which may be assumed to be all in lowercase, and with no whitespace or special characters. The user then attempts
 * to create words out of the letters from the base set, and score one point for each letter used. The submissions
 * must be "real words": use the WordDictionary to check each submission.
 * <p/>
 * For example (assuming "areallylongword" as base set of letters):
 * <ul>
 * <li>"no" is an acceptable submission, with score 2</li>
 * <li>"grow" is an acceptable submission, with score 4</li>
 * <li>"bold" is not an acceptable submission (cannot be created with letters from the base set)</li>
 * <li>"glly" is not an acceptable submission (isn't a "real word")</li>
 * <li>"woolly" is an acceptable submission with score 6</li>
 * <li>"adder" is not an acceptable submission (cannot be created with letters from the base set)</li>
 * </ul>
 * <p/>
 * The service maintains a list of the top ten highest-scoring submissions (the word and score).
 *
 * Assume that the load() method of the provided dictionary is called externally from this class, sometime after the
 * constructor of this class is called. Again, refer to the test skeleton for an example of the calling flow.
 *
 * <b>There is no need to make a user interface for this test</b>
 * @see http://en.wikipedia.org/wiki/Anagrams
 */
public interface IAnagramGame {

    /**
     * Submit a word on behalf of a user. A word is accepted if all its letters are contained in the original string
     * submitted in the constructor, and if it is in the WordDictionary. If the word is accepted and its score is high
     * enough, the submission should be added to the high score list. If there are multiple submissions with
     * the same score, all are accepted, but the first submission with that score should rank higher.
     * <p/>
     * <b>This method may be called before or after the dictionary is finished loading</b>. In either case, the submissions
     * should not be discarded but should be evaluated when that becomes possible.
     *
     * @param word     User's submission. All submissions may be assumed to be lowercase and containing no whitespace
     *                 or special characters.
     */
    function submitWord(word:String):void;

    /**
     * Evaluate a particular word and return its score. A word is accepted if all its letters are contained in the original string
     * submitted in the constructor and if it is in the WordDictionary. Accepted word should score one point for each letter
     * used to create it.
     *
     * <b>This method is guaranteed to never be called until the dictionary has finished loading</b>.
     *
     * @param word Word to check. All words may be assumed to be lowercase and containing no whitespace or special
     *             characters.
     * @return the score, 0 if the word is not accepted
     */
    function evaluateWord(word:String):int;

    /**
     * Return score at given position in the high score list, 0 being the highest (best score) and 9 the lowest.
     * You may assume that this method will never be called with position > 9.
     *
     * @param position Index on high score list
     * @return score at given position in the high score list, or -1 if there is no entry at that position
     */
    function getScoreAtPosition(position:int):int;

    /**
     * Return word entry at given position in the high score list, 0 being the highest (best score) and 9 the lowest.
     * You may assume that this method will never be called with position > 9.
     *
     * @param position Index on high score list
     * @return word entry at given position in the high score list, or null if there is no entry at that position
     */
    function getWordAtPosition(position:int):String;
}
}
