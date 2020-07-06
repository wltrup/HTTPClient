

open class MockLoader: HTTPLoader {

    open override func load(request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        let error = HTTPError(
            code: .cannotConnect,
            request: request,
            response: nil,
            underlyingError: "base mock handler"
        )
        completion(.failure(error))

    }

}
