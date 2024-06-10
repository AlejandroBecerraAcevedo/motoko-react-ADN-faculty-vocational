import ProfileProf "../schemas/profileProfSchema";
import Text "mo:base/Text";
import Float "mo:base/Float";



// Actor que gestiona los perfiles profesionales
module {
    // Estado: Mapa de perfiles, usando el nombre como clave
    //var profilesProf: HashMap.HashMap<Principal, ProfileProf.ProfileProf> = HashMap.HashMap<Principal, ProfileProf.ProfileProf>(3,Principal.equal, Principal.hash);

    
    // Función para crear un perfil y añadirlo al almacenamiento
    public query func createProfile(name: Text, puntaje: Float) : async ProfileProf.ProfileProf {
        // Crear el perfil
        let newProfile : ProfileProf.ProfileProf = {
            name = name;
            puntaje = puntaje;
        };

        // Añadir el perfil al almacenamiento
        //profilesProf.put(principal, newProfile);

        return newProfile;
    };

    // Función para obtener un perfil por el nombre
    // public query func getProfile(principal: Principal) : async ?ProfileProf.ProfileProf {
    //     return profilesProf.get(principal);
    // };

    // Función para actualizar un perfil
    // public func updateProfile(principal: Principal, name: Text, puntaje: Float) : async ?ProfileProf.ProfileProf {
    //     switch (profilesProf.get(principal)) {
    //         case (?existingProfile) {
    //             let updatedProfile: ProfileProf.ProfileProf = {
    //                 name = name; // No se permite cambiar el nombre
    //                 puntaje = puntaje; // Si se proporciona un puntaje, se actualiza
    //             };
                
    //             // Actualizar el perfil en el almacenamiento
    //             profilesProf.put(principal, updatedProfile);
    //             return ?updatedProfile;
    //         };
    //         case null {
    //             return null; // El perfil no existe
    //         };
    //     }
    // };

    // Función para eliminar un perfil
    // public func deleteProfile(principal: Principal) : async Bool {
    //     return profilesProf.remove(principal) != null;
    // }
}
