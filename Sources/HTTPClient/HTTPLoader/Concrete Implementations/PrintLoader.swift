

public class PrintLoader: HTTPLoader {

    public override func load(request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        print("Loading \(request)")
        super.load(request: request, completion: { result in
            print("Loaded: \(request)")
            print("Reeceived result: \(result)")
            completion(result)
        })

    }

}
