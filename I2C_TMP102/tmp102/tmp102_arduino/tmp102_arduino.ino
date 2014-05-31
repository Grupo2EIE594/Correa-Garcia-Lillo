#include <TimerOne.h>
#include<Wire.h>//libreria Wire
int dirrecion_sensor=0x48;
float temp,temphigh,templow;
int conve,convehigh,convelow;
int led=8,led1=9;
int alert=7,alert2;
float tiempo=2.5;

/* data configuracion*/
int reonly=B00000000;
//int conf=B00000001;
int Thigh=B00000011;
int Tlow=B00000010;

void setup() 
{
pinMode(led,OUTPUT);
pinMode(led1,OUTPUT);
pinMode(alert,INPUT);
Wire.begin();
Serial.begin(9600);
Timer1.initialize(100000);
Timer1.attachInterrupt(muestra);

}

void loop() 
{
  /* toma de temperatura*/ 
  Wire.beginTransmission(dirrecion_sensor);
  Wire.write(reonly);
  Wire.endTransmission();
  Wire.requestFrom(dirrecion_sensor,2);
  byte MSB=Wire.read();
  byte LSB=Wire.read();
  
  /* registro limite alto*/
  Wire.beginTransmission(dirrecion_sensor);
  Wire.write(Thigh);
  Wire.write(24);
  Wire.endTransmission();
  Wire.requestFrom(dirrecion_sensor,2);
  byte MSBHIGH=Wire.read();
  byte LSBHIGH=Wire.read();
  
  
  /* registro limite bajo*/
  Wire.beginTransmission(dirrecion_sensor);
  Wire.write(Tlow);
  Wire.write(20);
  Wire.endTransmission();
  Wire.requestFrom(dirrecion_sensor,2);
  byte MSBLOW=Wire.read();
  byte LSBLOW=Wire.read();
  
  /**/
  
  
  
  
  /* registro*/  
  int conve= ((MSB << 8) | LSB) >> 4; 
  temp=conve*0.0625;
  /*registro high*/
   int convehigh= ((MSBHIGH << 8) | LSBHIGH) >> 4; 
   temphigh=convehigh*0.0625;
   
    /*registro LOW*/
   int convelow= ((MSBLOW << 8) | LSBLOW) >> 4; 
   templow=convelow*0.0625;
   

   
   
    if(alert2==0)
    {
      digitalWrite(led,HIGH);
      digitalWrite(led1,LOW);
       
    
    }
    else
    {
      digitalWrite(led1,HIGH);
       digitalWrite(led,LOW);
    }
   
 alert2=digitalRead(alert);
}

void muestra()
{
   Serial.print(temp);
   Serial.print(',');
   Serial.print(temphigh);
   Serial.print(',');
   Serial.print(templow);
   Serial.print(',');
   Serial.print(tiempo);
   Serial.print(',');
   Serial.print(alert2);
   Serial.print(',');
   Serial.println();

}
