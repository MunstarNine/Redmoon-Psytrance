class Bala extends VariablesGlobales{
   
  float tam;
  int damage = 25;
  int damageBala = damage;
  boolean dobleDamage;
  Bala (float posx, float posy, float tama){
     
      super.posX = posx;
      super.posY = posy;
      tam = tama;
    
  }
  int getDamage(){
    return damageBala;
  }
  void dibujar(){
    if (asteroide.getDamageX2()==false){
    fill(0,223,0);
    rect(posX, posY, tam*3, tam);
  }
    else {
        fill(255,20,20);
        rect(posX, posY, tam+5*3, tam+5);
        
    }
    
  }
  void actualizar(){
    posX +=30; 
  }
  void setDamageX2(){
    damageBala = damage*2;
    
  }
  void setDamage(int dam){
    damageBala = dam;
  }
}
