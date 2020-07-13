import Dispatch

public class ResetGuardLoader: HTTPLoader {

    public override func load(_ request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        if isResetting.value == false {
            super.load(request, completion: completion)
        } else {
            let error = HTTPError(.resetInProgress, request)
            completion(.failure(error))
        }

    }

    public override func reset(with group: DispatchGroup) {

        if isResetting.value == true { return }
        guard let next = nextLoader else { return }

        group.enter()
        isResetting.value { $0 = true }
        next.reset {
            self.isResetting.value { $0 = false }
            group.leave()
        }

    }

    private var isResetting = SynchronizedBarrier(false)

}
