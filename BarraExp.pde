class BarraExp extends VariablesGlobales {

  
float tamX = 0, tamY = 8;
float tamMax =  width/1.35;
int[] posiciones = new int[7]; 
  
BarraExp (){
  posiciones[0]=parseInt(tamMax/7);
  this.setPosX_Y(100,height-60);
  for (int i=1; i<7; i++){
    posiciones[i]=parseInt(tamMax/7)*(i+1);
  }
}
  
void dibujar() {
fill(0,179,255);
rect(tamMax /7+20,posY+5,tamX,tamY+1);
noFill();
stroke(255);
strokeWeight(1);
  for (int i=0; i<7; i++){
    rect(posiciones[i]+20,posY+5,parseInt(tamMax /7),tamY+1);
  }

}
float getPorcentaje(float max, float actual) {

  float porcentaje = (actual / max);
  return porcentaje;
}
void actualizar (float max, float actual){
  
  tamX = getPorcentaje(actual,max) * tamMax;
  if(frameCount %180 == 0){
  
  println(getPorcentaje(actual,max));
  }
  if (tamX > tamMax){
    tamX = 0;
  }

}

float getTamX(){
  return tamX;
}
  
  
  
}
