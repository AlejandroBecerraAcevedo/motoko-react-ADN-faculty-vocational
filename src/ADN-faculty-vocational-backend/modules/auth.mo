import Principal "mo:base/Principal";

module {
    
    public func isAuth(identity: Principal): Bool {
        return not Principal.isAnonymous(identity);
    };
}