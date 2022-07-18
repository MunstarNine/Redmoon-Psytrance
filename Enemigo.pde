class Enemigo extends Nave{
    float col = 0;
    float maxCol = 255;
    float speed;
    float tam;
    float tamBarras = 40;
    int enemigosAsesinados=0;
    int segundos = 30;
    int timerThree = 3;
    PImage textura;
    
    
    boolean[] estadoAsteroide = new boolean[6];//0 = asteroide destruido //1 = daño x2 //2 = parte de mejora municion //3 = parte de mejora vida // 4 = parte de nueva arma 
    //5 = parte de nueva arma 2
    
    
    
    Enemigo(float tam_,int life, float posx, float posy, PImage textures, float vel, int maxLife) {
       super(tam_,life,posx,posy,textures,maxLife);
       textura = textures;
       speed = vel;
       
  }
  void actualizar() {
    super.posX-=speed;
  }
  void dibujar() {
    fill(255);
    text(parseInt(vida), posX+14,posY-25);
    fill(calcularColor2(),calcularColor(),0);
    rect(posX+5, posY-10,calcularBarra(), 5);
    image(textura,posX,posY, 50, 50);
  }
    void setImage(PImage imagen) {
    textura = imagen;
  }
  void setSpeed(float vel){
    speed = vel;
  }
  float getSpeed(){
    return speed;
  }
  private float calcularBarra(){
    return (vida/vidaMax)*tamBarras;
  }
  private float calcularColor(){
    return (vida/vidaMax)*maxCol;
  }
  private float calcularColor2(){
    return vidaMax/(vida/vidaMax);
  }
  int getKills(){
    return this.enemigosAsesinados;
  }
  void setKills(){
    this.enemigosAsesinados++;
  }
  void configurarParametros(float vel,int life){
      setRandomPosition();
      setSpeed(vel);
      setVida(life);
  }

    
  
  boolean getEstadoAsteroide(){
    return estadoAsteroide[0];
  }
  boolean getDamageX2(){
    return estadoAsteroide[1];
  }
  boolean getMejoraMunicion(){
    return estadoAsteroide[2];
  }
  boolean getMejoraVida(){
    return estadoAsteroide[3];
  }
  boolean getArma1(){
    return estadoAsteroide[4];
  }
  boolean getArma2(){
    return estadoAsteroide[5];
  }
  
     boolean muerto(){
    boolean aux = false;
    if (this.vida <= 0){
      aux = true;
    }
    else if (this.vida>0) {
      aux = false;
    }
    return aux;
  }
  
  boolean fueraDeMapa(){
    boolean fuera;
    if (getPosX()<-100){
      fuera=true;
    }else { 
    fuera = false;
  }
    return fuera;
  }
  
  
}
