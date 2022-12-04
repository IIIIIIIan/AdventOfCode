import Foundation

let characters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
let values = Array(1...52)
let prioritiesScore = Dictionary(uniqueKeysWithValues: zip(characters, values))

public struct Rucksack {
    public let firstCompartment: String
    public let secondCompartment: String

    public let value: String

    public var totalPriorities: Int {
        let appearInBoth = firstCompartment.filter { secondCompartment.contains($0) }
        let resultArray = Array(Set(appearInBoth))
        return resultArray.compactMap { prioritiesScore[$0] }.reduce(0, +)
    }
}

public extension Rucksack {
    init(string: String) {
        let length = string.count
        let mid = length / 2
        let startIndex = string.startIndex
        let endIndex = string.endIndex
        let midIndex = string.index(startIndex, offsetBy: mid)
        let firstCompartment = String(string[startIndex..<midIndex])
        let secondCompartment = String(string[midIndex..<endIndex])

        self.init(firstCompartment: firstCompartment, secondCompartment: secondCompartment, value: string)
    }
}

struct RucksackGroup {
    let first: Rucksack
    let second: Rucksack?
    let third: Rucksack?

    var totalPriorities: Int {
        let firstValue = first.value
        let secondValue = second?.value ?? ""
        let thirdValue = third?.value ?? ""

        let appearInAll = firstValue.filter { secondValue.contains($0) }.filter { thirdValue.contains($0) }
        let resultArray = Array(Set(appearInAll))
        return resultArray.compactMap { prioritiesScore[$0] }.reduce(0, +)
    }
}

public struct PriorityCalculator {
    let rucksacks: [Rucksack]

    public var totalPriorities: Int {
        rucksacks.map(\.totalPriorities).reduce(0, +)
    }

    public var totalPrioritiesOfGroups: Int {
        var groups: [RucksackGroup] = []
        let count = rucksacks.count
        var i = 0
        while i < count {
            let first = rucksacks[i]

            let secondIndex = i + 1
            let second: Rucksack? = secondIndex < count ? rucksacks[secondIndex] : nil

            let thirdIndex = i + 2
            let third: Rucksack? = thirdIndex < count ? rucksacks[thirdIndex] : nil
            
            let group = RucksackGroup(first: first, second: second, third: third)
            groups.append(group)

            i += 3
        }

        return groups.map(\.totalPriorities).reduce(0, +)
    }
}

extension PriorityCalculator {
    public init?() throws {
        guard let fileURL = Bundle.main.url(forResource: "day-3-input", withExtension: "txt") else { return nil }
        let content = try String(contentsOf: fileURL)
        let rucksacks = content.components(separatedBy: "\n").map { Rucksack(string: $0) }

        self.init(rucksacks: rucksacks)
    }
}
