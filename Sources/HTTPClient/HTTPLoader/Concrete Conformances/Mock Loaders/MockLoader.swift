import Foundation

public typealias MockHandler = (HTTPRequest, HTTPResultHandler) -> Void

public class MockLoader: BaseMockLoader {

    public override func load(request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        if handlers.isEmpty == false {
            let handler = handlers.removeFirst()
            handler(request, completion)
        } else {
            let error = HTTPError(
                code: .cannotConnect,
                request: request,
                response: nil,
                underlyingError: "no more mock handlers"
            )
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
