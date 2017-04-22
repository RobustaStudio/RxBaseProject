enum ResponseStatus {
    case OK
    case Failed(message: String)
}

extension ResponseStatus: Equatable {}

func == (lhs: ResponseStatus, rhs: ResponseStatus) -> Bool {
    switch (lhs,rhs) {
    case (.OK, .OK):
        return true
    case (.Failed(let x), .Failed(let y))
        where x == y:
        return true
    default:
        return false
    }
}
