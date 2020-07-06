

public struct HTTPStatusCode: Hashable {

    public init(_ value: Int) {
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
