import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Map "mo:base/HashMap";
import Types "modules/types";
import Text "mo:base/Text";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Auth "modules/auth";
import Survey "schemas/questionSchema";
import ProfileProf "schemas/profileProfSchema";
import ProfileSchema "schemas/profileSchema";



actor {

  var profilesProf: Map.HashMap<Text, ProfileProf.ProfileProf> = Map.HashMap<Text, ProfileProf.ProfileProf>(0,Text.equal, Text.hash);
  var surveys: Map.HashMap<Text, Survey.Survey> = Map.HashMap<Text, Survey.Survey>(0, Text.equal, Text.hash);
  var profiles: Map.HashMap<Text, ProfileSchema.Profile> = Map.HashMap<Text, ProfileSchema.Profile>(0, Text.equal, Text.hash);
  
  public func createProfilePersonal(username: Text, bio: ?Text, age: Nat, email: ?Text): async Nat {
    

    // Guarda Perfil del usuario en una variable
    let newProfile = ProfileSchema.createProfile(username: Text, bio: ?Text, age: Nat, email: ?Text);
    profiles.put(username, newProfile);   

    return profiles.size(); // Retornar el ID de la nuevas Respuestas
  };

  public func getProfile(username: Text): async ?ProfileSchema.Profile {     
    //let profile: ?ProfileSchema.Profile = profiles.get("A");
    return  profiles.get(username); // Retornar el Perfil
  };








  public shared ({caller}) func getAllResponses(): async (Types.GetProfileResult) {
    if (Auth.isAuth(caller)) return #err(#userNotAuthenticated);
    

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
 

   // Crear un buffer de floats para almacenar los porcentajes
    let size: Float = Float.fromInt(ConteoA+ConteoB+ConteoC+ConteoD); // Convertir el tamaño del buffer a Float

    // Mapear cada valor en el buffer a un porcentaje
    let percent = Buffer.map<Nat, Float>(count, func (x) {
        Float.fromInt(x) / size * 100.0; // Convertir cada elemento a Float y calcular el porcentaje
    });

    //Crear el perfil vocacional

    let newProfile = ProfileProf.createProfileProf ("EDUCACION", percent.get(0));
    let newProfile1 = ProfileProf.createProfileProf ("ARTES", percent.get(1));
    let newProfile2 = ProfileProf.createProfileProf ("EXACTAS", percent.get(2));
    let newProfile3 = ProfileProf.createProfileProf ("INGENIERIA", percent.get(3));

    profilesProf.put("E", newProfile);
    profilesProf.put("A", newProfile1);
    profilesProf.put("M", newProfile2);
    profilesProf.put("I", newProfile3);

    let globalScore = Buffer.toText(percent, Float.toText);

    // Convertir el buffer a un arreglo y devolverlo
    return #ok(globalScore);
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
    
    if (surveys.size() > 0) {
      ignore surveys.replace("0", newSurvey);
    }else{
      surveys.put(Nat.toText(surveyId), newSurvey);
    };

    return newSurvey; // Retornar el ID de la nuevas Respuestas
  };


  public query ({caller}) func getAllScores(): async Types.GetScoreResult {

    if (Auth.isAuth(caller)) return #err(#userNotAuthenticated);
    

    switch(?profilesProf) {
      case(null) {
        return #err(#nameIsNull);
      };
      case(?myVar) {
        // Obtén el iterador de valores del HashMap
        let iterator = profilesProf.vals();
        // Convierte el iterador a una lista
        let profilesArray: [ProfileProf.ProfileProf] = Iter.toArray(iterator);

        // Convertir cada ProfileProf a Text
        let profilesText: [Text] = Array.map(profilesArray, func (profile: ProfileProf.ProfileProf) : Text {
            return "Name: " # profile.name # ", Score: " # Float.toText(profile.puntaje);
        });

        // Unir todos los textos en una sola cadena
        return #ok(profilesText);

        //return #ok(profilesArray.toText());
      };
    }    
  };

 


  stable var _name: ?Text = null;


  public query ({caller}) func greet(name : ?Text) : async Types.GetNameResult {
    if (Auth.isAuth(caller)) return #err(#userNotAuthenticated);

    switch(name) {
      case(null) {
        return #err(#nameIsNull);
      };
      case(?myVar) {
        return #ok(myVar);
      };
    }    
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

}

