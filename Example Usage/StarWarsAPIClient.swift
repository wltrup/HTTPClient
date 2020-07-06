import HTTPClient

public class StarWarsAPIClient {

    public init(_ loader: HTTPLoader = URLSessionLoader()) {

        let modifier = ModifiedRequestLoader { request in
            var copy = request
            if copy.host.isEmpty { copy.host = "swapi.dev" }
            if copy.path.hasPrefix("/") == false { copy.path = "/api/" + copy.path }
            return copy
        }

        self.loader = modifier |> loader

    }

    private let loader: HTTPLoader

}

// MARK: - Request API

extension StarWarsAPIClient {

    public func requestPeople(/* completion: @escaping (...) -> Void */) {

        let request = HTTPRequest(path: "people")
        loader.load(request) { (result: HTTPResult) in
            // TODO: interpret the result
            // completion(...)
        }

    }

}

// MARK: - ServerEnvironment API

extension ServerEnvironment {

    public static let development = ServerEnvironment(
        host: "development.example.com",
        pathPrefix: "/api-dev"
    )

    public static let qa = ServerEnvironment(
        host: "qa-1.example.com",
        pathPrefix: "/api"
    )

    public static let staging = ServerEnvironment(
        host: "api-staging.example.com",
        pathPrefix: "/api"
    )

    public static let production = ServerEnvironment(
        host: "api.example.com",
        pathPrefix: "/api"
    )

}
