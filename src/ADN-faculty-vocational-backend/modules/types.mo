import Result "mo:base/Result";


module {

    private type GetNameResultSuccess = Text;
    private type SetNameResultSuccess = Bool;
    private type GetProfileResultSuccess = Text;

    private type GetProfileResultError = {
        #profileAlreadyDontExist;
        
    };
    
    private type GetNameResultErrors = {
        #nameIsNull;
        #userNotAuthenticated;
    };

    private type SetNameResultErrors = {
        #userNotAuthenticated;
    };

    public type SetNameResult = Result.Result<SetNameResultSuccess, SetNameResultErrors>;
    public type GetNameResult = Result.Result<GetNameResultSuccess, GetNameResultErrors>;
    public type GetProfileResult = Result.Result<GetProfileResultSuccess, GetProfileResultError>;

}