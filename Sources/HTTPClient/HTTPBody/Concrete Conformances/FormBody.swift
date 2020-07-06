import Foundation

public struct FormBody: HTTPBody {

    public var isEmpty: Bool { values.isEmpty }
    public let additionalHeaders = [
        "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
    ]

    public init(_ values: [URLQueryItem]) {
        self.values = values
    }

    public init(_ values: [String: String]) {
        let queryItems = values.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        self.init(queryItems)
    }

    public func encode() throws -> Data {
        let pieces = values.map(self.urlEncode)
        let bodyString = pieces.joined(separator: "&")
        return Data(bodyString.utf8)
    }

    private let values: [URLQueryItem]

}

extension FormBody {

    private func urlEncode(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) ?? ""
    }

    private func urlEncode(_ queryItem: URLQueryItem) -> String {
        let name = urlEncode(queryItem.name)
        let value = urlEncode(queryItem.value ?? "")
        return "\(name)=\(value)"
    }

}
