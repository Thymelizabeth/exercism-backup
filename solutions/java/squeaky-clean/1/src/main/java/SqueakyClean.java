import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class SqueakyClean {
    static String clean(String identifier) {
	Function<String, String> spaceToUnderscore = s -> s.replace(' ', '_');
	Function<String, String> kebabToCamelCase = s -> {
	    StringBuilder output = new StringBuilder();
	    Matcher matcher = Pattern.compile("-\\w").matcher(s);
	    while (matcher.find())
		matcher.appendReplacement(output, matcher.group().toUpperCase().substring(1));
	    matcher.appendTail(output);
	    return output.toString();
	};
	Function<String, String> leetspeakToNormalText = s -> s.replace('4', 'a').replace('3', 'e').replace('0', 'o').replace('1', 'l').replace('7', 't');
	Function<String, String> onlyLetters = s -> s.replaceAll("\\W", "");
	return identifier
	    .transform(spaceToUnderscore)
	    .transform(kebabToCamelCase)
	    .transform(leetspeakToNormalText)
	    .transform(onlyLetters);
    }
}
