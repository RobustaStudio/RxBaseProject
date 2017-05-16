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
