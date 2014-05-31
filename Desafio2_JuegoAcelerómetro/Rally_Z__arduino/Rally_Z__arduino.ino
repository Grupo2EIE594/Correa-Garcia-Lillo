//Desafio 2 Grupo 2 : Rally Z
#include <TimerOne.h>

int val=0,val1=1;
int x;

void setup() 
{
  pinMode(x,INPUT);
  
  
  Serial.begin(9600);
  Timer1.initialize(50000);
  Timer1.attachInterrupt(imprimir);
}

void loop() 
{
  
}
void imprimir()
{

  x=analogRead(val); //lee el eje X del acelerometro por la entrada Ao y guarda en la variable x.
  x=map(x,0, 1023, 0, 255);//mapeamos los valores de x desde 0-1023 a 0-255.

  
    //mandamos a imprimir los valores registrados de los ejes x,y,z separados por una ",", por medio de la comunicaion seria. 
    Serial.print(x);
    Serial.print(",");
    Serial.println();

}
