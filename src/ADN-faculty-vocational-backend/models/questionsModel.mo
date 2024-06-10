// /models/SurveyModel.mo

import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Question "../schemas/questionSchema";
import Survey "../schemas/questionSchema";
import HashMap "mo:base/HashMap";





// // Define el tipo Question
// public type Question = {
//     id: Nat;     
//     response: Char;
// };

// Define el tipo Survey
// public type Survey = {
//     questions: [Question];
// };

// Actor que maneja las encuestas y las preguntas
actor {
    // Estado: Mapa para almacenar encuestas usando un ID de encuesta como clave
    var surveys: HashMap.HashMap<Text, Survey.Survey> = HashMap.HashMap<Text, Survey.Survey>(3, Text.equal, Text.hash);

    // Contador para generar IDs únicos para las encuestas
    var nextSurveyId: Nat = 0;

    // Función para guardar nueva encuesta
    public func createSurvey(questions: [Question.Question]): async Nat {
        // Generar un nuevo ID para la encuesta
        let surveyId = nextSurveyId;
        nextSurveyId += 1;

        // Guarda respuestas de una nueva encuesta
        let newSurvey : Survey.Survey = {
            questions = questions;
        };

        // Añadir las nuevas respuestas al almacenamiento
        surveys.put(Nat.toText(surveyId), newSurvey);

        return surveyId; // Retornar el ID de la nuevas Respuestas
    };

    // Función para obtener una encuesta por ID
    public query func getSurvey(surveyId: Nat): async ?Survey.Survey {
        return surveys.get(Nat.toText(surveyId));
    };

    // Función para añadir una pregunta a una encuesta existente
    // public func addQuestionToSurvey(surveyId: Nat, question: Question): async ?Survey {
    //     switch (surveys.get(surveyId)) {
    //         case (?existingSurvey) {
    //             // Añadir la nueva pregunta a la lista de preguntas
    //             let updatedSurvey = {
    //                 questions = Array.append([question], existingSurvey.questions);
    //             };

    //             // Actualizar la encuesta en el almacenamiento
    //             surveys.put(surveyId, updatedSurvey);
    //             return ?updatedSurvey;
    //         };
    //         case null {
    //             return null; // La encuesta no existe
    //         };
    //     }
    // };

    // Función para eliminar una Respuesta por ID
    public func deleteSurvey(surveyId: Nat): async Bool {
        return surveys.remove(Nat.toText(surveyId)) != null;
    };
}
