import Map "mo:base/HashMap";
import ProfileSchema "../schemas/profileSchema";
import Text "mo:base/Text";

// Actor que maneja los perfiles de usuario
actor ProfileManager {

    // Estado: Mapa para almacenar perfiles usando el ID como clave
    var profiles: Map.HashMap<Text, ProfileSchema.Profile> = Map.HashMap<Text, ProfileSchema.Profile>(1,Text.equal, Text.hash);

    // Crear un nuevo perfil
    public func createProfile(username: Text, bio: ?Text, email: Text, age: Nat, social: [ProfileSchema.SocialNetwork]): async ProfileSchema.Profile {
        let newProfile = ProfileSchema.createProfile(username, bio, email, age, social);
        profiles.put(username, newProfile);

        return newProfile;
    };

    // Obtener un perfil por ID
    public query func getProfile(username: Text): async ?ProfileSchema.Profile {
        return profiles.get(username);
    };

    // Actualizar un perfil por ID
    public func updateProfile(username: Text, bio: ?Text, email: Text, age: Nat, social: [ProfileSchema.SocialNetwork]): async ?ProfileSchema.Profile {
        switch (profiles.get(username)) {

            case (?profile) {
                let updatedProfile = { profile with username = username; bio = bio; email = email; age = age; social = social };
                profiles.put(username, updatedProfile);
                return ?updatedProfile;
            };

            case null { return null; };
        };
    };

    // Eliminar un perfil por ID
    public func deleteProfile(username: Text): async ?ProfileSchema.Profile {
        return profiles.remove(username);
    };
}