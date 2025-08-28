class Acronym {

    String phrase;

    Acronym(String phrase) {
	this.phrase = phrase;
    }

    String get() {
	return phrase.replaceAll("[ -]", "\n").lines()   // Split at ' ' and '-'
	    .map(s -> s.replaceAll("[^-a-zA-Z ]", ""))   // Remove everything except -, a-z, A-Z, ' '
	    .filter(s -> s != "")                                      // Filter out empty strings
	    .map(s -> s.substring(0, 1).toUpperCase()) // Get first letter, turn uppercase
	    .reduce("", (x, y) -> x + y);                       // Recombine words
    }

}
