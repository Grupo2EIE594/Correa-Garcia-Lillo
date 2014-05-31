#include <TimerOne.h>

int ldr1=0;
int ldr2=1;
int ldr3=2;
int rgb1=11;
int rgb2=10;
int rgb3=9;
int rojo=0;
int azul=0;
int verde=0;


void setup() 
{ 
  pinMode(ldr1,INPUT);
  pinMode(ldr2,INPUT);
  pinMode(ldr3,INPUT);
  pinMode(rgb1,OUTPUT);
  pinMode(rgb2,OUTPUT);
  pinMode(rgb3,OUTPUT);
  Timer1.initialize(1000);
  Timer1.attachInterrupt(colorgb);
  
  
}

void loop() 
{
  
}

void colorgb()
{
 int rojo=analogRead(ldr1);
 int verde=analogRead(ldr2);
 int azul=analogRead(ldr3);

 analogWrite(rgb1,rojo);
 analogWrite(rgb2,verde);
 analogWrite(rgb3,azul);
}
