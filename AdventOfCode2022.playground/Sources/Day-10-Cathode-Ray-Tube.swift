import Foundation

enum Signal {
    case addx(Int)
    case noop

    init?(input: String) {
        let string = input.split(separator: " ")
        guard let instruction = string.first else { return nil }

        switch instruction {
        case "addx":
            guard let number = string.last else { return nil }
            guard let value = Int(number) else { return nil}
            self = .addx(value)
        case "noop":
            self = .noop
        default:
            return nil
        }
    }
}

public struct Device {
    let values: [Int]

    public var sumOfSixSignalStrength: Int {
        let first = values.prefix(20).reduce(0, +) * 20
        let second = values.prefix(60).reduce(0, +) * 60
        let third = values.prefix(100).reduce(0, +) * 100
        let fourth = values.prefix(140).reduce(0, +) * 140
        let fifth = values.prefix(180).reduce(0, +) * 180
        let sixth = values.prefix(220).reduce(0, +) * 220

        return first + second + third + fourth + fifth + sixth
    }

    public var ctrImage: String {
        var screen = Array(Array(repeating: ".", count: 240))
        for i in 0..<6 {
            for j in 0..<40 {
                let index = i * 40 + j
                let pixcel = values.prefix(index + 1).reduce(0, +)
                let lowerBound = pixcel - 1
                let upperBound = pixcel + 1
                if lowerBound <= j && j <= upperBound {
                    screen[index] = "#"
                }
            }
        }

        var imageString = ""
        for i in 0..<6 {
            var line = ""
            for j in 0..<40 {
                let index = i * 40 + j
                line += screen[index]
            }
            line += "\n"
            imageString += line
        }
        return imageString
    }
}

extension Device {
    public init?() throws {
        guard let fileURL = Bundle.main.url(forResource: "day-10-input", withExtension: "txt") else { return nil }
        let content = try String(contentsOf: fileURL)
        let signals = content.split(separator: "\n").compactMap { Signal(input: String($0)) }
        var values: [Int] = [1]
        signals.forEach {
            switch $0 {
            case .addx(let value):
                values.append(0)
                values.append(value)
            case .noop:
                values.append(0)
            }
        }

        self.init(values: values)
    }
}
