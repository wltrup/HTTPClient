import Foundation

public struct EmptyBody: HTTPBody {

    public let isEmpty = true

    public init() {}

    public func encode() throws -> Data { Data() }

}
