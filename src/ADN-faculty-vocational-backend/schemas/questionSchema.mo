module {


    // Define the type Survey
    public type Survey = {
        questions : [Question];
    };


    // Define the type Question
    public type Question = {
        id : Nat;        
        response : Char;
    };


    // Función para crear una nueva encuesta
    public func createEncuesta(questions : [Question]) : Survey = {
        questions = questions;
    };

};

