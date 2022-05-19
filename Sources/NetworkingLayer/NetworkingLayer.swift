public struct NetworkingLayer {
    static public func enableLogs() {
        #if DEBUG
        isLogEnabled = true
        #endif
    }
}
