import processing.serial.*;
Serial myPort;
import controlP5.*;
ControlP5 cp5;
boolean estado=false;

void setup()
{
  cursor(HAND);
  size(250,200);
  cp5=new ControlP5(this);
  myPort = new Serial(this, Serial.list()[0], 57600);
  myPort.buffer(1);
  
   cp5.addButton("botton1")
  .setPosition(50,75)
  .setSize(50,50)
  .setColorActive(#2035B2)
  .setColorForeground(#CEC62A) 
  .setColorCaptionLabel(#FFDA05)
  ;
  
   cp5.addButton("botton2")
  .setPosition(150,75)
  .setSize(50,50)
  .setColorActive(#2035B2)
  .setColorForeground(#CEC62A) 
  .setColorCaptionLabel(#FFDA05)
  ;
  
  cp5.getController("botton1")
  .getCaptionLabel()
  .setSize(12)
  ;
  cp5.getController("botton2")
  .getCaptionLabel()
  .setSize(12)
  ;
  
   
}

void draw()
{
  if(estado==true)
  {
    myPort.write(2);
  }
  else
    {
      myPort.write(3);
    }
    println(estado);
}


public void botton1()
{
       myPort.write(1);       

}
public void botton2() 
{
     estado=!estado;
}


