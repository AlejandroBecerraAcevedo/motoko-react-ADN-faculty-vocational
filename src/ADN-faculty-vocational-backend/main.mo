import Principal "mo:base/Principal";
import Map "mo:base/HashMap";
import Types "modules/types";
import Text "mo:base/Text";
import Auth "modules/auth";
import Schema "schemas/profileSchema";


actor {














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

