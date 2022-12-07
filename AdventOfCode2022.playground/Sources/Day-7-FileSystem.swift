import Foundation

public struct File: Hashable {
    let size: Int
    let name: String
}

public final class Directory {
    var name: String
    var files: [File]
    var directories: [Directory]

    var totalSize: Int {
        let totalFileSize = files.map(\.size).reduce(0, +)
        let totoalDirectorySize = directories.map(\.totalSize).reduce(0, +)
        return totalFileSize + totoalDirectorySize
    }

    init(name: String, files: [File], directories: [Directory]) {
        self.name = name
        self.files = files
        self.directories = directories
    }

    func createDirectoryIfNotExists(name: String) {
        if directories.contains(where: { $0.name == name }) {
            return
        }

        let directory = Directory(name: name, files: [], directories: [])
        directories.append(directory)
    }

    func createFileIfNotExists(file: File) {
        if files.contains(file) {
            return
        }

        files.append(file)
    }

}

enum Command {
    case cd(argument: String)
    case ls

    init?(string: [String]) {
        let commandName = string[0]
        switch commandName {
        case "cd":
            let argument = string[1]
            self = .cd(argument: String(argument))
        case "ls":
            self = .ls
        default:
            return nil
        }
    }
}

public struct FileSystem {
    public var root: Directory = .init(name: "root", files: [], directories: [])

    public var totalSizeOfDirectoryAtMost100000: Int {
        getAllDirectory(of: root).map(\.totalSize).filter { $0 <= 100000 }.reduce(0, +)
    }

    public var smalleseSizeOfDirectoryToDelete: Int? {
        let spaceNeeded = 30000000 - (70000000 - root.totalSize)
        return getAllDirectory(of: root).map(\.totalSize).filter { $0 >= spaceNeeded }.sorted().first
    }

    init(terminalOutput: String) {
        build(byTerminalOutput: terminalOutput)
    }

    func getAllDirectory(of directory: Directory) -> [Directory] {
        [directory] + directory.directories.flatMap { getAllDirectory(of: $0) }
    }

    mutating func build(byTerminalOutput output: String) {
        let lines = output.split(separator: "\n")

        var stack: [Directory] = []
        lines.map { $0.split(separator: " ") }.forEach { line in
            var lineComponents = Array(line)
            let first = lineComponents.removeFirst()
            switch first {
            case "$":
                let commandString = lineComponents.map { String($0) }
                guard let command = Command(string: commandString) else {
                    assertionFailure()
                    return
                }
                executeCommand(command)
            case "dir":
                guard let name = lineComponents.last else {
                    assertionFailure()
                    return
                }
                createDirectory(name: String(name))
            default:
                guard let fileSize = Int(String(first)) else { return }
                guard let fileName = lineComponents.last else { return }
                let file = File(size: fileSize, name: String(fileName))
                createFile(file)
            }
        }

        func executeCommand(_ command: Command) {
            switch command {
            case .cd(let argument):
                changeDirectory(to: argument)
            case .ls:
                return
            }
        }

        func changeDirectory(to name: String) {
            switch name {
            case "/":
                stack = [root]
            case "..":
                stack.removeLast()
            default:
                guard let currentDirectory = stack.last else { return }
                if let target = currentDirectory.directories.first(where: { $0.name == name }) {
                    stack.append(target)
                    return
                }
                let directory = Directory(name: name, files: [], directories: [])
                stack.append(directory)
            }
        }

        func createDirectory(name: String) {
            guard let currentDirectory = stack.last else { return }
            currentDirectory.createDirectoryIfNotExists(name: name)
            stack.removeLast()
            stack.append(currentDirectory)
        }

        func createFile(_ file: File) {
            guard let currentDirectory = stack.last else { return }
            currentDirectory.createFileIfNotExists(file: file)
            stack.removeLast()
            stack.append(currentDirectory)
        }
    }
}

extension FileSystem {
    public init?() throws {
        guard let fileURL = Bundle.main.url(forResource: "day-7-input", withExtension: "txt") else { return nil }
        let terminalOutput = try String(contentsOf: fileURL)

        self.init(terminalOutput: terminalOutput)
    }
}
