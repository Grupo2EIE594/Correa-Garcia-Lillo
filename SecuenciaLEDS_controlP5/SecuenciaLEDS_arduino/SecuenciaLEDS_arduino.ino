int rojo=10;
int verde=9;
unsigned long timer,timer1,timer2;
unsigned long inicio=0;
int estadorojo=LOW;
int cont=0;

void setup() {
 pinMode(rojo,OUTPUT);
 pinMode(verde,OUTPUT);
 Serial.begin(57600);
}
void loop() 
{
  
  int input=Serial.read();
  if(input==1 && cont==0)
  { timer2=millis();
    digitalWrite(rojo,HIGH);
    cont++;
  }
  tiempo(timer2);
  if(timer==2000 && cont==1)
  {
    digitalWrite(verde,HIGH);
    ++cont;
  }
  if(timer==7000 && cont==2)
  {
    digitalWrite(verde,LOW);
  }
  
  if(timer==10000)
  {
    digitalWrite(rojo,LOW);
    cont=0;
  }
 if(timer>=3000 && timer<=10000 && cont==2) 
  {
   if(input==2)
   {
      parpadeo();
     
   }
   if(input==3)
   {
     digitalWrite(rojo,HIGH);
   }
   
  }
  Serial.println(input);
  
}
unsigned long tiempo(unsigned long timer2)
{ 
  unsigned long timer3=millis();
  if(timer3-timer2>10000)
  {
     timer2=timer3;
  }
  else
  timer=timer3-timer2;
  return timer;
}

void parpadeo()
{ 
  unsigned long ahora=millis();
  if(ahora-inicio>500)
  {
    inicio=ahora;
    if(estadorojo==LOW)
    {
      estadorojo=HIGH;
    }
    else 
      {
        estadorojo=LOW;
      }
     digitalWrite(rojo,estadorojo);
  }
}
  

