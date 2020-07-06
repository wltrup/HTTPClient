

public struct HTTPStatusCode: Hashable {

    public init(_ value: Int) {
        self.value = value
    }

    public let value: Int

}

extension HTTPStatusCode: CustomStringConvertible {

    public var description: String {
        "\(value)"
    }

}
