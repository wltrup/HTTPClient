import HTTPClient

public class StarWarsAPIClient {

    public init(_ loader: HTTPLoader = URLSessionLoader()) {
        self.loader = loader
    }

    private let loader: HTTPLoader

}

extension StarWarsAPIClient {

    public func requestPeople(/* completion: @escaping (...) -> Void */) {

        var r = HTTPRequest()
        r.host = "swapi.dev"
        r.path = "/api/people"

        loader.load(request: r) { (result: HTTPResult) in
            // TODO: interpret the result
            // completion(...)
        }

    }

}
