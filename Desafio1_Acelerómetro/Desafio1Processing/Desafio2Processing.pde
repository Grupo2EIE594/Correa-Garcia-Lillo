//Desafio 1 Grupo 2

import processing.serial.*;  //incluimos la libreria Serial necesaria para la comunicacion serial

Serial myPort;  //creamos una variable tipo Serial

int i=0;    
float x=0;//variables necesarias para el dasafio
float y=0;
float z=0;
int[] val=new int[0];// un array para guardar los valores entregados por el serial      

void setup()
{  
    size(600, 400, P3D); // creamos la ventana y le decimos que crearemos un objeto en 3D.
    myPort= new Serial(this,Serial.list()[0],19200);  //configuracion de comunicaion serial
    myPort.bufferUntil('\n');//sirve para saber hasta donde tomar cada datos del serial.
    smooth();  //suavizar al figura   
    frameRate(200); //cuadros por segundo que se dibuja  
    stroke(20,11,36);//delimita los limites del objeto
     
}

void draw()
{
  background(0);  //negro el fondo
  textSize(40);// tamaño de texto
  fill(255,230,60);//color del texto
  text("grupo 2",220,50);// imprimimos texto y ubicacion de este
   
    
  
    if(myPort.available()>0)// si hay datos en el puerto serial
    {
    
     String myString=myPort.readStringUntil('\n');// tomamos los datos del serila como un string.
     if(myString!=null)// null si es que no hay nada lo negamos para q sea disntinto anda ya q recibiremos los valores.
     {
       val=int(split(myString,","));//separmos en el string por cada "," y guardamos cada dato en el array creado
        x=val[0];//cada dato guardado en el array creado
        y=val[1];
        z=val[2];
       
     }
    }
    pushMatrix();    //Dibujando el objeto 3D
    translate( width/2, height/2); //Lo situamos en medio de la pantalla
    translate(x-80,z-100,y-80);// lo movemos de acuerdo a las cordenadas del acelerometro
    rotateY(50);              //rotamos un poco en eje Z para que se puede ver la perspectiva del objeto
    fill(48,218,37);      //Color de relleno de la figura
    box(100, 70, 180);   //Dimensiones de la figura
    popMatrix();// restaura el sistema de coordenadas anterior
    
   
    textSize(10);// tamaño texto.
    fill(222,215,16);// color del texto
    text("ejex:",10,300);//imprimir los valores entregados por cada eje entregados por el acelerometro
    text(x,40,300);
    text("ejey:",10,330);
    text(z,40,330);
    text("ejeZ:",10,360);
    text(y,40,360);
}
  
  

 
