import Foundation

struct Range {
    let min: Int
    let max: Int
}

struct Pair {
    let first: Range
    let second: Range

    var isOneFullyContainedTheOther: Bool {
        let isFirstContainsSecond = first.min <= second.min && first.max >= second.max
        let isSecondContainsFirst = second.min <= first.min && second.max >= first.max

        return isFirstContainsSecond || isSecondContainsFirst
    }

    var isOneOverlapTheOther: Bool {
        let isFirstOverlapSecond = first.min <= second.max && first.max >= second.min
        let isSecondOverlapFirst = second.min <= first.max && second.max >= first.min

        return isFirstOverlapSecond || isSecondOverlapFirst
    }
}

extension Pair {
    init?(string: String) {
        let values = string.split(separator: ",")
        guard let first = values.first?.split(separator: "-").compactMap({ Int($0) }) else { return nil }
        guard let second = values.last?.split(separator: "-").compactMap({ Int($0) }) else { return nil }

        let firstRange = Range(min: first[0], max: first[1])
        let secondRange = Range(min: second[0], max: second[1])

        self.init(first: firstRange, second: secondRange)
    }
}

public struct AssignmentManager {
    let pairs: [Pair]

    public var numberOfPairsFullyContainTheOther: Int {
        pairs.filter(\.isOneFullyContainedTheOther).count
    }

    public var numberOfPairsThatOverlaps: Int {
        pairs.filter(\.isOneOverlapTheOther).count
    }
}

extension AssignmentManager {
    public init?() throws {
        guard let fileURL = Bundle.main.url(forResource: "day-4-input", withExtension: "txt") else { return nil }
        let content = try String(contentsOf: fileURL)
        let pairs = content.components(separatedBy: "\n").compactMap({ Pair(string: $0) })

        self.init(pairs: pairs)
    }
}
