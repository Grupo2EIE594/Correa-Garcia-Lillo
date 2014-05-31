import processing.serial.*;
Serial myPort;
boolean[] estado={false,false};
long timer1;



void setup()
{
  size(250,200);
  myPort = new Serial(this, Serial.list()[0], 57600);
  myPort.buffer(1);
  
  
}

void draw()
{
  if(estado[0]==true)
  {
    myPort.write(1);
  }
   
    if(estado[1]==true)
    {
      myPort.write(3);
    }
    
    if(estado[1]==false)
    {
      myPort.write(4);
    }
    
     
  cursor(HAND);
  for(int i=0;i<=1;i++)
  {
    stroke(0);
    if(estado[i]==false)
    fill(255);
    else
    fill(0);
    rect(50+100*i,75,50,50);
  }
  
 
}
void mousePressed()
{
  if(mouseY>=75 && mouseY<=125)
  {
    if(mouseX>=50 && mouseX<=100)
          {
            estado[0]=true;
            
          }
    
    if(mouseX>=150 && mouseX<=200)
    {
      estado[1]=!estado[1]; 
       
    }
 
   }
}

void mouseReleased()
{
  if(mouseY>=75 && mouseY<=125)
  {
    if(mouseX>=50 && mouseX<=100)
          {
            estado[0]=false;
            
          }
  }



}

  
