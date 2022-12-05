import Foundation

public struct Procedure {
    let numberOfCrates: Int
    let from: Int
    let to: Int
}

extension Procedure {
    init?(string: String) {
        let inputs = string.split(separator: " ").compactMap { Int($0) }

        guard !inputs.isEmpty else { return nil }

        let numberOfCrates = inputs[0]
        let from = inputs[1] - 1
        let to = inputs[2] - 1

        self.init(numberOfCrates: numberOfCrates, from: from, to: to)
    }

    public static var allProcedures: [Procedure] {
        get throws {
            guard let fileURL = Bundle.main.url(forResource: "day-5-input", withExtension: "txt") else {
                return []
            }
            let content = try String(contentsOf: fileURL)
            return content.components(separatedBy: "\n").compactMap({ Procedure(string: $0) })
        }
    }
}

/*
                     [L] [M]         [M]
         [D] [R] [Z]         [C] [L]
         [C] [S] [T] [G]     [V] [M]
    [R]     [L] [Q] [B] [B]     [D] [F]
    [H] [B] [G] [D] [Q] [Z]     [T] [J]
    [M] [J] [H] [M] [P] [S] [V] [L] [N]
    [P] [C] [N] [T] [S] [F] [R] [G] [Q]
    [Z] [P] [S] [F] [F] [T] [N] [P] [W]
    1   2   3   4   5   6   7   8   9
 */
public let crates = [
    ["Z", "P", "M",  "H", "R"],
    ["P", "C", "J", "B"],
    ["S", "N", "H", "G", "L", "C", "D"],
    ["F", "T", "M", "D", "Q", "S", "R", "L"],
    ["F", "S", "P", "Q", "B", "T", "Z", "M"],
    ["T", "F", "S", "Z", "B", "G"],
    ["N", "R", "V"],
    ["P", "G", "L", "T", "D", "V", "C", "M"],
    ["W", "Q", "N", "J", "F", "M", "L"]
]

public struct CargoCrane9000 {
    public var cratesOnTop: String {
        crates.compactMap(\.last).joined()
    }

    private var crates: [[String]]

    public init(crates: [[String]]) {
        self.crates = crates
    }

    public mutating func execute(procedures: [Procedure]) {
        procedures.forEach { execute(procedure: $0) }
    }

    private mutating func execute(procedure: Procedure) {
        let fromIndex = procedure.from
        let toIndex = procedure.to

        var from = crates[fromIndex]
        var to = crates[toIndex]

        var numberOfCrates = procedure.numberOfCrates
        while numberOfCrates > 0 {
            let item = from.removeLast()
            to.append(item)

            numberOfCrates -= 1
        }

        crates[fromIndex] = from
        crates[toIndex] = to
    }
}

public struct CargoCrane9001 {
    public var cratesOnTop: String {
        crates.compactMap(\.last).joined()
    }

    private var crates: [[String]]

    public init(crates: [[String]]) {
        self.crates = crates
    }

    public mutating func execute(procedures: [Procedure]) {
        procedures.forEach { execute(procedure: $0) }
    }

    private mutating func execute(procedure: Procedure) {
        let fromIndex = procedure.from
        let toIndex = procedure.to

        var from = crates[fromIndex]
        var to = crates[toIndex]

        var numberOfCrates = procedure.numberOfCrates
        var temp: [String] = []
        while numberOfCrates > 0 {
            let item = from.removeLast()
            temp.insert(item, at: 0)

            numberOfCrates -= 1
        }
        to.append(contentsOf: temp)

        crates[fromIndex] = from
        crates[toIndex] = to
    }
}
