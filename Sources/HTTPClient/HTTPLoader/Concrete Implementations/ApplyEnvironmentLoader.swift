import Foundation

public class ApplyEnvironmentLoader: HTTPLoader {

    public init(environment: ServerEnvironment) {
        self.environment = environment
        super.init()
    }

    private let environment: ServerEnvironment

    override public func load(_ request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        var copy = request

        let requestEnvironment = request.serverEnvironment ?? environment

        if copy.host?.isEmpty ?? true {
            copy.host = requestEnvironment.host
        }

        if copy.path.hasPrefix("/") == false {
            // TODO: apply the requestEnvironment.pathPrefix
        }

        // TODO: apply the query items from requestEnvironment

        for (header, value) in requestEnvironment.headers {
            // TODO: add these header values to the request
        }

        super.load(copy, completion: completion)

    }

}
