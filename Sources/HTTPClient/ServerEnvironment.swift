import Foundation

public struct ServerEnvironment {

    public var host: String
    public var pathPrefix: String
    public var headers: [String: String]
    public var query: [URLQueryItem]

    public init(
        host: String,
        pathPrefix: String = "/",
        headers: [String: String] = [:],
        query: [URLQueryItem] = []
    ) {

        // make sure the pathPrefix starts with a /
        let prefix = pathPrefix.hasPrefix("/") ? "" : "/"

        self.host = host
        self.pathPrefix = prefix + pathPrefix
        self.headers = headers
        self.query = query

    }

}