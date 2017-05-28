public enum ResponseStatus {
    case OK(message:String)
    case Failed(message: String)
}

extension ResponseStatus: Equatable {}

public func == (lhs: ResponseStatus, rhs: ResponseStatus) -> Bool {
    switch (lhs,rhs) {
    case (.OK(let x), .OK(let y))
        where x == y:
        return true
    case (.Failed(let x), .Failed(let y))
        where x == y:
        return true
    default:
        return false
    }
}

public struct ResponseStatusWithPayload {
    public var status:ResponseStatus
    public var payload:Any?
    
    public init(status:ResponseStatus, payload:Any?) {
        self.status = status
        self.payload = payload
    }
}
