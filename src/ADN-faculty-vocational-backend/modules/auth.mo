import Principal "mo:base/Principal";

module {
    
    public func isAuth(identity: Principal): Bool {
        return Principal.isAnonymous(identity);
    };
}