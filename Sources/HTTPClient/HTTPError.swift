

public struct HTTPError: Error {

    public let code: Code
    public let request: HTTPRequest
    public let response: HTTPResponse?
    public let underlyingError: Error?

    public init(
        _ code: Code,
        _ request: HTTPRequest,
        _ response: HTTPResponse? = nil,
        _ underlyingError: Error? = nil
    ) {
        self.code = code
        self.request = request
        self.response = response
        self.underlyingError = underlyingError
    }

    public enum Code {
        case invalidRequest(InvalidRequest) // the HTTPRequest could not be turned into a URLRequest
        case cannotConnect                  // some sort of connectivity problem
        case cancelled                      // the user cancelled the request
        case insecureConnection             // couldn't establish a secure connection to the server
        case invalidResponse                // the system did not receive a valid HTTP response
        // ...                              // other scenarios we may wish to expose; fill them in as necessary
        case resetInProgress                // the loader is resetting its state
        case unknown                        // we have no idea what the problem is
    }

    public enum InvalidRequest {
        case invalidURL
        case invalidBody
        case unknown
    }

}
