

public struct HTTPStatus: Hashable {

    public init(_ value: Int) {
        self.value = value
    }

    private let value: Int

}

extension HTTPStatus: CustomStringConvertible {

    public var description: String {
        "\(value)"
    }

}
