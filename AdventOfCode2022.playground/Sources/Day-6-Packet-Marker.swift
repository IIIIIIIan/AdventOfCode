import Foundation

public struct PacketMarkerDetector {
    public let packet: String

    public var startOfPacketMarker: Int {
        positionOfFirstDistinctCharactersInLength(4)
    }

    public var startOfMessageMarker: Int {
        positionOfFirstDistinctCharactersInLength(14)
    }

    private func positionOfFirstDistinctCharactersInLength(_ length: Int) -> Int {
        var index = packet.startIndex
        let endIndex = packet.endIndex

        while index < endIndex {
            let windowEnd = packet.index(index, offsetBy: length)
            let characters = packet[index..<windowEnd]

            let isStartOfPacket = areAllCharactersDifferent(characters: Array(characters))
            if isStartOfPacket {
                return windowEnd.utf16Offset(in: packet)
            }

            let nextIndex = packet.index(index, offsetBy: 1)
            index = nextIndex
        }

        return 0
    }

    private func areAllCharactersDifferent(characters: [Character]) -> Bool {
        let characterSet = Set(characters)
        return characterSet.count == characters.count
    }
}

extension PacketMarkerDetector {
    public init?() throws {
        guard let fileURL = Bundle.main.url(forResource: "day-6-input", withExtension: "txt") else { return nil }
        let packet = try String(contentsOf: fileURL)

        self.init(packet: packet)
    }
}
