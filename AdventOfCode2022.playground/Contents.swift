import Foundation

// MARK: - Day 1

let calorieCalculator = try CalorieCalculator()

let answer1_day1 = calorieCalculator?.totalTopMostCalories
let answer2_day1 = calorieCalculator?.totalTop3Calories

// MARK: - Day 2

let tournament = try Tournament()
let answer1_day2 = tournament?.play()

let tournament2 = try Tournament(strategy: .balance)
let answer2_day2 = tournament2?.play()

// MARK: - Day 3

let priorityCalculator = try PriorityCalculator()
let answer1_day3 = priorityCalculator?.totalPriorities
let answer2_day3 = priorityCalculator?.totalPrioritiesOfGroups

// MARK: - Day 4

let assignmentManager = try AssignmentManager()
let answer1_day4 = assignmentManager?.numberOfPairsFullyContainTheOther
let answer2_day4 = assignmentManager?.numberOfPairsThatOverlaps

// MARK: - Day 5

let procedures = try Procedure.allProcedures

var cargoCrane9000 = CargoCrane9000(crates: crates)
cargoCrane9000.execute(procedures: procedures)
let answer1_day5 = cargoCrane9000.cratesOnTop

var cargoCrane9001 = CargoCrane9001(crates: crates)
cargoCrane9001.execute(procedures: procedures)
let answer2_day5 = cargoCrane9001.cratesOnTop

// MARK: - Day 6

let detector = try PacketMarkerDetector()
let answer1_day6 = detector?.startOfPacketMarker
let answer2_day6 = detector?.startOfMessageMarker

// MARK: - Day 7

let fileSystem = try FileSystem()
let answer1_day7 = fileSystem?.totalSizeOfDirectoryAtMost100000
let answer2_day7 = fileSystem?.smalleseSizeOfDirectoryToDelete

// MARK: - Day 8

let quadcopter = try Quadcopter()
let answer1_day8 = quadcopter?.numberOfVisibleTrees
let answer2_day8 = quadcopter?.highestPossibleScenicScore

// MARK: - Day 9

var rope = try Rope()
rope?.makeMotions()
let answer1_day9 = rope?.tailVisitedPositions.count

var combinedRope = try CombinedRope()
combinedRope?.makeMotions()
let answer2_day9 = combinedRope?.tailVisitedPositions.count

// MARK: - Day 10

let device = try Device()
let answer1_day10 = device?.sumOfSixSignalStrength
let answer2_day10 = device?.ctrImage

// MARK: - Day 11

let game = Game()
game.start(numberOfRounds: 20)
let answer1_day11 = game.monkeyBusiness

let game2 = Game2()
game2.start(numberOfRounds: 10000)
let answer2_day11 = game2.monkeyBusiness
