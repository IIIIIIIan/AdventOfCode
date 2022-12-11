import Foundation

public struct Position: Equatable {
    var x: Int
    var y: Int

    static let zero = Position(x: 0, y: 0)
}

enum Motion {
    case left(Int)
    case right(Int)
    case top(Int)
    case bottom(Int)

    init?(input: String) {
        let string = input.split(separator: " ")

        guard let direction = string.first else { return nil }
        guard let number = string.last else { return nil }
        guard let steps = Int(number) else { return nil }

        switch direction {
        case "L":
            self = .left(steps)
        case "R":
            self = .right(steps)
        case "U":
            self = .top(steps)
        case "D":
            self = .bottom(steps)
        default:
            return nil
        }
    }
}

public struct CombinedRope {
    var head = Position.zero
    var knot2 = Position.zero
    var knot3 = Position.zero
    var knot4 = Position.zero
    var knot5 = Position.zero
    var knot6 = Position.zero
    var knot7 = Position.zero
    var knot8 = Position.zero
    var knot9 = Position.zero
    var tail = Position.zero

    public var tailVisitedPositions: [Position] = [.zero]

    let motions: [Motion]

    public mutating func makeMotions() {
        motions.forEach {
            switch $0 {
            case .left(let steps):
                moveHeadLeft(steps: steps)
            case .right(let steps):
                moveHeadRight(steps: steps)
            case .top(let steps):
                moveHeadUp(steps: steps)
            case .bottom(let steps):
                moveHeadDown(steps: steps)
            }
        }
    }

    private mutating func moveAllKnotsIfNeeded() {
        var head = self.head
        var knot2 = self.knot2
        var knot3 = self.knot3
        var knot4 = self.knot4
        var knot5 = self.knot5
        var knot6 = self.knot6
        var knot7 = self.knot7
        var knot8 = self.knot8
        var knot9 = self.knot9
        var tail = self.tail

        moveTailIfNeeded(head: &head, tail: &knot2)
        moveTailIfNeeded(head: &knot2, tail: &knot3)
        moveTailIfNeeded(head: &knot3, tail: &knot4)
        moveTailIfNeeded(head: &knot4, tail: &knot5)
        moveTailIfNeeded(head: &knot5, tail: &knot6)
        moveTailIfNeeded(head: &knot6, tail: &knot7)
        moveTailIfNeeded(head: &knot7, tail: &knot8)
        moveTailIfNeeded(head: &knot8, tail: &knot9)
        moveTailIfNeeded(head: &knot9, tail: &tail, isTail: true)

        self.head = head
        self.knot2 = knot2
        self.knot3 = knot3
        self.knot4 = knot4
        self.knot5 = knot5
        self.knot6 = knot6
        self.knot7 = knot7
        self.knot8 = knot8
        self.knot9 = knot9
        self.tail = tail
    }

    private mutating func moveHeadRight(steps: Int) {
        for _ in 0..<steps {
            head.x += 1
            moveAllKnotsIfNeeded()
        }
    }

    private mutating func moveHeadLeft(steps: Int) {
        for _ in 0..<steps {
            head.x -= 1
            moveAllKnotsIfNeeded()
        }
    }

    private mutating func moveHeadUp(steps: Int) {
        for _ in 0..<steps {
            head.y += 1
            moveAllKnotsIfNeeded()
        }
    }

    private mutating func moveHeadDown(steps: Int) {
        for _ in 0..<steps {
            head.y -= 1
            moveAllKnotsIfNeeded()
        }
    }

    private mutating func moveTailIfNeeded(head: inout Position, tail: inout Position, isTail: Bool = false) {
        if abs(head.x - tail.x) > 1 {
            if head.x > tail.x {
                tail.x += 1
                if head.y > tail.y {
                    tail.y += 1
                } else if head.y < tail.y {
                    tail.y -= 1
                }
                if !tailVisitedPositions.contains(tail) && isTail {
                    tailVisitedPositions.append(tail)
                }
            } else if head.x < tail.x {
                tail.x -= 1
                if head.y > tail.y {
                    tail.y += 1
                } else if head.y < tail.y {
                    tail.y -= 1
                }
                if !tailVisitedPositions.contains(tail) && isTail {
                    tailVisitedPositions.append(tail)
                }
            }
        } else if abs(head.y - tail.y) > 1 {
            if head.y > tail.y {
                tail.y += 1
                if head.x > tail.x {
                    tail.x += 1
                } else if head.x < tail.x {
                    tail.x -= 1
                }
                if !tailVisitedPositions.contains(tail) && isTail {
                    tailVisitedPositions.append(tail)
                }
            } else if head.y < tail.y {
                tail.y -= 1
                if head.x > tail.x {
                    tail.x += 1
                } else if head.x < tail.x {
                    tail.x -= 1
                }
                if !tailVisitedPositions.contains(tail) && isTail {
                    tailVisitedPositions.append(tail)
                }
            }
        }
    }
}

extension CombinedRope {
    public init?() throws {
        guard let fileURL = Bundle.main.url(forResource: "day-9-input", withExtension: "txt") else { return nil }
        let content = try String(contentsOf: fileURL)
        let motions = content.split(separator: "\n").compactMap { Motion(input: String($0)) }

        self.init(motions: motions)
    }
}

public struct Rope {
    var head = Position.zero
    var tail = Position.zero

    public var tailVisitedPositions: [Position] = [.zero]

    let motions: [Motion]

    public mutating func makeMotions() {
        motions.forEach {
            switch $0 {
            case .left(let steps):
                moveHeadLeft(steps: steps)
            case .right(let steps):
                moveHeadRight(steps: steps)
            case .top(let steps):
                moveHeadUp(steps: steps)
            case .bottom(let steps):
                moveHeadDown(steps: steps)
            }
        }
    }

    private mutating func moveHeadRight(steps: Int) {
        for _ in 0..<steps {
            head.x += 1
            moveTailIfNeeded()
        }
    }

    private mutating func moveHeadLeft(steps: Int) {
        for _ in 0..<steps {
            head.x -= 1
            moveTailIfNeeded()
        }
    }

    private mutating func moveHeadUp(steps: Int) {
        for _ in 0..<steps {
            head.y += 1
            moveTailIfNeeded()
        }
    }

    private mutating func moveHeadDown(steps: Int) {
        for _ in 0..<steps {
            head.y -= 1
            moveTailIfNeeded()
        }
    }

    private mutating func moveTailIfNeeded() {
        if abs(head.x - tail.x) > 1 {
            if head.x > tail.x {
                tail.x += 1
                if head.y > tail.y {
                    tail.y += 1
                } else if head.y < tail.y {
                    tail.y -= 1
                }
                if !tailVisitedPositions.contains(tail) {
                    tailVisitedPositions.append(tail)
                }
            } else if head.x < tail.x {
                tail.x -= 1
                if head.y > tail.y {
                    tail.y += 1
                } else if head.y < tail.y {
                    tail.y -= 1
                }
                if !tailVisitedPositions.contains(tail) {
                    tailVisitedPositions.append(tail)
                }
            }
        } else if abs(head.y - tail.y) > 1 {
            if head.y > tail.y {
                tail.y += 1
                if head.x > tail.x {
                    tail.x += 1
                } else if head.x < tail.x {
                    tail.x -= 1
                }
                if !tailVisitedPositions.contains(tail) {
                    tailVisitedPositions.append(tail)
                }
            } else if head.y < tail.y {
                tail.y -= 1
                if head.x > tail.x {
                    tail.x += 1
                } else if head.x < tail.x {
                    tail.x -= 1
                }
                if !tailVisitedPositions.contains(tail) {
                    tailVisitedPositions.append(tail)
                }
            }
        }
    }
}

extension Rope {
    public init?() throws {
        guard let fileURL = Bundle.main.url(forResource: "day-9-input", withExtension: "txt") else { return nil }
        let content = try String(contentsOf: fileURL)
        let motions = content.split(separator: "\n").compactMap { Motion(input: String($0)) }

        self.init(motions: motions)
    }
}
