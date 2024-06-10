import Result "mo:base/Result";


module {

    private type GetNameResultSuccess = Text;
    private type SetNameResultSuccess = Bool;
    private type GetProfileResultSuccess = Text;
    private type SetProfileResultSuccess = Text;
    private type GetScoreResultSuccess = [Text];


    private type GetScoreResultError = {
        #userNotAuthenticated;
        #profileAlreadyDontExist;
        #nameIsNull
        
    };


    private type GetProfileResultError = {
        #profileAlreadyDontExist;
        #userNotAuthenticated
        
    };

    private type SetProfileResultError = {
        #profileAlreadyExist;
        #userNotAuthenticated;
        #nameIsNull;
        
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
    public type SetProfileResult = Result.Result<SetProfileResultSuccess, SetProfileResultError>;
    public type GetScoreResult = Result.Result<GetScoreResultSuccess, GetScoreResultError>;


}