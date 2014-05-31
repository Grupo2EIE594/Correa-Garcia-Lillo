import processing.serial.*;
Serial myPort;
float x;
float y,z,t,g;
float[] val=new float [0];


void setup()
{
  myPort=new Serial(this,Serial.list()[0],9600);
  myPort.bufferUntil('\n');
  size(500,400);
  frameRate(300);

}

void draw()
{
  background(255);
  fill(255);
  stroke(0);
  ellipse(150,260,100,100);
  ellipse(350,260,100,100);
  
  if(myPort.available()>0)
  {
   String myString=myPort.readStringUntil('\n');
   if(myString!=null)
   {
     float[] val=float(split(myString,",")); 
     x=val[0];
     y=val[1];
     z=val[2];
     t=val[3];
     g=val[4];
   
   
   }
   
  }
  
   
    textSize(20);
    fill(0);
    text("temperatura:",130,100);
    text(x,260,100);
    text("°C",340,100);
    textSize(15);
   // text("tiempo:",180,130);
    //text(t,240,130);
   // text("[us]",290,130);
    textSize(10);
    text("limite temperatura high:",280,180);
    text(y,400,180);
    text("limite temperatura baja:",40,180);
    text(z,160,180);
    //text("tiempo de envio:",50,200);
    //text(y,220,200);*/
    
    
    if(g==0)
    {
      fill(255,10,1);
      ellipse(350,260,100,100);
      textSize(15);
      fill(0);
      text("a superado el limte superior",250,350);
      
    }
    
    if(g==1)
    {
      fill(20,20,255);
      ellipse(150,260,100,100);
      textSize(15);
      fill(0);      
      text("a superado el limte inferior",60,350);
    
    }
    
    
    

}
