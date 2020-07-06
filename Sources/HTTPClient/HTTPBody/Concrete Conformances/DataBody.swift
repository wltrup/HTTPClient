import Foundation

public struct DataBody: HTTPBody {

    public var isEmpty: Bool { data.isEmpty }
    public var additionalHeaders: [String: String]

    public init(_ data: Data, additionalHeaders: [String: String] = [:]) {
        self.data = data
        self.additionalHeaders = additionalHeaders
    }

    public func encode() throws -> Data { data }

    private let data: Data

}
