class Nave extends VariablesGlobales {
  float vidaMax;
  float vida;
  float velUp, velDown;
  PImage textura;
  float tam;
  private Nave(float tam_,float life, float posx, float posy, PImage textures, float maxLife) {
    tam=tam_;
    vida = life;
    vidaMax = maxLife;
    super.posX = posx;
    super.posY = posy;
    textura = textures;
    
  }
  float getVida() {
    return vida;
  }

    void setVida(float life) {
    vida = life;
  }
  void setImage(PImage imagen) {
    textura = imagen;
  }
   float getVidaMax(){
     return vidaMax;
   }
  void dibujar() {
    image(textura,posX,posY, 50, 50);
  }
     float getSize(){
  return tam;
  }
}
