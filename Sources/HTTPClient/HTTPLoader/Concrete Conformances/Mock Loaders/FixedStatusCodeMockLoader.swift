import Foundation

public class FixedStatusCodeMockLoader: BaseMockLoader {

    public let statusCode: HTTPStatusCode

    public init(statusCode: HTTPStatusCode) {
        self.statusCode = statusCode
    }

    public override func load(request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        let urlResponse = HTTPURLResponse(
            url: request.url!,
            statusCode: statusCode.value,
            httpVersion: "1.1",
            headerFields: nil
        )
        let response = HTTPResponse(request: request, response: urlResponse!, body: nil)
        completion(.success(response))

    }

}
