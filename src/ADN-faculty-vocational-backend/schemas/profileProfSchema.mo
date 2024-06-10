module {

  // Define el tipo Profile
  public type ProfileProf = {
    name : Text;
    puntaje : Float;
  };

  // Función para crear un nuevo perfil
  public func createProfile(name : Text, puntaje : Float) : ProfileProf = {
    name = name;
    puntaje = puntaje;
  };

};
