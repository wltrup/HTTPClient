import Foundation

public struct HTTPResponse {

    public let request: HTTPRequest
    public let body: Data?

    public init(request: HTTPRequest, response: HTTPURLResponse, body: Data? = nil) {
        self.request = request
        self.response = response
        self.body = body
    }

    private let response: HTTPURLResponse

}

extension HTTPResponse {

    public var statusCode: HTTPStatusCode {
        HTTPStatusCode(response.statusCode)
    }

    public var message: String {
        HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    }

    public var headers: [AnyHashable: Any] {
        response.allHeaderFields
    }

}
