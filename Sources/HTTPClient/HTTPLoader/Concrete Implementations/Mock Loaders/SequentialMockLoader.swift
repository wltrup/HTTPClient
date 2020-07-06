

public typealias MockHandler = (HTTPRequest, HTTPResultHandler) -> Void

public class SequentialMockLoader: MockLoader {

    public override func load(_ request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        if handlers.isEmpty == false {
            let handler = handlers.removeFirst()
            handler(request, completion)
        } else {
            let error = HTTPError(.cannotConnect, request, nil, "no more mock handlers")
            completion(.failure(error))
        }

    }

    @discardableResult
    public func then(_ handler: @escaping MockHandler) -> MockLoader {
        handlers.append(handler)
        return self
    }

    private var handlers = Array<MockHandler>()

}
