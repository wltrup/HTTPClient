import Foundation

public protocol HTTPLoader {

    func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void)

}
