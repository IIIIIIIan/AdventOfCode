import Foundation

public struct Elf {
    let caloriesCarrying: [Int]

    var totalCalories: Int { caloriesCarrying.reduce(0, +) }
}

public struct CalorieCalculator {
    let elves: [Elf]

    public var totalTopMostCalories: Int? {
        elves.map { $0.totalCalories }.sorted(by: >).first
    }

    public var totalTop3Calories: Int? {
        elves.map { $0.totalCalories }.sorted(by: >).prefix(3).reduce(0, +)
    }
}

public extension CalorieCalculator {
    init?() throws {
        guard let fileURL = Bundle.main.url(forResource: "day-1-input", withExtension: "txt") else { return nil }
        let content = try String(contentsOf: fileURL)
        let calories = content.components(separatedBy: "\n\n")
        let elves = calories.map { $0.components(separatedBy: "\n").compactMap { Int($0) } }.map { Elf(caloriesCarrying: $0) }

        self.init(elves: elves)
    }
}
