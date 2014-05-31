//Desafio 1 Grupo 2
#include <TimerOne.h>// libreria del timer 1

int val0=A0,val1=A1,val2=A2; //valores de cada eje del acelerometro
int x=0,y=0,z=0;// valores ejes




void setup() 
{
 
  Serial.begin(19200);  // comienza la comunicacion serial con 19200 baudios
  Timer1.initialize(50000);// se inicializa el timer1 en 50000.(cada 50000 se dispara el interrucion)
  Timer1.attachInterrupt(imprimir);// se dispara la interrupcion imprimir
}

void loop() 
{
  
}

void imprimir()
{
  
  x=analogRead(val0); //lee el eje X del acelerometro por la entrada Ao y guarda en la variable x.
  x=map(x,0, 1023, 0, 255);//mapeamos los valores de x desde 0-1023 a 0-255.
  y=analogRead(val1);// se hace lo mismo para los otros ejes.
  y=map(y,0, 1023, 0, 255);
  z=analogRead(val2);
  z=map(z,0,1023,0,255);
  
  //mandamos a imprimir los valores registrados de los ejes x,y,z separados por una ",", por medio de la comunicaion seria. 
    Serial.print(x);
    Serial.print(",");
    Serial.print(y);
    Serial.print(",");
    Serial.print(z);
    Serial.print(",");
    Serial.println();

 
}
 
  
  
 

