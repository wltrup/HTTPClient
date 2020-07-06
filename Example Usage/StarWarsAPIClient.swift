import HTTPClient

public class StarWarsAPIClient {

    public func requestPeople(/* completion: @escaping (...) -> Void */) {

        var r = HTTPRequest()
        r.host = "swapi.dev"
        r.path = "/api/people"

        loader.load(request: r) { (result: HTTPResult) in
            // TODO: interpret the result
            // completion(...)
        }

    }

    private let loader: HTTPLoader = URLSession.shared

}
