abstract class VariablesGlobales {
  
  float posX, posY, speed;
 
 
  float getPosX(){
    return posX;
  }
  
  
  float getPosY(){
    return posY;
  }
  
  
  void setPosX(float posx){
    posX = posx;
    
  }
  
  
  void setPosY(float posy){
    posY = posy;
    
  }
  
  
    void setPosX_Y(float x, float y){
      posX = x;
      posY = y;
    }
    
    
    void setSpeed(float vel){
      speed = vel;
    }
    
    
    void setRandomPosition(){
    setPosX(random(width+40,width*2));
    setPosY(random(50,height-50));
  }
  
  
  
    boolean colision(){
    boolean choque = false;
    if (dist(nave.getPosX(), nave.getPosY(), this.getPosX(), this.getPosY()) < nave.getSize()-10){
    choque = true;
  }
  return choque;
}


    boolean colisionBala(Enemigo enemy){
    boolean choque = false;
    if (dist(getPosX(), getPosY(), enemy.getPosX(), enemy.getPosY()) < enemy.getSize()){
    choque = true;
  }
  return choque;
}

}
