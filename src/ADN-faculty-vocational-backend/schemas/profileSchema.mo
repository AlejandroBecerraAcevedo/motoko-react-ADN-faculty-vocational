module {
    public type Profile = {
        username: Text;
        bio: ?Text;
        age: Nat;
        social: [SocialNetwork];
    };

    public type SocialNetwork = {
        name: Text;
        url: Text;
    };

    // Función para crear un perfil
    public func createProfile(username: Text, bio: ?Text, email: Text, age: Nat, social: [SocialNetwork]) : Profile {
        return {
            username = username;
            bio = bio;
            email = email;
            age = age;
            social = social;
        };
    }
}