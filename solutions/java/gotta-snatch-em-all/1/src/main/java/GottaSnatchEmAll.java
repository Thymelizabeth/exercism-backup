import java.util.List;
import java.util.Set;

class GottaSnatchEmAll {

    static Set<String> newCollection(List<String> cards) {
        return Set.copyOf(cards);
    }

    static boolean addCard(String card, Set<String> collection) {
        return collection.add(card);
    }

    static boolean canTrade(Set<String> myCollection, Set<String> theirCollection) {
        return !myCollection.containsAll(theirCollection) && !theirCollection.containsAll(myCollection);
    }

    static Set<String> commonCards(List<Set<String>> collections) {
	return Set.copyOf(collections
			  .parallelStream()
			  .reduce((x, acc) ->
				  Set.copyOf(x
					     .parallelStream()
					     .filter(s -> acc.contains(s))
					     .toList()
					     )
				  )
			  .orElse(Set.of())
			  );
    }

    static Set<String> allCards(List<Set<String>> collections) {
        return Set.copyOf(collections.parallelStream().flatMap(s -> s.parallelStream()).toList());
    }
}
