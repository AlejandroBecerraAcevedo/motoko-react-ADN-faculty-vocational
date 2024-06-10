import Text "mo:base/Text";
module {
    public type Profile = {
        username: Text;
        bio: ?Text;
        age: Nat;
        email: ?Text;
    };

    // Función para crear un perfil
    public func createProfile(username: Text, bio: ?Text, age: Nat, email: ?Text) : Profile {
        return {
            username = username;
            bio = bio;            
            age = age;
            email = email;            
        };
    };
};