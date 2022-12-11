import Foundation

public final class Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.worryLevel == rhs.worryLevel
    }

    public var worryLevel: Int

    init(worryLevel: Int) {
        self.worryLevel = worryLevel
    }
}

public final class Monkey {
    typealias Operation = (Int) -> Int
    typealias Test = (Item) -> Monkey

    public var numberOfInspectedItems: Int = 0

    public private(set) var items: [Item]

    let operation: Operation
    let test: Test

    init(items: [Int], operation: @escaping Operation, test: @escaping Test) {
        self.items = items.map { Item(worryLevel: $0) }
        self.operation = operation
        self.test = test
    }

    func takeItem(_ item: Item) {
        items.append(item)
    }

    func inspectItem(_ item: Item, divideBy number: Int? = nil) {
        let level = item.worryLevel
        item.worryLevel = operation(level)

        if let number {
            item.worryLevel = item.worryLevel / number
        }

        numberOfInspectedItems += 1
    }

    func throwItem(_ item: Item) {
        let monkey = test(item)
        monkey.takeItem(item)

        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
    }
}

struct Part1Data {

    static let monkey0 = Monkey(
        items: [98, 97, 98, 55, 56, 72],
        operation: operation0,
        test: test0
    )

    static let monkey1 = Monkey(
        items: [73, 99, 55, 54, 88, 50, 55],
        operation: operation1,
        test: test1
    )

    static let monkey2 = Monkey(
        items: [67, 98],
        operation: operation2,
        test: test2
    )

    static let monkey3 = Monkey(
        items: [82, 91, 92, 53, 99],
        operation: operation3,
        test: test3
    )

    static let monkey4 = Monkey(
        items: [52, 62, 94, 96, 52, 87, 53, 60],
        operation: operation4,
        test: test4
    )

    static let monkey5 = Monkey(
        items: [94, 80, 84, 79],
        operation: operation5,
        test: test5
    )

    static let monkey6 = Monkey(
        items: [89],
        operation: operation6,
        test: test6
    )

    static let monkey7 = Monkey(
        items: [70, 59, 63],
        operation: operation7,
        test: test7
    )

    static let commonMultiple = 11 * 17 * 5 * 13 * 19 * 2 * 3 * 7

    static func operation0(number: Int) -> Int {
        let n = number * 13
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test0(item: Item) -> Monkey {
        item.worryLevel % 11 == 0 ? monkey4 : monkey7
    }

    static func operation1(number: Int) -> Int {
        let n = number + 4
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test1(item: Item) -> Monkey {
        item.worryLevel % 17 == 0 ? monkey2 : monkey6
    }

    static func operation2(number: Int) -> Int {
        let n = number * 11
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test2(item: Item) -> Monkey {
        item.worryLevel % 5 == 0 ? monkey6 : monkey5
    }

    static func operation3(number: Int) -> Int {
        let n = number + 8
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test3(item: Item) -> Monkey {
        item.worryLevel % 13 == 0 ? monkey1 : monkey2
    }

    static func operation4(number: Int) -> Int {
        let n = number * number
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test4(item: Item) -> Monkey {
        item.worryLevel % 19 == 0 ? monkey3 : monkey1
    }

    static func operation5(number: Int) -> Int {
        let n = number + 5
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test5(item: Item) -> Monkey {
        item.worryLevel % 2 == 0 ? monkey7 : monkey0
    }

    static func operation6(number: Int) -> Int {
        let n = number + 1
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test6(item: Item) -> Monkey {
        item.worryLevel % 3 == 0 ? monkey0 : monkey5
    }

    static func operation7(number: Int) -> Int {
        let n = number + 3
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test7(item: Item) -> Monkey {
        item.worryLevel % 7 == 0 ? monkey4 : monkey3
    }
}

struct Part2Data {

    static let monkey0 = Monkey(
        items: [98, 97, 98, 55, 56, 72],
        operation: operation0,
        test: test0
    )

    static let monkey1 = Monkey(
        items: [73, 99, 55, 54, 88, 50, 55],
        operation: operation1,
        test: test1
    )

    static let monkey2 = Monkey(
        items: [67, 98],
        operation: operation2,
        test: test2
    )

    static let monkey3 = Monkey(
        items: [82, 91, 92, 53, 99],
        operation: operation3,
        test: test3
    )

    static let monkey4 = Monkey(
        items: [52, 62, 94, 96, 52, 87, 53, 60],
        operation: operation4,
        test: test4
    )

    static let monkey5 = Monkey(
        items: [94, 80, 84, 79],
        operation: operation5,
        test: test5
    )

    static let monkey6 = Monkey(
        items: [89],
        operation: operation6,
        test: test6
    )

    static let monkey7 = Monkey(
        items: [70, 59, 63],
        operation: operation7,
        test: test7
    )

    static let commonMultiple = 11 * 17 * 5 * 13 * 19 * 2 * 3 * 7

    static func operation0(number: Int) -> Int {
        let n = number * 13
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test0(item: Item) -> Monkey {
        item.worryLevel % 11 == 0 ? monkey4 : monkey7
    }

    static func operation1(number: Int) -> Int {
        let n = number + 4
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test1(item: Item) -> Monkey {
        item.worryLevel % 17 == 0 ? monkey2 : monkey6
    }

    static func operation2(number: Int) -> Int {
        let n = number * 11
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test2(item: Item) -> Monkey {
        item.worryLevel % 5 == 0 ? monkey6 : monkey5
    }

    static func operation3(number: Int) -> Int {
        let n = number + 8
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test3(item: Item) -> Monkey {
        item.worryLevel % 13 == 0 ? monkey1 : monkey2
    }

    static func operation4(number: Int) -> Int {
        let n = number * number
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test4(item: Item) -> Monkey {
        item.worryLevel % 19 == 0 ? monkey3 : monkey1
    }

    static func operation5(number: Int) -> Int {
        let n = number + 5
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test5(item: Item) -> Monkey {
        item.worryLevel % 2 == 0 ? monkey7 : monkey0
    }

    static func operation6(number: Int) -> Int {
        let n = number + 1
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test6(item: Item) -> Monkey {
        item.worryLevel % 3 == 0 ? monkey0 : monkey5
    }

    static func operation7(number: Int) -> Int {
        let n = number + 3
        let (_, r) = n.quotientAndRemainder(dividingBy: commonMultiple)
        return r
    }

    static func test7(item: Item) -> Monkey {
        item.worryLevel % 7 == 0 ? monkey4 : monkey3
    }
}

public final class Game {

    public let monkeys = [Part1Data.monkey0, Part1Data.monkey1, Part1Data.monkey2, Part1Data.monkey3, Part1Data.monkey4, Part1Data.monkey5, Part1Data.monkey6, Part1Data.monkey7]

    public var monkeyBusiness: Int {
        let mostActiveMonkeys = monkeys.map(\.numberOfInspectedItems).sorted(by: >)

        return mostActiveMonkeys[0] * mostActiveMonkeys[1]
    }

    public init() {}

    public func start(numberOfRounds num: Int) {
        for _ in 0..<num {
            monkeys.forEach { monkey in
                monkey.items.forEach { item in
                    monkey.inspectItem(item, divideBy: 3)
                    monkey.throwItem(item)
                }
            }
        }
    }
}

public final class Game2 {

    public let monkeys = [Part2Data.monkey0, Part2Data.monkey1, Part2Data.monkey2, Part2Data.monkey3, Part2Data.monkey4, Part2Data.monkey5, Part2Data.monkey6, Part2Data.monkey7]

    public var monkeyBusiness: Int {
        let mostActiveMonkeys = monkeys.map(\.numberOfInspectedItems).sorted(by: >)

        return mostActiveMonkeys[0] * mostActiveMonkeys[1]
    }

    public init() {}

    public func start(numberOfRounds num: Int) {
        for _ in 0..<num {
            monkeys.forEach { monkey in
                monkey.items.forEach { item in
                    monkey.inspectItem(item)
                    monkey.throwItem(item)
                }
            }
        }
    }
}

