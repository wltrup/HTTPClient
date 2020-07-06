

public struct HTTPMethod: Hashable {

    public static let get = HTTPMethod("GET")
    public static let post = HTTPMethod("POST")
    public static let put = HTTPMethod("PUT")
    public static let delete = HTTPMethod("DELETE")

    public init(_ name: String) {
        self.name = name
    }

    public let name: String

}

extension HTTPMethod: CustomStringConvertible {

    public var description: String {
        name
    }

}
