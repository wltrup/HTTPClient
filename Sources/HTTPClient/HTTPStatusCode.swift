

public struct HTTPStatusCode: Hashable {

    public let value: Int

    public init(value: Int) {
        self.value = value
    }

}

// MARK: - CustomStringConvertible API

extension HTTPStatusCode: CustomStringConvertible {

    public var description: String {
        "\(value)"
    }

}
