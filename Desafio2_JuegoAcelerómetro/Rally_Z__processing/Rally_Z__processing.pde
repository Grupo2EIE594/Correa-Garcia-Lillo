//Desafio 2 Grupo 2: Rally Z "en honor a Rally x"

import processing.serial.*;

Serial myPort; // creamos una variable  Serial
// variables globales
int i=0,u=80,n=40,b=120,a=240,e=160,o=200;
float mon1,mon2,bom1,bom2,bom3,bom4,bom5;
float x=720,y=720,f=720,q=720,t=720,m=720,z=720;
int boton;
int puntos=1,puntajemax=1;
PImage auto;
int posicion=0;
int posicionx=255;
int[] val=new int[0];
boolean estado=false,estado1=false;
boolean comenzar=false;


void setup()
{
    size(700,400);  //tamaño ventana
    auto=loadImage("auto3.png");// cargamos la imagen
    myPort= new Serial(this,Serial.list()[0],9600); //configuracion de comunicaion serial
    myPort.bufferUntil('\n');//salta cuando la fila se acaba
    frameRate(30);  //ajustamos velocidad de movimiento

}

void draw()
{
  
  
  if(comenzar==false)
  {
    
    background(0);
    fill(246,255,5);
    rect(280,200,200,50);
    fill(255);
    textSize(40);
    text("iniciar",320,240);
  }
  
  if(comenzar==true && estado1==true)
  {
  background(0); // color del fondo(negro)
  
   if(myPort.available()>0)// si hay datos en el puerto serial
    {
    
     String myString=myPort.readStringUntil('\n');// tomamos los datos del serila como un string.
     if(myString!=null)// null si es que no hay nada lo negamos para q sea disntinto anda ya q recibiremos los valores.
     {
       val=int(split(myString,","));//separmos en el string por cada "," y guardamos cada dato en el array creado
        posicion=val[0];//cada dato guardado en el array creado
        
        
                      
     }
    }
  
  if(puntos>=1) // si el puntaje es mayor a cero
  {
    estado=false;// estado del juego
  stroke(255); //colo de lineas(blanca)
  for(int k=1;k<=12;k++) //dibujamos las lineas 
  {
  line(50*k,0,50*k,350);
  }
  
  //moneda
  random();// random en Y
  fill(255,255,35); //color moneda
  ellipse(x,i,30,30); //figura moneda
  ellipse(t,a,30,30); 
  i=i+4;//baja el objeto
  a=a+4;
  // comprobacion cuando llega al final
    if(i>349)
      {
        i=0;
      }
      if(a>349)
      {
        a=0;
      }
      
//bomba
 fill(234,31,31);// color bomba
 ellipse(y,u,35,35);
 ellipse(f,n,35,35);
 ellipse(q,b,35,35);
 ellipse(m,e,35,35);
 ellipse(z,o,35,35);
 u=u+4;//velocidad con que bajan
 n=n+4;
 b=b+4;
 e=e+4;
 o=o+4;
// llega al final
 if(u>349)
    {
       u=0;
    }
    
    if(n>349)
    {
      n=0;
    
    }
    
    if(b>349)
    {
      b=0;
    }
    if(e>349)
    {
       e=0;
    }
    if(o>349)
    {
       o=0;
    }
//auto      
fill(255);// 
//Se ajusta la posicion del aclerometro con respecto a la posicion del auto en pantalla
if(posicion==69){
  posicionx=0;
}
if(posicion==71){
  posicionx=50;
}
if(posicion==73){
  posicionx=100;
}
if(posicion==75){
  posicionx=152;
}
if(posicion==77){
  posicionx=202;
}
if(posicion==80){
  posicionx=255;
}
if(posicion==82){
  posicionx=302;
}
if(posicion==85){
  posicionx=352;
}
if(posicion==87){
  posicionx=402;
}
if(posicion==90){
posicionx=452;
}
if(posicion==92){
  posicionx=502;
}
if(posicion==95){
  posicionx=552;
}

image(auto,posicionx,350,40,40);// dibujasmo el auto en el juego
 
 
 //contabdo los punto(posicionX+40), es el largo del objeto(auto)
 //gana un punto al coger moneda
 if(posicionx<=x)
   {
     if(posicionx+40>=x)
     {
       if(i==344)
          puntos++;
     }

   }
    if(posicionx<=t)
   {
     if(posicionx+40>=t)
     {
       if(a==344)
          puntos++;
     }
   }
   
   //pierde 2 punto al coger una bomba
if(posicionx<=y)
   {
     if(posicionx+40>=y)
     {
       if(u==344)
          puntos=puntos-2;
     }  
   }
if(posicionx<=f)
   {
     if(posicionx+40>=f)
     {
       if(n==344)
          puntos=puntos-2;
     }
   }
if(posicionx<=q)
   {
     if(posicionx+40>=q)
     {
       if(b==344)
          puntos=puntos-2;
     } 
   }   
if(posicionx<=m)
   {
     if(posicionx+40>=m)
     {
       if(e==344)
          puntos=puntos-2;
     }     
     
     
   } 
if(posicionx<=z)
   {
     if(posicionx+40>=z)
     {
       if(o==344)
          puntos=puntos-2;
     } 
   }  
   // imprime los punto obtenidos
     textSize(10);//tamalo texto
      fill(255);//color texto
      text("puntos:",630,10);
      text(puntos,670,10);
   
      
      
      if(puntos>puntajemax)// tomamos el valor mas alto de puntos obtenido
      {
      
      puntajemax=puntos;
      }
  }
  
  //si los puntos son cero
  if(puntos<=0)
  { 
    textSize(60);
    fill(255);
    text("GAME OVER",180,150);// se termina el juego
    textSize(20);
    text("puntaje max:",250,230);// mostramos el max puntaje obtenido
    text(puntajemax,450,230);
    fill(7,152,33);  //color del boton
    rect(300,300,100,40); //figura  
    fill(85,1,1); //color letra
    textSize(20);// tamaño
    text("reniciar",310,330);
    estado=true; // estado
  
  }

  }     
}

// se eligue un numero al azar
void random()
{
 if(i==0)// solo cuando termina de  bajar el objeto
 {
 mon1=random(1,13);// numero al azar entre el 1 y el 13
 mon1=int(mon1); //convertimos el numero de un float aun int
 x=25+50*(mon1-1); // lo centramos en medio del carril 
 }
 if(u==0)
 {
    bom1=random(1,13);
    bom1=int(bom1);
    y=25+50*(bom1-1);
 
 }
  if(n==0)
 {
    bom2=random(1,13);
    bom2=int(bom2);
    f=25+50*(bom2-1);
 
 }
  if(b==0)
 {
    bom3=random(1,13);
    bom3=int(bom3);
    q=25+50*(bom3-1);
 
 }
 
 if(a==0)
 {
 mon2=random(1,13);
 mon2=int(mon2);
 t=25+50*(mon2-1);
 }
 
 if(e==0)
 {
    bom4=random(1,13);
    bom4=int(bom4);
    m=25+50*(bom4-1);
 
 }
  if(o==0)
 {
    bom5=random(1,13);
    bom5=int(bom5);
    z=25+50*(bom5-1);
 
 }
 
}


void mousePressed()
{
  
  
  if(mouseY>=300 && mouseY<=340)
  {
    if(mouseX>=300 && mouseX<=400)
          {
            if(estado==true)
            {
            puntos=1;
            puntajemax=1;
             x=720;
            y=720;
            f=720;
            q=720;
            t=720;
            m=720;
            z=720;
            }
            
          }
    
   }
   
   if(mouseY>=200 && mouseY<=250)
  {
    if(mouseX>=280 && mouseX<=480)
          {
            if(estado1==false)
            {
              comenzar=true;
              estado1=true;
            }
            
          }
    
   
 
   }
}
