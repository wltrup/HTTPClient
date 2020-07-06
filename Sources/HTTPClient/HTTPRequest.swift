import Foundation

public struct HTTPRequest {

    public var method: HTTPMethod = .get
    public var headers: [String: String] = [:]
    public var body: HTTPBody = EmptyBody()

    public init() {
        urlComponents.scheme = "https"
    }

    private var urlComponents = URLComponents()

}

// MARK: - Convenience API

extension HTTPRequest {

    public var url: URL? {
        urlComponents.url
    }

    public var scheme: String {
        urlComponents.scheme ?? "https"
    }

    public var host: String? {
        get { urlComponents.host }
        set { urlComponents.host = newValue }
    }

    public var path: String {
        get { urlComponents.path }
        set { urlComponents.path = newValue }
    }

}
