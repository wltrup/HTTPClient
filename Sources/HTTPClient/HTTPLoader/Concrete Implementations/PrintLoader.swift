

public class PrintLoader: HTTPLoader {

    public override func load(_ request: HTTPRequest, completion: @escaping HTTPResultHandler) {

        print("Loading \(request)")
        super.load(request, completion: { result in
            print("Loaded: \(request)")
            print("Reeceived result: \(result)")
            completion(result)
        })

    }

}
