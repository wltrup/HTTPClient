import Foundation

extension URLSession: HTTPLoader {

    public func load(request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        guard let url = request.url else {
            let error = HTTPError(
                code: .invalidRequest(.invalidURL),
                request: request,
                response: nil,
                underlyingError: nil
            )
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
                let error = HTTPError(
                    code: .invalidRequest(.invalidBody),
                    request: request,
                    response: nil,
                    underlyingError: nil
                )
                completion(.failure(error))
                return
            }

        }

        let dataTask = self.dataTask(with: urlRequest) { (data, response, error) in
            let result = self.makeHTTPResult(
                request: request,
                data: data,
                response: response,
                error: error
            )
            completion(result)
        }

        dataTask.resume()

    }

    private func makeHTTPResult(
        request: HTTPRequest,
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) -> HTTPResult {

        var httpResponse: HTTPResponse?

        if let r = response as? HTTPURLResponse {
            httpResponse = HTTPResponse(request: request, response: r, body: data)
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
            let httpError = HTTPError(
                code: code,
                request: request,
                response: httpResponse,
                underlyingError: e
            )
            return .failure(httpError)
        }

        // an error, but not a URL error
        else if let e = error {
            let httpError = HTTPError(
                code: .unknown,
                request: request,
                response: httpResponse,
                underlyingError: e
            )
            return .failure(httpError)
        }

        // no error, and an HTTPURLResponse
        else if let r = httpResponse {
            return .success(r)
        }

        // not an error, but also not an HTTPURLResponse
        else {
            let httpError = HTTPError(
                code: .invalidResponse,
                request: request,
                response: nil,
                underlyingError: error
            )
            return .failure(httpError)
        }

    }

}
