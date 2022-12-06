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

// MARK: - Day 4

let procedures = try Procedure.allProcedures

var cargoCrane9000 = CargoCrane9000(crates: crates)
cargoCrane9000.execute(procedures: procedures)
let answer1_day5 = cargoCrane9000.cratesOnTop

var cargoCrane9001 = CargoCrane9001(crates: crates)
cargoCrane9001.execute(procedures: procedures)
let answer2_day5 = cargoCrane9001.cratesOnTop

// MARK: - Day 5

let detector = try PacketMarkerDetector()
let answer1_day6 = detector?.startOfPacketMarker
let answer2_day6 = detector?.startOfMessageMarker
