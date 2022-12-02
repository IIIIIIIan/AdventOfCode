import Foundation

enum Shape: Int {
    case rock = 1
    case paper = 2
    case scissor = 3
}

extension Shape {
    init?(character: String) {
        switch character {
        case "A", "X":
            self = .rock
        case "B", "Y":
            self = .paper
        case "C", "Z":
            self = .scissor
        default:
            return nil
        }
    }
}

let winningDict: [Shape: Shape] = [
    .rock: .paper,
    .paper: .scissor,
    .scissor: .rock
]

let losingDict: [Shape: Shape] = [
    .rock: .scissor,
    .paper: .rock,
    .scissor: .paper
]

extension Shape: Equatable {
    func outcome(against shape: Shape) -> Int {
        if self == shape {
            return 3
        }

        let winningShape = winningDict[self]
        return winningShape == shape ? 6 : 0
    }
}

struct Round {
    let opponent: Shape
    let player: Shape

    var result: Int {
        let outcome = opponent.outcome(against: player)
        return outcome + player.rawValue
    }
}

extension Round {
    init?(input: String, strategy: Strategy) {
        let string = input.components(separatedBy: " ")

        switch strategy {
        case .alwaysWin:
            guard let opponent = Shape(character: string[0]), let player = Shape(character: string[1]) else {
                return nil
            }
            self.init(opponent: opponent, player: player)
        case .balance:
            guard let opponent = Shape(character: string[0]) else { return nil }

            let value = string[1]

            let player = {
                switch value {
                case "X":
                    return losingDict[opponent]
                case "Y":
                    return opponent
                case "Z":
                    return winningDict[opponent]
                default:
                    return nil
                }
            }()

            guard let player else { return nil }

            self.init(opponent: opponent, player: player)
        }
    }
}

public enum Strategy {
    case alwaysWin
    case balance
}

public struct Tournament {
    let rounds: [Round]

    public func play() -> Int {
        return rounds.map(\.result).reduce(0, +)
    }
}

public extension Tournament {
    init?(strategy: Strategy = .alwaysWin) throws {
        guard let fileURL = Bundle.main.url(forResource: "day-2-input", withExtension: "txt") else { return nil }
        let content = try String(contentsOf: fileURL)
        let rounds = content.components(separatedBy: "\n").compactMap { Round(input: $0, strategy: strategy) }

        self.init(rounds: rounds)
    }
}
