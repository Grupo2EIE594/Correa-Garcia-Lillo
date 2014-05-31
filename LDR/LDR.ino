

byte ledVerde = 8;  
byte ledRojo = 9;      


void setup() 
{
Serial.begin(9600);
}




void loop() 
{
int NivelSensor = analogRead(A0);
  
if (NivelSensor>800)
    {
    digitalWrite(ledVerde,HIGH);
    digitalWrite(ledRojo,LOW);
    }
if (NivelSensor>400)
    {
    digitalWrite(ledRojo,HIGH);
    digitalWrite(ledVerde,LOW);
    }
  
Serial.println(NivelSensor);

}

