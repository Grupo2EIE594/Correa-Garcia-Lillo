boolean ledrojo=8;
boolean ledverde=9;
boolean boton1=10;
boolean boton2=11;
unsigned long timer;
int estadoled=LOW;
long inicio=0;
long intervalo2=500;
int cont=0;
unsigned long  timer1;

void setup() {
  pinMode(ledrojo,OUTPUT);
  pinMode(ledverde,OUTPUT);
  pinMode(boton1,INPUT);
  pinMode(boton2,INPUT);
  Serial.begin(9600);

}

void loop() 
{
 
if(digitalRead(boton1)==HIGH && cont==0)
    { 
       timer1=millis();
       digitalWrite(ledrojo,HIGH);
       ++cont;
    }
time(timer1);
if(timer==2000 && cont==1)
     {
        digitalWrite(ledverde,HIGH);
        ++cont;
  
     }
if(timer>=3000 && timer<10000 && cont==2)
  {
     if(digitalRead(boton2)==HIGH)
       { 
         parpadeo();
       }
     else
      digitalWrite(ledrojo,HIGH);
    
  }
  
if(timer==7000 )
   {  
     digitalWrite(ledverde,LOW);
   }  
if(timer==10000)
    {
     digitalWrite(ledrojo,LOW);
     cont=0; 
    }  
  
}



void parpadeo()
{ 
  unsigned long ahora=millis();
  if(ahora-inicio>intervalo2)
  {
    inicio=ahora;
    if(estadoled==LOW)
    {
      estadoled=HIGH;
    }
    else 
      estadoled=LOW;
     digitalWrite(ledrojo,estadoled);
  }
}

unsigned long time(unsigned long timer1)
{
  unsigned long time=millis();
  if(time-timer1<=10000)
  {
    timer=time-timer1;
  }
  return timer;
  
}

