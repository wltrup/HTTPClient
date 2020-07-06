

public class ModifiedRequestLoader: HTTPLoader {

    public init(_ requestModifier: @escaping (HTTPRequest) -> HTTPRequest) {
        self.requestModifier = requestModifier
        super.init()
    }

    public override func load(_ request: HTTPRequest, completion: @escaping HTTPResultHandler) {
        let modifiedRequest = requestModifier(request)
        super.load(modifiedRequest, completion: completion)
    }

    private let requestModifier: (HTTPRequest) -> HTTPRequest

}
