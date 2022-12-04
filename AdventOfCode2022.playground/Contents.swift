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
