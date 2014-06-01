import controlP5.*;
import processing.serial.*;
String inputString="" ;         // Almacena los datos entrantes por puerto serial
boolean stringComplete = false;
boolean estadoguardar=false,estadoSYN;
float[] val=new float[0];
String[] datos=new String[10];
float grado,ldr,angulo;
int ld,angul,grad;
float di,me,ao,hor,mi,se;
int dia,mes,iao,hora,min,seg;
int i=0,k;
String data;
int aux=0;


Serial myPort;
ControlP5 cp5;
PrintWriter fichero;
String shora,sfecha;


void setup()
{
    size(700,400);
    myPort= new Serial(this,Serial.list()[0],9600); //configuracion de comunicaion serial
    myPort.bufferUntil('\n');//salta cuando la fila se acaba
    frameRate(20);  //ajustamos velocidad de movimiento
    fichero=createWriter("valores.txt");
    cp5 = new ControlP5(this);
    PFont font = createFont("arial",20);


     cp5.addButton("SET")
     .setValue(0)
     .setPosition(520,300)
     .setSize(100,40)
     ;
   
     cp5.addTextfield("hora")
     .setPosition(500,180)
     .setSize(150,40)
     .setValue("12:40:55")
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
     
     cp5.addTextfield("fecha")
     .setPosition(500,240)
     .setSize(150,40)
     .setValue( "May 07 2014")
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
}

void draw()
{
    interfaz();
    
    if(stringComplete==true)
    {
       String myString=inputString;// tomamos los datos del serila como un string.
       if(myString!=null)// null si es que no hay nada lo negamos para q sea disntinto anda ya q recibiremos los valores.
       {
        val=float(split(myString,","));//separmos en el string por cada "," y guardamos cada dato en el array creado
        grado=val[0];//cada dato guardado en el array creado
        ldr=val[1];
        angulo=val[2];
        grad=int(grado);  
        ld=int(ldr);
        angul=int(angulo);
        
        me=val[3];
        di=val[4];
        ao=val[5];
        hor=val[6];
        mi=val[7];
        se=val[8];
        dia=int(di);
        mes=int(me);
        iao=int(ao)+2000;
        hora=int(hor);
        min=int(mi);
        seg=int(se);
      }
      
   if(estadoguardar==true) 
          {
             guardar();
          }

          
    inputString = "";
    stringComplete = false;
    
     armar();
   
    }
    
  
   
    
}
 


void interfaz()
{
 background(255);
 stroke(0);
 
 fill(0,208,242); 
 rect(0,0,700,80);
 fill(0);
 textSize(40); 
 text("datalloger",250,50);
 
 //1pestaña      
 fill(206,255,185); 
 rect(0,80,233,319);
 fill(0,150,200);
 rect(65,100,100,40);
  fill(255);
 textSize(20);
 text("enviar",85,125);
   
   //texto
       fill(0);
      
       textSize(15);
       text("temperatura:",20,290);
       text(grad,120,290);
       text("ldr:",20,320);
       text(ld,80,320);
       text("angulo:",20,350);
       text(angul,100,350);
       textSize(15);
       text("FECHA",100,160);
       text(mes,60,180);
       text(":",90,180);
       text(dia,110,180);
       text(":",140,180);
       text(iao,160,180);
       text("HORA",100,220);
       text(hora,60,240);
       text(":",90,240);
       text(min,110,240);
       text(":",140,240);
       text(seg,160,240);
       
       
       
 //2 pestaña
 
 fill(255,239,185);
 rect(234,80,233,319);
 fill(0,150,200);
 rect(300,100,100,40);
 fill(255);
 textSize(20);
 text("SYN",330,125);
 textSize(10);
 fill(0);
 text("T°-ldr-angulo-mes/dia/año-hora:min:seg",250,160);
 if(estadoSYN==true)
 {  
   for(int j=0;j<10;j++)
          {
            if(j==0)
            { k=0;}
            String m=datos[j];
            textSize(12);
            fill(0);
            text(m,255,180+k);
            k=k+20;
          }
 }


 //3 pestaña
 fill(191,248,255); 
 rect(466,80,233,319);
 fill(0);
 textSize(10);
 text("Formato fecha: Mmm DD YYYY", 510,100); 
 textSize(8);
 text("Mmm: Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec", 475,120);
 textSize(10);
 text("Formato hora:  HH:MM:SS", 510,145);    
}


public void hora(String theText)
{
  shora=theText;
}
public void fecha(String theText)
{
  sfecha=theText;
}
public void SET(int theValue) 
{
  myPort.write(cp5.get(Textfield.class,"fecha").getText()+ ", " + cp5.get(Textfield.class,"hora").getText() + "\n");
  
  println("Hora enviada a Arduino: " + cp5.get(Textfield.class,"fecha").getText() + ", " + cp5.get(Textfield.class,"hora").getText());
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}


void guardar()
{   
  fichero.print("fecha:") ;
    fichero.print(mes);
    fichero.print(':');
    fichero.print(dia);
    fichero.print(':');
    fichero.print(iao);
    fichero.print(',');
    fichero.print("hora:");
    fichero.print(hora);
    fichero.print(':');
    fichero.print(min);
    fichero.print(':');
    fichero.print(seg);
    fichero.print(',');
    fichero.print("temp:");
    fichero.print(grado);
    fichero.print(',');
    fichero.print("ldr:");
    fichero.print(ld);
    fichero.print(',');
    fichero.print("inclinacion:");
    fichero.print(angul);
    fichero.println();
    fichero.flush();
}

void serialEvent(Serial p) 
{ 
  while (p.available()>0 ) {
    // get the new byte:
    char inChar = (char)p.read();
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n') {
      stringComplete = true;
    }
  }
} 


void mousePressed()
{
  if(mouseY>=100 && mouseY<=140)
  {
    if(mouseX>=65 && mouseX<=165)
     {
           estadoguardar=true;
          fill(0); 
          text("bkn",10,10); 
    
     }
 }
   
   if(mouseY>=100 && mouseY<=140)
  {
    if(mouseX>=300 && mouseX<=400)
          { 
            if(aux==0)
            {
              estadoSYN=true;
              aux++;
            }
            else if(aux==1) 
            {
              estadoSYN=false;
              aux=0;
            }
           }
  }
}

void armar()
{
    String  sgrado= str(grad);
    String  sld  =  str(ld);
    String  sangul= str(angul);
    String  smes =  str(mes);
    String  sdia =  str(dia);
    String  siao=   str(iao);
    String  shora=  str(hora);
    String  smin=   str(min);
    String  sseg=   str(seg);
    
    data=sgrado+'-'+sld+'-'+sangul+'-'+smes+'/'+sdia+'/'+siao+'-'+shora+':'+smin+':'+sseg;
  if(i<=9)
  {
   datos[i]=data;
   i++;
  }
  else
 {
   i=0;
   datos[i]=data;
   i++;
 }
}
