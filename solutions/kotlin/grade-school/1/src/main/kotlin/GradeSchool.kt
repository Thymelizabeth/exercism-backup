class School(val grades: MutableMap<Int, List<String>> = mutableMapOf()) {

    fun add(student: String, grade: Int)  {
        if (student !in roster()) {
            grades[grade] = grades.getOrPut(grade) { emptyList() } + listOf(student)
        }
    }

    fun grade(grade: Int): List<String> = 
        grades[grade]?.sorted() ?: emptyList()

    fun roster(): List<String> =
        grades.toSortedMap().values.flatMap { it.sorted() }
}
