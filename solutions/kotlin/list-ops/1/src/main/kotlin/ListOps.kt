fun <T> List<T>.customAppend(list: List<T>): List<T> = if (list.isEmpty()) this else this.plus(list.first()).customAppend(list.drop(1))

fun <T> List<List<T>>.customConcat(): List<T> = if (this.isEmpty()) emptyList() else this.customFoldLeft(emptyList(), {acc, x -> acc + x})

fun <T> List<T>.customFilter(predicate: (T) -> Boolean): List<T> = this.customFoldLeft(emptyList(), {acc, x -> if (predicate(x)) acc + x else acc })

val List<Any>.customSize: Int get() = this.customFoldLeft(0, {acc, _ -> 1 + acc})

fun <T, U> List<T>.customMap(transform: (T) -> U): List<U> = this.customFoldLeft(emptyList(), {acc, x -> acc + transform(x)})

fun <T, U> List<T>.customFoldLeft(initial: U, f: (U, T) -> U): U = if (this.isEmpty()) initial else this.drop(1).customFoldLeft(f(initial, this.first()), f)

fun <T, U> List<T>.customFoldRight(initial: U, f: (T, U) -> U): U = if (this.isEmpty()) initial else f(this.first(), this.drop(1).customFoldRight(initial, f))

fun <T> List<T>.customReverse(): List<T> = if (this.isEmpty()) emptyList() else this.drop(1).customReverse().plus(this.first())

