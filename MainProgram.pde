import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//import GifAnimation.*;
Nave nave;
Enemigo enemigo;
Pantalla screen;
Enemigo asteroide;
BarraExp barra;
PFont fuente;
//sonidos 
Minim minim;
AudioPlayer enemyDestroy;
AudioPlayer sonido;
AudioPlayer laser;
AudioPlayer powerUp;
AudioPlayer impact;
AudioPlayer death;
AudioPlayer selection;
AudioPlayer noBullets;
AudioPlayer colisionConNave;
AudioPlayer healthUp;
AudioPlayer asteroidDestroy;
AudioPlayer laserX2;

final int maxVidaAsteroide = 1250;
final float volMax = 10;
final int vidaCruceros = 500;
final int vidaCazas = 125;

char pantallas = 0;
int nivel;
int velocidadColor = 0;
int damageColision = 10;
int crucerosAsesinados = 0;
int cazasAsesinados = 0;
int score = 0;
int enemigosBrutalizados = 0;
int cantidadEnemigos = 4;
int cantidadEstrellas = 400;
int xpCazas = 200;
int xpCruceros = 500;
String[] hiScore = new String[1];
boolean disparo = false;
boolean reset = false;
boolean gameStarted = false;
boolean estrellasInstanciadas = true;
boolean paraAnimaciones = true;
boolean config = false;
boolean asteroideDestruido = false;
boolean lvlUp = false;
float xpTotal = 0;
float xpActual;
float xpNivel = 1000;
float maxXp = xpActual * 1.5;
float volFx = 0;
float volMusic = 0;
float contadorTiempo;
float sizeSprites = 45;
float cantidadBalas = 100;
float maxvidaJugador = 100;
float vidaJugador = maxvidaJugador;
float contadorAleatorio;
float capacidadBalas = 100;
Planeta[] planeta;
Enemigo[] cazas;
Enemigo[] cruceros;
Estrella[] stars;
Items[] item = new Items[2];
ArrayList<Bala> bala;



void setup() {
  size(700,400);
  noCursor();
  noStroke();
  smooth();
  score = 0;
  nivel =1;
  xpActual = 0;
  //objetos
  
  barra = new BarraExp();
  screen = new Pantalla();
  fuente = createFont("img/VT323-Regular.ttf",32);
  textFont(fuente);
  minim = new Minim(this);
  nave = new Nave(sizeSprites, vidaJugador, 20, height/2, loadImage("img/nave.gif"),maxvidaJugador);
  cruceros = new Enemigo[cantidadEnemigos];
  cazas = new Enemigo[cantidadEnemigos];
  stars = new Estrella[cantidadEstrellas];
  bala = new ArrayList<Bala>();
  screen = new Pantalla("RED MOON - P S Y T R A N C E");
  planeta = new Planeta[5];
  asteroide = new Enemigo(sizeSprites,maxVidaAsteroide,random(width,width*2), random(50,height-50), loadImage("img/asteroide.png"),0.7, maxVidaAsteroide);
  
  //musica && sonidos
  noBullets = minim.loadFile("sounds/noBalas.wav");
  impact = minim.loadFile("sounds/impact.wav");
  powerUp = minim.loadFile("sounds/Powerup.wav");
  selection = minim.loadFile("sounds/Blip_Select.wav");
  death = minim.loadFile("sounds/death.wav");
  enemyDestroy= minim.loadFile("sounds/Explosion.wav");
  laser = minim.loadFile("sounds/Laser2.wav");
  sonido = minim.loadFile("sounds/musicStage4.mp3");
  colisionConNave = minim.loadFile("sounds/colisionNave.wav");
  healthUp = minim.loadFile("sounds/health.wav");
  asteroidDestroy = minim.loadFile("sounds/deathAsteroid.wav");
  laserX2 = minim.loadFile("sounds/laserx2.wav");
  sonido.loop();
  
  sonido.setGain(volMusic);
  death.setGain(volFx);
  impact.setGain(volFx);
  laser.setGain(volFx);
  powerUp.setGain(volFx);
  colisionConNave.setGain(volFx);
  noBullets.setGain(volFx);
  selection.setGain(volFx);
  enemyDestroy.setGain(volFx);
  
  //loops iniciadores

    hiScore = loadStrings("hiScore.txt");
    item[0] = new Items(30,loadImage("img/ammo.png"));
    item[1] = new Items(30,loadImage("img/health.png"));
  
  for (int i=0; i<5; i++){
    planeta[i] = new Planeta(loadImage("img/"+i+".png"),0.3);
    if (i==4) {
      planeta[i].setSpeed(10);
    }
  }
  for (int i=0; i<cantidadEnemigos; i++){
        cruceros[i] = new Enemigo(sizeSprites,vidaCruceros,random(width,width*2), random(50,height-50), loadImage("img/crucero.gif"),random(2), vidaCruceros);
        cazas[i] = new Enemigo(sizeSprites,vidaCazas,random(width,width*2), random(50,height-50), loadImage("img/enemigo.gif"),random(3,7), vidaCazas);
  }
  for (int i=0; i<cantidadEstrellas; i++){
    stars[i]=new Estrella(random(width*2),random(height),random(0.8,2.8));
    stars[i].setSpeed(random(15,20));
    }
  }


void draw() {
  textAlign(LEFT);
  background(0);
  contadorTiempo = millis();
  //intercambio entre pantallas
  
  switch (pantallas) {
  
    //pantalla principal
     
    case 0: {

    screen.generarNumeros();

    for (int i=0; i<cantidadEstrellas-250; i++){
      stars[i].dibujarInicio();
      stars[i].actualizar();
      if (stars[i].getPosX()<-100){
        stars[i].setPosX(random(width,width+(width/2)));
    }
  }    
      if (screen.getProbPlaneta()==true){
      planeta[parseInt(screen.getIndex())].dibujar();
      planeta[parseInt(screen.getIndex())].actualizar();
      if (frameCount % 120 == 0){
      println(planeta[parseInt(screen.getIndex())].getPosX());
    }
      if (planeta[parseInt(screen.getIndex())].getPosX()<-600){
        screen.setProbPlaneta(false);
        planeta[parseInt(screen.getIndex())].setRandomPosition();
      }
    }
    text("Game by Munstar Studios",width - 120, height-20);
    screen.dibujar("Pulsa enter para jugar");
    screen.actualizar();
    screen.setPosX_Y(50,85);
    nave.dibujar();
    nave.setPosX_Y(30,height/2+random(5));
    
    break;
    }
    //pantalla tutorial

    
    case 1: {
    item[0].dibujar();
    item[0].setPosX_Y(50, 50);
    item[1].dibujar();
    item[1].setPosX_Y(50, 125);
    cazas[0].dibujar();
    cruceros[0].dibujar();
    cazas[0].setPosX_Y(45, 220);
    cruceros[0].setPosX_Y(45, 320);
    asteroide.dibujar();
    asteroide.setPosX_Y(500,height/2);
    textSize(15);
    fill(255);
    text("<- Esto es una nave caza, son rápidas y",width/6, 240);
    text("   otorgan 200 puntos",width/6, 260);
    text("<- Esto es una caja de munición, se generan de forma",width/6, 70);
    text("   aleatoria y recarga tu munición al máximo",width/6, 90);
    text("<- Esto es un crucero, son más lentos y tienen",width/6, 335);
    text("   mas vida, pero otorgan 1000 puntos",width/6, 355);
    text("<- Esto es una caja de vida",width/6, 145);
    text("   restaura toda tu vida",width/6, 165);
    text("Presiona la letra O para abrir la ventana de pausa y compra con xp",150, 30);
    text("Esto es un asteroide bono, destruyelo para conseguir",350, height/2+60);
    text("Utiliza los niveles ganados para comprar en la",350, height/2-60);
    text("pantalla de compra (TECLA O)",350, height/2-40);
    text("una parte aleatoria de mejora para tu nave, puede ser un",350, height/2+80);
    text("arma, daño x2 por 30 segundos, mejora de vida o munición",350, height/2+100);
    text("Consejo: dale con los 2 clicks!!",width-200, height-20);
    screen.dibujarEnter("Pulsa enter para jugar");
    screen.actualizar();
    screen.setPosX_Y(50,85);
    break;
  

}
    case 2: {
      //reseteo los sprites de muestra en la pantalla anterior
      if (gameStarted == false) {
        sonido.pause();
        for (int i=0; i< cantidadEstrellas; i++){
        stars[i].setSpeed(random(0.3,1));
          }
        item[0].setRandomPosition();
        item[1].setRandomPosition();
        cazas[0].setRandomPosition();
        cruceros[0].setRandomPosition();
        asteroide.setRandomPosition();
        sonido = minim.loadFile("sounds/musicStage2.mp3");
        sonido.loop();
        gameStarted = true;
      } else {
      if (config && gameStarted) {
       screen.dibujarConfig(volFx,volMusic,volMax); 
      }
       else {
      //pantalla de configuración
      
      
      textSize(14); 
  //generación de numeros aleatorios para la munición, vida, asteroide y planetas del fondo

    screen.generarNumeros();



  for (int i=0; i<cantidadEstrellas; i++){
    stars[i].dibujar();
    stars[i].actualizar();
    if (stars[i].getPosX()<-100){
      stars[i].setPosX(random(width,width+(width/2)));
    }
  }
  
    if (screen.getProbPlaneta()){
    
      
      planeta[parseInt(contadorAleatorio)].dibujar();
      planeta[parseInt(contadorAleatorio)].actualizar();
      if (frameCount % 120 == 0){
      println(planeta[parseInt(contadorAleatorio)].getPosX(),planeta[parseInt(contadorAleatorio)].getPosY());
    }
      if (planeta[parseInt(contadorAleatorio)].getPosX()<-600){
        planeta[parseInt(contadorAleatorio)].setRandomPosition();
        screen.setProbPlaneta(false);
      }
    }

  if (nave.getVida()>0){
  nave.dibujar();
  nave.setPosX_Y(mouseX-10,mouseY-10);
  }
  //dibujado y actualizado de enemigos 

  
  //inicializar cazas
  for (int i=0; i < cantidadEnemigos; i++) {
    cazas[i].dibujar();
    cazas[i].actualizar();
    //detectando colisiones 
    
     if (cazas[i].colision()) {
       colisionConNave.rewind();
       colisionConNave.play();  
       nave.setVida(nave.getVida()-damageColision);
       cazas[i].configurarParametros(random(3,7),vidaCazas);
     }
    //si se van del mapa

      if (cazas[i].fueraDeMapa()){
          cazas[i].configurarParametros(random(3,7),vidaCazas);
      }
      
      //si mueren
      if (cazas[i].muerto()) {
                enemyDestroy.rewind();
                enemyDestroy.play();
                println("Caza n°" + i +" muerto");
                cazasAsesinados++;
                score+=200;
                cazas[i].configurarParametros(random(3,7),vidaCazas);
                println("cantidad de cazas asesinados: " + cazasAsesinados);
                println("Caza n°" + i +" " +cazas[i].getVida());
            if (xpActual + xpCazas > xpNivel){

                xpActual = (xpActual - xpNivel) + xpCazas;
                lvlUp = true;
                nivel++;
              }
                else {
                
                  xpActual +=xpCazas;
                  
                }
                
                xpTotal += xpActual; 
                println("xp ganado: ",xpActual);
                println("xp total : "+xpTotal);
            }
  }
   
   //inicializar cruceros
  
   for (int i=0; i < cantidadEnemigos; i++) {
    cruceros[i].dibujar();
    cruceros[i].actualizar();
    
    //detectando colisiones 
    
     if (cruceros[i].colision()) {
         
       nave.setVida(nave.getVida()-(damageColision+20));
       colisionConNave.rewind();
       colisionConNave.play();
       cruceros[i].configurarParametros(random(2),vidaCruceros);
     }
    
     //si se van del mapa
      if (cruceros[i].getPosX() < -100) {
          cruceros[i].configurarParametros(random(2),vidaCruceros);
      
      }
  //si mueren
      if (cruceros[i].muerto()){
                enemyDestroy.rewind();
                enemyDestroy.play();
                println("Crucero n°" + i +" muerto");
                cruceros[i].configurarParametros(random(2),vidaCruceros);
                crucerosAsesinados++;
                score+=1000;
                println("cantidad de cruceros asesinados: " + crucerosAsesinados);
                println("Crucero n°" + i +" " +cruceros[i].getVida());
                
                if (xpActual + xpCruceros > xpNivel){

                xpActual = (xpActual - xpNivel) + xpCruceros;
                lvlUp = true;
                nivel++;
              }
                else {
                
                  xpActual +=xpCruceros;
                  
                }
                
                
                xpTotal += xpActual;
                println("xp ganado: ",xpActual);
                println("xp total : "+xpTotal);
            }
}
//ITEMS!!
  
  
  //Munición
  if (screen.getProbCajas()) {
    item[0].dibujar();
    item[0].actualizar();
    fill(255);
    text("Ha aparecido una caja de munición, ¡recógela!",30, 30);
    //si la caja se va del mapa
    if (item[0].getPosX()<-50){
      item[0].setRandomPosition();
      screen.setProbCajas(false);
    }
    //colision con caja
    if (item[0].colision()){
        powerUp.rewind();
        powerUp.play();
        cantidadBalas = capacidadBalas;
        item[0].setRandomPosition();
        screen.setProbCajas(false);
    }
  }
    
    //paquete de vida
    
    if (screen.getProbVida()) {
    item[1].dibujar();
    item[1].actualizar();
    fill(255);
    text("Ha aparecido una caja de vida, ¡recógela!",30, 50);
    //si la caja se va del mapa
    
    //colision con caja
    if (item[1].colision()){
        println("colision con vida");
        healthUp.rewind();
        healthUp.play();
        nave.setVida(maxvidaJugador);
        println("Vida restaurada");
        item[1].setRandomPosition();
        screen.setProbVida(false);
    }
    if (item[1].getPosX()<-100){
      screen.setProbVida(false);
      item[1].setRandomPosition();
    }
  }
  
  //asteroide 
  
  if (screen.getProbAsteroide() && asteroideDestruido==false){
    
      if (frameCount % 60 == 0){
        println("Asteroide en posicion: "+asteroide.getPosX());
      }
      asteroide.dibujar();
      asteroide.actualizar();
  if (asteroide.getPosX()<-50){
      println("asteroide fuera de mapa");
      asteroide.setRandomPosition();
      asteroide.setVida(maxVidaAsteroide);
      screen.setProbAsteroide(false);
    }
  if (asteroide.muerto()){
    asteroidDestroy.rewind();
    asteroidDestroy.play();   
    screen.setProbAsteroide(false);
    asteroide.setRandomPosition();
    asteroide.setVida(maxVidaAsteroide);
    println("posicion asteroide cambiada");
    println(asteroide.getPosX() + " / " +asteroide.getPosY());
    asteroideDestruido = true;
    contadorAleatorio = random(5);
    xpActual += 1000;
    xpTotal += xpActual;
    println("xp total : "+xpTotal);
  }
  
  }
  if (asteroideDestruido) {
    fill(-255);
    screen.randomDrop(contadorAleatorio);
    asteroideDestruido = asteroide.getEstadoAsteroide();
  }
//coliciones de la bala

      if (disparo){  
        
        for (int i=0; i< bala.size(); i++){
          Bala b = bala.get(i);
          if (asteroide.getDamageX2()){
            
            b.setDamageX2();
          }
          if (asteroide.getArma2()){
            b.setDamage(100);
          }
          if (b.getPosX()<width+50 && b.getPosY()<height){
          b.dibujar();
          b.actualizar();
          if (b.getPosX()>width+50){
            b.setPosX_Y(-500,height*2);
          } else {
          for (int j=0; j < cantidadEnemigos; j++){
          if (b.colisionBala(cazas[j])){

              impact.rewind();
              impact.play();
            
            b.setPosX_Y(-500,height*2);
            cazas[j].setVida(cazas[j].getVida()-b.getDamage());
         
            }
            if (b.colisionBala(cruceros[j])){
             
              impact.rewind();
              impact.play();
            
            b.setPosX_Y(-500,height*2);
            cruceros[j].setVida(cruceros[j].getVida()-b.getDamage());
            
      }
          //colision asteroide
          if (b.colisionBala(asteroide)){
            impact.rewind();
            impact.play();
            asteroide.setVida(asteroide.getVida()-b.getDamage());
            b.setPosX_Y(-500,height*2);
          }
      }
      }
      }
      }
      }
      if (cantidadBalas == capacidadBalas){
        fill(0,230,0);
        text("(MAX)",200, height-20);
      }
      if ((cantidadBalas <= capacidadBalas/3) && cantidadBalas>0){
        fill(255,119,0);
        text("¡Cuidado, munición baja!",200, height-20);
      }
        else if (cantidadBalas==0){
        fill(230,0,0);
        text("¡Sin munición!",200, height-20);
      }
      
      
      
      
  //texto en pantalla
  
  
  
  // experiencia 
  barra.dibujar();
  fill(255,60,255);
  stroke(255);
  strokeWeight(20);
  text("EXP "+parseInt(xpActual) +" / "+parseInt(xpNivel),width/2-30,barra.getPosY()+13.6);
  stroke(0);
  strokeWeight(1);
  if (xpActual != 0){
  barra.actualizar(xpActual,xpNivel);
  }
  if (lvlUp == true){
   xpNivel *= 1.5;
   println(xpNivel+" para prox lvl");
   lvlUp=false;
  }

  if (score > int(hiScore[0]) && mousePressed){
    hiScore[0]=str(score);
    saveStrings("hiScore.txt",hiScore);
    println("score máximo superado "+hiScore[0]);
    
  }
  enemigosBrutalizados=cazasAsesinados+crucerosAsesinados;
  fill(255);
  text("FPS: "+parseInt(frameRate),30, height-20);
  text("Municion: "+parseInt(cantidadBalas)+"/"+parseInt(capacidadBalas),100, height-20);
  text("SCORE: "+parseInt(score)+" / "+"HISCORE "+hiScore[0],width/2-5, height-20);
  text("Brutalizaste a: "+enemigosBrutalizados,width/2-40, 30);
  textSize(18);
  text("H P: "+parseInt(nave.getVida())+"  /  "+parseInt(maxvidaJugador),width-180, height-20);
  text("Nivel: "+nivel,width-70, 20);
  
  
  
  
  // sector de mejoras && se continua en mousePressed
  
  if (asteroide.getMejoraMunicion()){
     
    capacidadBalas = 300;
      
  } 
 if (asteroide.getMejoraVida()){
   
    maxvidaJugador = 200;
      
  } 
  if (asteroide.getArma1()){
   
    nave.setImage(loadImage("img/nave_mejor.gif"));
      
  }
  

  
  //muerte del personaje 
  
  if (nave.getVida() <= 0){
  if (nave.getPosX()<width && nave.getPosY()<height){
    death.rewind();
    death.play();
  }
  reset=true;
  nave.setPosX_Y(-1000,height*3);
  nave.setVida(0);
  textSize(90);
  text("T E   M O R I S T E", 5, height/2);
  screen.escribirTextoParpadeante("Pulsa R para reiniciar",width/4, height-height/2.5,255);
  }
  }
      }
    break;
    }//fin Case 2
    case 3:{

      setup();
      pantallas = 0;
      break;
    }
     
   case 4:{

   
   
   break;
 
 } 
}  //Fin SWITCH
if(pantallas == 0 || config){
  textSize(12);
  textAlign(CENTER);
  fill(255);
  text("Versión: 0.7.2 (estable)",70, height-20);
  
}
} 

void mousePressed(){
 if(config){
screen.clickColor(true);
}
disparo = true;

if ((cantidadBalas > 0 && pantallas >= 2) && reset == false && !config){
  if (asteroide.getDamageX2()){
    laserX2.rewind();
    laserX2.play();
  }
  else {
    laser.rewind();
    laser.play();  
 }
 if (asteroide.getArma2()==false){
if (asteroide.getArma1()==false){

bala.add(new Bala(nave.getPosX()+35, nave.getPosY()+22,3));
cantidadBalas--;
  } else {
  bala.add(new Bala(nave.getPosX()+20, nave.getPosY()+10,3));
  bala.add(new Bala(nave.getPosX()+20, nave.getPosY()+40,3));
  cantidadBalas--;
  }
}
else {
  if (asteroide.getArma1()==false){
    bala.add(new Bala(nave.getPosX()+35, nave.getPosY()+22,6));
    cantidadBalas--;
  }
  else {
    bala.add(new Bala(nave.getPosX()+20, nave.getPosY()+10,6));
    bala.add(new Bala(nave.getPosX()+20, nave.getPosY()+40,6));
    cantidadBalas--;
  }
}
}
else if (cantidadBalas == 0 && !config){
      
  noBullets.rewind();
  noBullets.play();
  
}
  if (bala.size()>50 && cantidadBalas==0){
    bala.clear();
    println("");
    println("balas limpiadas");
    
  }
  if (config && gameStarted){
  if(dist(mouseX,mouseY,screen.getPosXMenos(),screen.getPosYMenosFx())<30){ 
    if (volFx >0){
       volFx-=1;
       println("fx "+volFx);
       }
  } 
  if(dist(mouseX,mouseY,screen.getPosXMas(),screen.getPosYMasFx())<30){ 
     if (volFx < 10){
       
       volFx+=1;
       println("fx "+volFx);
       }
  }
  if(dist(mouseX,mouseY,screen.getPosXMenos(),screen.getPosYMenosMusic())<30){ 
     if (volMusic >0){
       volMusic-=1;
       println("music "+volMusic);
       }
  }
  if(dist(mouseX,mouseY,screen.getPosXMas(),screen.getPosYMasMusic())<30){ 
    if (volMusic < 10){
       volMusic+=1;
       println("music "+volMusic);
       }

  

  }
  sonido.setGain(volMusic);
  death.setGain(volFx);
  impact.setGain(volFx);
  laser.setGain(volFx);
  powerUp.setGain(volFx);
  colisionConNave.setGain(volFx);
  noBullets.setGain(volFx);
  selection.setGain(volFx);
  enemyDestroy.setGain(volFx);
  }

}

void keyPressed(){
  
  if (keyCode == ENTER && !gameStarted){
    selection.rewind();
    selection.play();
    pantallas++;
  
  }
  else if ((keyCode == 'r' || keyCode == 'R') && (reset)){
    println("reiniciando...");
    println();
    println();
    contadorAleatorio=0;
    sonido.pause();
    pantallas = 3;
    reset = false;
    gameStarted = false;
    cantidadBalas = capacidadBalas;
    println("reiniciado");
  }
 if (keyCode == 'o' || keyCode == 'O' && pantallas!=1){
    config = !config;
    noCursor();
  }


  
}

void mouseClicked(){
  if (config){
  screen.clickComprar(true);
  }
}
void mouseReleased() {
   screen.clickColor(false);
 }
