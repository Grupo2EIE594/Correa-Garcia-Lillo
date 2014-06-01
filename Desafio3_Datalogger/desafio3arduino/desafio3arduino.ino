#include <LiquidCrystal.h>
#include <Wire.h>
#include <TimerOne.h>
#include "RTClib.h"
RTC_DS1307 RTC;

int sensortmp=A0,sensorluz=A1,ace=A2;
int ldr=0,ejez=0,grad,angulo,toma=0;
float tmp,grado;
boolean estadoboton=false;
int led=6;
unsigned long aaa=0,intervalo,timer0;
LiquidCrystal lcd(12, 11, 10,9,8,7);
String inputString = "";         
boolean stringComplete = false;
byte bytegrado,byteldr,byteejez,msbyear,lsbyear;
int addr=0;
byte rdata;
int time0,time1;


  void i2c_eeprom_write_byte( int deviceaddress, unsigned int eeaddress, byte data ) 
  {
     int rdata = data;
     Wire.beginTransmission(deviceaddress);
     Wire.write((int)(eeaddress >> 8)); // MSB
     Wire.write((int)(eeaddress & 0xFF)); // LSB
     Wire.write(rdata);
     Wire.endTransmission();
  }
  
  byte i2c_eeprom_read_byte( int deviceaddress, unsigned int eeaddress ) 
  {
    Wire.beginTransmission(deviceaddress);
    Wire.write((int)(eeaddress >> 8)); // MSB
    Wire.write((int)(eeaddress & 0xFF)); // LSB
    Wire.endTransmission();
    Wire.requestFrom(deviceaddress,1);
    if (Wire.available()) rdata = Wire.read();
    return rdata;
  }


void setup() 
{
      Serial.begin(9600); 
      Wire.begin();
      RTC.begin();
      Timer1.initialize(2000000);
      Timer1.attachInterrupt(imprimir);
      attachInterrupt(0,bto,FALLING);
      pinMode(led,OUTPUT);
      lcd.begin(16,2);
}

void loop() 
{
  tmp=analogRead(sensortmp);
  grado=(((tmp*5)/1024)-0.5)*100;
  grad=int(grado);
  bytegrado=byte(grad);
  ldr=analogRead(sensorluz);
  ldr=map(ldr,0,1023,0,255);
  byteldr=byte(ldr);
  
  ejez=analogRead(ace);
  time0 = 0;
  time1 = millis();
  while(time0 < 150){
    time0 = millis()-time1;
  }
  
  angulo = ((413-ejez)*9)/7;
  byteejez=byte(angulo);
  
  if(estadoboton==false)
  {
    if (stringComplete) 
    {
     char sFecha[50],sHora[50];
     inputString.substring(0, inputString.indexOf(',')).toCharArray(sFecha, 50) ;
     inputString.substring(inputString.indexOf(',') + 2).toCharArray(sHora, 50);
     
     RTC.adjust(DateTime(sFecha, sHora));
 
    // borra el string y la bandera
     inputString = "";
     stringComplete = false;
     }
  }
       
  if(estadoboton==true)
   {   
     DateTime now = RTC.now();  
     timer0=millis();
     if(timer0-intervalo>=15000)
      {
         intervalo=timer0 ;
         digitalWrite(led,HIGH);
         
 /*................temperatura..............................*/        
         i2c_eeprom_write_byte(0b1010000,addr,bytegrado);
         delay(10);
         byte a =i2c_eeprom_read_byte(0b1010000,addr);
         Serial.print(a,DEC);
         Serial.print(",");
         ++addr;
 /*....................ldr..............................*/
         i2c_eeprom_write_byte(0b1010000,addr,byteldr);
         delay(10);
         byte b =i2c_eeprom_read_byte(0b1010000,addr);
         Serial.print(b,DEC);
         Serial.print(",");
          ++addr;
  /*..................angulo..............................*/
         i2c_eeprom_write_byte(0b1010000,addr,byteejez);
         delay(10);
         byte c=i2c_eeprom_read_byte(0b1010000,addr);
         Serial.print(c,DEC);
         Serial.print(",");
         addr++;
 /*..................mes............,,,,,,,,,,,,,,,,,,,,,,,*/ 
         i2c_eeprom_write_byte(0b1010000,addr,now.month());
         delay(10);
         byte d=i2c_eeprom_read_byte(0b1010000,addr);
         Serial.print(d,DEC);
         Serial.print(",");
         addr++;
/*...................dia.................................*/   
         i2c_eeprom_write_byte(0b1010000,addr,now.day());
         delay(10);
         byte e=i2c_eeprom_read_byte(0b1010000,addr);
         Serial.print(e,DEC);
         Serial.print(",");
         //rdata=serialangulo;
         addr++;
/*........................año..............................*/        
         int intyear=now.year()-2000;
         i2c_eeprom_write_byte(0b1010000,addr,intyear);
         delay(10);
         byte f=i2c_eeprom_read_byte(0b1010000,addr);
         addr++;
         Serial.print(f,DEC);
         Serial.print(",");
         addr++;
/*.......................hora...................*/        
         i2c_eeprom_write_byte(0b1010000,addr,now.hour());
         delay(10);
         byte h=i2c_eeprom_read_byte(0b1010000,addr);
         Serial.print(h,DEC);
         Serial.print(",");
         addr++;
/*.................minutos.........................*/         
         i2c_eeprom_write_byte(0b1010000,addr,now.minute());
         delay(10);
         byte i=i2c_eeprom_read_byte(0b1010000,addr);
         Serial.print(i,DEC);
         Serial.print(",");
         addr++;
/*....................segundos......................*/
         i2c_eeprom_write_byte(0b1010000,addr,now.second());
         delay(10);
         byte j=i2c_eeprom_read_byte(0b1010000,addr);
         Serial.print(j,DEC);
         Serial.print(",");
         addr++;
/*.................................*/         
       Serial.println();
      }
   }
}

  void imprimir()
  {
    digitalWrite(led,LOW);
    lcd.clear();
    lcd.setCursor(0,1);
    lcd.print("T:");
    lcd.setCursor(2,1);
    lcd.print(grado);
    lcd.setCursor(10,1);
    lcd.print("A:");
    lcd.setCursor(12,1);
    lcd.print(angulo);
  }


  void bto()
  {
    intervalo=millis();
    
    if((millis()-aaa)>200)
    {
      estadoboton=true;
      aaa=millis();      
    }
  }

  void serialEvent() 
  {
    while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read(); 
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n')
    {
      stringComplete = true;
    }
    }
  }
