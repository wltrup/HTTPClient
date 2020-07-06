import Foundation

public struct HTTPResponse {

    public let request: HTTPRequest
    public let body: Data?

    public init(
        _ request: HTTPRequest,
        _ response: HTTPURLResponse,
        _ body: Data? = nil
    ) {
        self.request = request
        self.response = response
        self.body = body
    }

    private let response: HTTPURLResponse

}

// MARK: - Convenience API

extension HTTPResponse {

    public var statusCode: HTTPStatusCode {
        HTTPStatusCode(value: response.statusCode)
    }

    public var message: String {
        HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    }

    public var headers: [AnyHashable: Any] {
        response.allHeaderFields
    }

}
