import ProfileSchema "../schemas/profileSchema";
import Map "mo:base/HashMap";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Types "../modules/types";
import Auth "../modules/auth";
import main "../main"

// Actor que maneja los perfiles de usuario
module {

    // Estado: Mapa para almacenar perfiles usando el ID como clave
    var profiles: Map.HashMap<Principal, ProfileSchema.Profile> = Map.HashMap<Principal, ProfileSchema.Profile>(2, Principal.equal, Principal.hash);
     


    // Crear un nuevo perfil
    public func createProfile(principal: Principal, username: Text, bio: ?Text,age: Nat, email: Text): async (ProfileSchema.Profile) {
        let newProfile = ProfileSchema.createProfile(username, bio, age, ?email);
        //profiles.put(principal, newProfile);

        return newProfile;
    };

    // Obtener un perfil por ID
    public shared query ({caller}) func getName(): async (Types.GetNameResult) {
        if (Auth.isAuth(caller)) return #err(#userNotAuthenticated);
       
        let profile: ?ProfileSchema.Profile = profiles.get(caller);

        switch(profile) {
            case(null) {
                return #err(#nameIsNull);
            };
            case(?profile) {
                return #ok(profile.username);
            };
        }
    };

    // Actualizar un perfil por ID
    public shared func updateProfile(principal: Principal, username: Text, bio: ?Text, age: Nat,email: Text ): async (Types.GetNameResult) {
        
        if (Auth.isAuth(principal)) return #err(#userNotAuthenticated);
        
        switch (profiles.get(principal)) {

            case (?profile) {
                let updatedProfile = { profile with username = username; bio = bio; age = age; email = ?email};
                profiles.put(principal, updatedProfile);
                return #ok("ok");
            };

            case null { return (#err(#nameIsNull)); };
        };
    };

    // Eliminar un perfil por ID
    public shared func deleteProfile(principal: Principal): async (?ProfileSchema.Profile) {
        return profiles.remove(principal);
    };
};