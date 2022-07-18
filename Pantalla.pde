class Pantalla extends VariablesGlobales{
  String texto;
  boolean probCaja = false;
  boolean probVida = false;
  boolean probPlaneta = false;
  boolean probAsteroide = false;
  boolean clickRellenar = false;
  boolean clickCompra = false;
  float speedColor;
  float fondoX = 0;
  float index;
  float contadorAleatorio;
  float sizeBarraSonidoFx = width/4;
  float sizeBarraSonidoMusic = width/4;
  float posXMenosFx =width/3-10;
  float posXMasFx =width - width/3-10;
  float posYMenosFx =height/3+50;
  float posYMasFx =height/3+50;
  float posYMenosMusic =height/2+50;
  float posYMasMusic =height/2+50;
  int colorFondoCompra = 0;
  //tamaño de botones de compra
  int tamRectX = 78, tamRectY = 20;
  float timerThree = 3;
  int segundos = 30;
  int[] mejoras = new int[4]; //0 = parte de mejora municion //1 = parte de mejora vida // 2 = parte de nueva arma  //3 = parte de nueva arma 2
  Pantalla(String text){
    texto = text;
  }
  Pantalla (){
    for (int i=0; i<4; i++){
      mejoras[i]=0;
    }
  }
  void dibujar(String aviso){
    textSize(50);
    fill(255);
    text(texto,posX,posY);
    dibujarEnter(aviso);
  }
  void dibujarEnter(String aviso){
    textSize(14);
    fill(speedColor);
    text(aviso, width/2-75, height-20);
  }
  
  
  void dibujarConfig(float volFx, float volMusic, float volMax){
   cursor();
   background(0);
   textSize(35);
   textAlign(CENTER);
   text("C O N T R O L  V O L U M E N",width/2,height/3);
   text("F X ",width/2,height/3+30);
   rect(posXMenosFx, posYMenosFx, 20,5);
   rect(posXMasFx, posYMasFx, 20,5);
   rect(posXMasFx+8, posYMasFx-8, 5,20);
   rect(width/2.65,height/3+40,  actualizarBarraFx(volFx,volMax), 20);
   textSize(20);
   text(" M U S I C A",width/2,height/3+100);
   rect(posXMenosFx, posYMenosMusic, 20,5);
   rect(posXMasFx, posYMasMusic, 20,5);
   rect(posXMasFx+8, posYMasMusic-8, 5,20);
   rect(width/2.65,height/2+40,  actualizarBarraMusic(volMusic,volMax), 20);
   fill(-255);
   text("Mejora municion",100,20);
   text(mejoras[0]+ "/ 3",100,40);
   text("Mejora vida",265,20);
   text(mejoras[1]+ "/ 3",265,40);
   text("Mejora arma dual",400,20);
   text(mejoras[2]+ "/ 7",400,40);
   text("Mejora cañon obieb",575,20);
   text(mejoras[3]+ "/ 15",575,40);
   fill(255);
   text("Nivel: "+nivel,width-70, height-20);
   fill(0);
   stroke(-255);
   rect(60,55,tamRectX,tamRectY);
   rect(223,55,tamRectX,tamRectY);
   rect(362,55,tamRectX,tamRectY);
   rect(538,55,tamRectX,tamRectY);
   fill(-255);
   noStroke();
   text("Comprar",100,70);
   text("Comprar",263,70);
   text("Comprar",402,70);
   text("Comprar",578,70);
   text("costo de compra: 5 niveles",width/2,98);
   detectarCompra(60,55,0,3);
   detectarCompra(223,55,1,3);
   detectarCompra(362,55,2,7);
   detectarCompra(538,55,3,15);
  }
  
  
    private void detectarCompra(int posx,int posy,int numMejora, int maxCompra){
    
      
      if ( mouseX >= posx && mouseX <= posx+tamRectX && mouseY>=posy && mouseY<= posy+tamRectY && mousePressed){
     fill(-255);
     rect(posx,posy,tamRectX,tamRectY);
     fill(0);
     text("Comprar",posx+40,70);
     if (nivel >= 5 && mejoras[numMejora] != maxCompra && clickCompra) {
       nivel = nivel - 5;
       for (int i=0; i<4; i++){
        
         xpNivel = xpNivel / 1.5;
         println(xpNivel);
       }
       mejoras[numMejora] ++;
       powerUp.rewind();
       powerUp.play();
       this.clickComprar(false);
     }
     if (mejoras[numMejora] == maxCompra){
       asteroide.estadoAsteroide[numMejora+2]= true;
     }
      
      
    }
  }
    
    
    
    
    private  float actualizarBarraFx(float vol, float volMax){
    return (vol/volMax) * sizeBarraSonidoFx;
  }
  private  float actualizarBarraMusic(float vol, float volMax){
    return (vol/volMax) * sizeBarraSonidoMusic;
  }
  void escribirTextoParpadeante(String aviso, float posx,float posy,float col){
    textSize(18);
    fill(col);
    text(aviso, posx, posy);
  }
  void actualizar(){
    speedColor+=3;
    if (speedColor >= 255) {
      speedColor=speedColor*-1;
    }
  }
 
  float getPosXMenos(){
    return posXMenosFx;
  }
    float getPosXMas(){
    return posXMasFx;
  }  
  float getPosYMenosFx(){
    return posYMenosFx;
  }
    float getPosYMasFx(){
    return posYMasFx;
  }
    float getPosYMenosMusic(){
    return posYMenosMusic;
  }
    float getPosYMasMusic(){
    return posYMasMusic;
  }
  

    
    void generarNumeros(){
    if (frameCount % 60 == 0) {
      this.contadorAleatorio = random(0,100);
      println(parseInt(this.contadorAleatorio));
      if (this.contadorAleatorio <= 5 && probCaja ==false && gameStarted){
      probCaja = true; 
      
      }
      else if (this.contadorAleatorio >= 5 && this.contadorAleatorio <=7 && probVida==false && gameStarted) {
        probVida = true; 
      }
    } 
       else if (this.contadorAleatorio >= 10 && this.contadorAleatorio <= 12 && probPlaneta==false){
         probPlaneta = true;
         this.index = random(5);
         
         println("planeta en pantalla");
       } else if (this.contadorAleatorio >= 13 && this.contadorAleatorio <= 15 && probAsteroide==false){
         probAsteroide= true;
       }
    }
    
    
    void setProbCajas(boolean estado){
      probCaja = estado;
    }
    void setProbVida(boolean estado){
      probVida = estado;
    }
    void setProbPlaneta(boolean estado){
      probPlaneta = estado;
    }
   boolean getProbVida(){
      return probVida;
    }
    
  boolean getProbCajas(){
      return probCaja;
    }
  boolean getProbPlaneta(){
      return probPlaneta;
    
}
boolean getProbAsteroide(){
      return probAsteroide;
    
}
  void setProbAsteroide(boolean estado){
    probAsteroide = estado;
  }

  float getIndex(){
    return index;
  }
  
  
  void randomDrop(float random) {
    switch (parseInt(random)) {
      case 0: {

        
         
         if (segundos != 0){
            asteroide.estadoAsteroide[0] = true;
            asteroide.estadoAsteroide[1] = true;
           text("Daño X2 por "+segundos+" segundos", width/2-60, 50);
           
           if (frameCount % 60 == 0 ){
             
           segundos--;
           println("daño x2");
           println(segundos + " contador de segundos daño");
           }
         }
          
          
          
        else {
          println("fin daño x2");
          asteroide.estadoAsteroide[0] = false;
          asteroide.estadoAsteroide[1] = false;
          segundos=30;
        }
        break;
        
      
    }
      case 1: {
        if (mejoras[0]<3) {
        if (mejoras[0] == 0){
          mejoras[0]=1;
        } else if (mejoras[0]<3 && timerThree==3) {
          mejoras[0]++;
        }
        if(timerThree>0){
            asteroide.estadoAsteroide[0] = true;
           text("Conseguiste la parte "+mejoras[0]+" / 3 de la mejora de munincion", width/2-100, 50);
           if (frameCount %1 == 0 ){
           timerThree-=0.016;
           }
         }

        else {
          asteroide.estadoAsteroide[0] = false;
          timerThree=3;
        }
        }
         else {
          if(timerThree>0){
            asteroide.estadoAsteroide[0] = true;
            asteroide.estadoAsteroide[2] = true;
           text("Ya conseguiste la mejora de municion", width/2-60, 50);
           if (frameCount % 1 == 0 ){
           timerThree-=0.016;
           }
         }

        else {
          asteroide.estadoAsteroide[0] = false;
          timerThree=3;
        }
        }
        break;}
        
        
        
      case 2:
      
      {        
        if (mejoras[1]<3) {
        if (mejoras[1] == 0){
          mejoras[1]=1;
        } else if (mejoras[1]<3 && timerThree == 3) {
          mejoras[1]++;
        }
        if(timerThree>0){
           asteroide.estadoAsteroide[0] = true;
           text("Conseguiste la parte "+mejoras[1]+" / 3 de la mejora de vida", width/2-100, 50);
           if (frameCount % 1 == 0 ){
           timerThree-=0.016;
           }
         }

        else {
          asteroide.estadoAsteroide[0] = false;
          timerThree=3;
        }
        }
         else {
          if(timerThree>0){
            asteroide.estadoAsteroide[0] = true;
            asteroide.estadoAsteroide[3] = true;
           text("Ya conseguiste la mejora de vida", width/2-60, 50);
           if (frameCount % 1 == 0 ){
           timerThree-=0.016;
           }
         }

        else {
          asteroide.estadoAsteroide[0] = false;
          timerThree=3;
        }
        } break;}
        
        
      case 3: 
      
      {        
        if (mejoras[2]<7) {
        if (mejoras[2] == 0){
          mejoras[2]=1;
        } else if (mejoras[2]<7 && timerThree == 3) {
          mejoras[2]++;
        }
        if(timerThree>0){
            asteroide.estadoAsteroide[0] = true;
           text("Conseguiste la parte "+mejoras[2]+" / 7 de la mejora de armas", width/2-100, 50);
           if (frameCount % 1 == 0 ){
           timerThree-=0.016;
           }
         }

        else {
          asteroide.estadoAsteroide[0] = false;
          timerThree=3;
        }
        }
         else {
          if(timerThree>0){
            asteroide.estadoAsteroide[0] = true;
            asteroide.estadoAsteroide[4] = true;
           text("Ya conseguiste la mejora de armas", width/2-60, 50);
           if (frameCount % 1 == 0 ){
           timerThree-=0.016;
           }
         }

        else {
          asteroide.estadoAsteroide[0] = false;
          timerThree=3;
        }
        }break;}
        
        
      case 4: {   
        
        
        if (mejoras[3]<15) {
        if (mejoras[3] == 0){
          mejoras[3]=1;
        } else if (mejoras[3]<15 && timerThree == 3) {
          mejoras[3]++;
        }
        if(timerThree>0){
            asteroide.estadoAsteroide[0] = true;
           text("Conseguiste la parte "+mejoras[3]+" / 15 del cañon de obiebs", width/2-120, 50);
           if (frameCount % 1 == 0 ){
           timerThree-=0.016;
           }
         }

        else {
          asteroide.estadoAsteroide[0] = false;
          timerThree=3;
        }
        }
         else {
          if(timerThree>0){
           asteroide.estadoAsteroide[0] = true;
           asteroide.estadoAsteroide[5] = true;
           text("Ya conseguiste el cañon", width/2-60, 50);
           if (frameCount % 1 == 0 ){
           timerThree-=0.016;
           }
         }

        else {
          asteroide.estadoAsteroide[0] = false;
          timerThree=3;
        }
        }break;}
      
    
    
      
      
      
    
    }
    
    
    
  }
  
  
  
   void clickColor(boolean estado){
   
     clickRellenar = estado;
     if (clickCompra){
       colorFondoCompra = -255;
     }
     else {
       colorFondoCompra = 0;
     }
   }
  
  void clickComprar(boolean estado){
  
    clickCompra = estado;
    
  }
  
}
