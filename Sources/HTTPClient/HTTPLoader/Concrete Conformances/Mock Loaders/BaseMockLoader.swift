import Foundation

public class BaseMockLoader: HTTPLoader {

    public func load(request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        let error = HTTPError(
            code: .cannotConnect,
            request: request,
            response: nil,
            underlyingError: "no-op base mock handler"
        )
        completion(.failure(error))

    }

}

extension String: Error {}
