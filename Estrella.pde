class Estrella extends VariablesGlobales{
 
  float speed;
  float tam;
  int r,g,b;
  float ale;
  color setColor = color(r,g,b);
  Estrella(float posx, float posy,float size) {
    tam = size;
    super.posX = posx;
    super.posY = posy;
    ale = random(10);
    switch (parseInt(ale)){
      
      case 0:{r=140;g=238;b=255;  break;}
      case 1:{r=255;g=134;b=163;  break;}
      case 2:{r=132;g=132;b=132;  break;}
      case 3:{r=255;g=200;b=200;  break;}
      case 4:{r=200;g=200;b=255;  break;}
      case 5:{r=200;g=255;b=200;  break;}
      case 6:{r=255;g=255;b=255;  break;}
      case 7:{r=255;g=255;b=255;  break;}
      case 8:{r=255;g=255;b=255;  break;}
      case 9:{r=255;g=255;b=255;  break;}
      
    }
   setCol();   
  }
 
  void setSpeed(float vel){
    speed = vel;
  }
 private void setCol(){
    setColor = color(r,g,b);
 }
  void dibujar(){
    fill(setColor);
    ellipse(posX, posY, tam, tam);
  }
    void dibujarInicio(){
    fill(255);
    rect(posX, posY, tam*3, tam);
  }
  void actualizar() {
    posX -= speed;
  }

}
