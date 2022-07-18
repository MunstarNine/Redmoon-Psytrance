class Planeta extends VariablesGlobales {
     
    PImage textura;  
    boolean aparicion;
    Planeta (PImage texture, float vel){
      textura = texture;
      setRandomPosition();
      setSpeed(vel);
    }
    
    void dibujar (){
      image(textura, posX, posY);
    }
    void actualizar(){
      posX -=speed;
    }
    void setAparicion(boolean aux){
      aparicion = aux;
    }
    boolean getAparicion(){
      return aparicion;
    }
}
