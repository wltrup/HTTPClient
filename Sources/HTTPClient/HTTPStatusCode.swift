

public struct HTTPStatusCode: Hashable {

    public init(value: Int) {
        self.value = value
    }

    public let value: Int

}

// MARK: - CustomStringConvertible API

extension HTTPStatusCode: CustomStringConvertible {

    public var description: String {
        "\(value)"
    }

}
