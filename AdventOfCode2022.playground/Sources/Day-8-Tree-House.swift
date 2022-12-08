import Foundation

public struct Quadcopter {
    let grid: [[Int]]

    public var numberOfVisibleTrees: Int {
        var n = 0
        for (i, _) in grid.enumerated() {
            let row = grid[i]
            for (j, element) in row.enumerated() {
                if isTreeVisibleAtPosition(rowIndex: i, columnIndex: j, withValue: element) {
                    n += 1
                }
            }
        }
        return n
    }

    public var highestPossibleScenicScore: Int {
        var score = 0

        for (i, _) in grid.enumerated() {
            let row = grid[i]
            for (j, element) in row.enumerated() {
                let treeScore = scoreOfTheTree(rowIndex: i, columnIndex: j, withValue: element)
                if treeScore > score {
                    score = treeScore
                }
            }
        }

        return score
    }

    func isTreeVisibleAtPosition(rowIndex: Int, columnIndex: Int, withValue value: Int) -> Bool {
        if rowIndex == 0 || rowIndex == grid.count - 1 {
            return true
        }

        let row = grid[rowIndex]

        if columnIndex == 0 || columnIndex == row.count - 1 {
            return true
        }

        let rowCount = row.count
        let leftHalf = row[0..<columnIndex]
        let rightHalf = row[(columnIndex + 1)..<rowCount]


        let isVisibleInRow = !leftHalf.contains(where: { $0 >= value }) || !rightHalf.contains(where: { $0 >= value })

        let column = grid.map { $0[columnIndex] }

        let columnCount = column.count
        let topHalf = column[0..<rowIndex]
        let bottomHalf = column[(rowIndex + 1)..<columnCount]

        let isVisibleInColumn = !topHalf.contains(where: { $0 >= value }) || !bottomHalf.contains(where: { $0 >= value })

        return isVisibleInRow || isVisibleInColumn
    }

    func scoreOfTheTree(rowIndex: Int, columnIndex: Int, withValue value: Int) -> Int {
        if rowIndex == 0 || rowIndex == grid.count - 1 {
            return 0
        }

        let row = grid[rowIndex]

        if columnIndex == 0 || columnIndex == row.count - 1 {
            return 0
        }

        let rowCount = row.count
        let leftHalf = row[0..<columnIndex]
        let rightHalf = row[(columnIndex + 1)..<rowCount]

        let leftDistance = columnIndex - (leftHalf.lastIndex(where: { $0 >= value }) ?? 0)
        let rightDistance: Int = {
            if let rightIndex = rightHalf.firstIndex(where: { $0 >= value}) {
                return rightIndex - columnIndex
            }

            return rowCount - 1 - columnIndex
        }()

        let column = grid.map { $0[columnIndex] }

        let columnCount = column.count
        let topHalf = column[0..<rowIndex]
        let bottomHalf = column[(rowIndex + 1)..<columnCount]

        let topDistance = rowIndex - (topHalf.lastIndex(where: { $0 >= value }) ?? 0)
        let bottomDistance: Int = {
            if let bottomIndex = bottomHalf.firstIndex(where: { $0 >= value }) {
                return bottomIndex - rowIndex
            }

            return grid.count - 1 - rowIndex
        }()

        return leftDistance * rightDistance * topDistance * bottomDistance
    }
}

extension Quadcopter {
    public init?() throws {
        guard let fileURL = Bundle.main.url(forResource: "day-8-input", withExtension: "txt") else { return nil }
        let map = try String(contentsOf: fileURL)
        let grid = map.split(separator: "\n").map { Array($0).compactMap { Int(String($0)) } }

        self.init(grid: grid)
    }
}
