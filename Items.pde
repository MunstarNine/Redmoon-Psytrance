class Items extends VariablesGlobales{
  int colorChange = 250;  
  float tam = 30;
  PImage textura;
  boolean aux = false;
  float contadorAleatorio;
  Items(float size, PImage texture){
    setRandomPosition();
    tam = size;
    textura = texture;
  }
  void dibujar(){
    fill(colorChange);
    ellipse(posX+14.5,posY+15,tam+tam/2,tam+tam/2);
    image(textura, posX, posY, tam, tam);
    
  }
  void actualizar(){
    
    posX -= 4;
    if (colorChange > 50 && aux == false){
    colorChange-=5;
    if (colorChange <= 50){
      aux = true;
    }
  }
    else {
      colorChange+=5;
      if (colorChange >= 240){
        aux = false;
      }
    }
    }


  float getSize() {
    return tam;
  }
  void setSize(float tam_) {
     tam = tam_; 
  }
}
