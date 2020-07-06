import Foundation

public typealias HTTPResultHandler = (HTTPResult) -> Void

public protocol HTTPLoader {

    func load(request: HTTPRequest, completion: @escaping HTTPResultHandler)

}
