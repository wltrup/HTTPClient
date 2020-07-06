

open class MockLoader: HTTPLoader {

    open override func load(_ request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        let error = HTTPError(.cannotConnect, request, nil, "base mock handler")
        completion(.failure(error))

    }

}
