import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Map "mo:base/HashMap";
import Types "modules/types";
import Text "mo:base/Text";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Auth "modules/auth";
import Schema "schemas/profileSchema";
import Survey "schemas/questionSchema";
//import ProfileProfModel "models/profileProfModel";
import ProfileProf "schemas/profileProfSchema";



actor {

  var profilesProf: Map.HashMap<Principal, ProfileProf.ProfileProf> = Map.HashMap<Principal, ProfileProf.ProfileProf>(3,Principal.equal, Principal.hash);
  var surveys: Map.HashMap<Text, Survey.Survey> = Map.HashMap<Text, Survey.Survey>(3, Text.equal, Text.hash);




      // let count = Buffer.Buffer<Nat>(0);

      //  var ConteoA: Nat = 0;
      //  var ConteoB: Nat = 0;
      //  var ConteoC: Nat = 0;
      //  var ConteoD: Nat = 0;
      
      // var responses = Buffer.Buffer<Text>(1);

      //responses.add(getAllResponses());  

  

  

      // Función para contar la frecuencia de cada respuesta
    // public query func countResponses(): async [Nat] {

        
      

    //   for (response in responses.vals()) {

    //     switch(response) {

    //       case("A") {
    //         ConteoA += 1;
    //       };

    //       case("B") {
    //         ConteoB += 1;
    //       };

    //       case("C") {
    //         ConteoC += 1;
    //       };

    //       case("D") {
    //         ConteoD += 1;
    //       };

    //       case null {
    //         null
    //       };
    //     };

    //     count.add(ConteoA);
    //     count.add(ConteoB);
    //     count.add(ConteoC);
    //     count.add(ConteoD);

    //   };
    //     return Buffer.toArray<Nat>(responseBuffer);
    // };

    // Función para calcular el porcentaje de cada respuesta
    // public func calculateResponsePercentages(): async { [Char]: Float } {
    //     let responseCounts = await countResponses();
    //     var responsePercentages: { [Char]: Float } = {};
    //     let totalResponses = Buffer.size(await getAllResponses());

    //     for ((response, count) in responseCounts.entries()) {
    //         responsePercentages[response] := (Float.fromInt(Nat.toInt(count)) / Float.fromInt(Nat.toInt(totalResponses))) * 100.0;
    //     }
    //     return responsePercentages;
    // };















  public query func getAllResponses(): async ([Nat]) {

     var ConteoA: Nat = 0;
     var ConteoB: Nat = 0;
     var ConteoC: Nat = 0;
     var ConteoD: Nat = 0;

    let count = Buffer.Buffer<Nat>(0);

    // Crear un buffer para almacenar las respuestas
    let responseBuffer = Buffer.Buffer<Text>(0);

    // Recorrer todas las encuestas y preguntas para agregar las respuestas al buffer
    for (survey in surveys.vals()) {
      for (question in survey.questions.vals()) {
        // Agregar la respuesta al buffer
        responseBuffer.add(question.response);

         if (question.response == "A") {           
              ConteoA += 1;
            } else if (question.response == "B"){
               ConteoB += 1;
            } else if (question.response == "C"){
               ConteoC += 1;
            } else if (question.response == "D"){
               ConteoD += 1;
            };         
             
           
         };

          count.add(ConteoA);
          count.add(ConteoB);
          count.add(ConteoC);
          count.add(ConteoD);
      };
    

    // Convertir el buffer a un arreglo y devolverlo
    return Buffer.toArray<Nat>(count);
    //return responseBuffer;
  };
  


  var nextSurveyId: Nat = 0;

  public func createSurvey(questions: [Survey.Question]): async Survey.Survey {
    // Generar un nuevo ID para la encuesta
    let surveyId = nextSurveyId;
    nextSurveyId += 1;

    // Guarda respuestas de una nueva encuesta
    let newSurvey = Survey.createEncuesta(questions);

    // Añadir las nuevas respuestas al almacenamiento
    surveys.put(Nat.toText(surveyId), newSurvey);

    return newSurvey; // Retornar el ID de la nuevas Respuestas
  };




  public shared query ({caller}) func crateProfilesProf(name : Text, score: Float) : async (Text) {

    let newProfile = ProfileProf.createProfileProf (name, score);

    profilesProf.put(caller, newProfile);
     return "Hello, " # name # "!";
  };

  














  stable var _name: ?Text = null;


  public query func greet(name : Text) : async Text {
     return "Hello, " # name # "!";
  };
 
  public query ({caller}) func whoAmI(): async Principal {
    return caller;
  };

  public query ({caller}) func getName(): async (Types.GetNameResult) {
    if (Auth.isAuth(caller)) return #err(#userNotAuthenticated);
    switch(_name) {
      case(null) {
        return #err(#nameIsNull);
      };
      case(?myVar) {
        return #ok(myVar);
      };
    }
  };

  public shared ({caller}) func setName(name: Text): async Types.SetNameResult {
    if (Auth.isAuth(caller)) return #err(#userNotAuthenticated);

    _name := ?name;

    return #ok(true);
  };

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////



  // let rodrigo: Schema.Profile = {
  //   username = "rodrigo";
  //   bio = ?"Software Developer";
  //   age = 21;
  //   email = ?"https://www.facebook.com";    
  // };

  // let maribel: Schema.Profile = {
  //   username = "maribel";
  //   bio = ?"Software Developer";
  //   age = 20;
  //   email = ?"https://www.facebook.com";
    
  // };

  // let prof = Map.HashMap<Text, Schema.Profile>(1, Text.equal, Text.hash);

  
  // prof.put("rodrigo", rodrigo);

  // let rodri: ?Schema.Profile = prof.get("rodrigo");

  // public query func getProfileRodri(): async (Types.GetProfileResult) {
  //   switch(rodri) {

  //     case(null) {
  //       return #err(#profileAlreadyDontExist);
  //     };

  //     case(?rodri) {
  //       return #ok("Already exist");
  //     };
  //   }
  // };

  // // Validar si rodri existe

  // let mari = prof.get("maribel");

  // public query func getProfileMari(): async (Types.GetProfileResult) {
  //   switch(mari) {

  //     case(null) {
  //       return #err(#profileAlreadyDontExist);
  //     };

  //     case(?mari) {
  //       return #ok("Already exist");
  //     };
  //   }
  // };

  // Validar si mari existe
}

