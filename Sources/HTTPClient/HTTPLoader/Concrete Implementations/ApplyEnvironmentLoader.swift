import Foundation

public class ApplyEnvironmentLoader: HTTPLoader {

    public init(environment: ServerEnvironment) {
        self.environment = environment
        super.init()
    }

    private let environment: ServerEnvironment

    override public func load(_ request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        var copy = request

        if copy.host?.isEmpty ?? true {
            copy.host = environment.host
        }

        if copy.path.hasPrefix("/") == false {
            // TODO: apply the environment.pathPrefix
        }

        // TODO: apply the query items from the environment

        for (header, value) in environment.headers {
            // TODO: add these header values to the request
        }

        super.load(copy, completion: completion)

    }

}
