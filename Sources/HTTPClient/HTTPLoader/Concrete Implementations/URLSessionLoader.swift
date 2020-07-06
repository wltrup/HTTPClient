import Foundation

public final class URLSessionLoader: HTTPLoader {

    public init(_ session: URLSession = .shared) {
        self.session = session
    }

    public override func load(_ request: HTTPRequest, completion: @escaping HTTPResultHandler) {
        _load(request, completion: completion)
    }

    private let session: URLSession

}

// MARK: - Private API

extension URLSessionLoader {

    private func _load(_ request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        guard let url = request.url else {
            let error = HTTPError(.invalidRequest(.invalidURL), request)
            completion(.failure(error))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.name

        // add custom HTTP headers from the request
        for (header, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }

        if request.body.isEmpty == false {

            // add custom HTTP headers from the body
            for (header, value) in request.body.additionalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: header)
            }

            do { urlRequest.httpBody = try request.body.encode() } catch {
                let error = HTTPError(.invalidRequest(.invalidBody), request)
                completion(.failure(error))
                return
            }

        }

        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            let result = self.makeHTTPResult(request, data, response, error)
            completion(result)
        }

        dataTask.resume()

    }

    private func makeHTTPResult(
        _ request: HTTPRequest,
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?
    ) -> HTTPResult {

        var httpResponse: HTTPResponse?

        if let r = response as? HTTPURLResponse {
            httpResponse = HTTPResponse(request, r, data)
        }

        // an URL error
        if let e = error as? URLError {
            let code: HTTPError.Code
            switch e.code {

                case .badURL:
                    code = .invalidRequest(.invalidURL)

                //                case .unsupportedURL: code = ...
                //                case .cannotFindHost: code = ...
                //                ...

                default:
                    code = .unknown

            }
            let httpError = HTTPError(code, request, httpResponse, e)
            return .failure(httpError)
        }

            // an error, but not a URL error
        else if let e = error {
            let httpError = HTTPError(.unknown, request, httpResponse, e)
            return .failure(httpError)
        }

            // no error, and an HTTPURLResponse
        else if let r = httpResponse {
            return .success(r)
        }

            // not an error, but also not an HTTPURLResponse
        else {
            let httpError = HTTPError(.invalidResponse, request, nil, error)
            return .failure(httpError)
        }

    }

}
