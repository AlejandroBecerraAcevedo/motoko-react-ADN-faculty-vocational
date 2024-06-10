module {

  // Define el tipo Profile
  public type ProfileProf = {
    name : Text;
    puntaje : Float;
  };

  // Función para crear un nuevo perfil
  public func createProfileProf(name: Text, puntaje: Float): ProfileProf {
    return {
      name = name;
      puntaje = puntaje;
    };
  };

};
