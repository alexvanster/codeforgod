Barra barra1 = new Barra();
Pelota pelota1 = new Pelota (300, 300, 0, 5, 20);
Texto texto1 = new Texto();
int filas = 6; 
int columnas = 6; 
int total = filas * columnas;
Bloque[] cajon = new Bloque[total];


void setup() {

  size(600, 600);
  smooth();

  for (int i = 0; i < filas; i++)
  {
    for (int j = 0; j< columnas; j++)
    {
      cajon[i*filas + j] = new Bloque((i+1) *width/(filas + 1), (j+1) * 40);
    }
  }
}

void draw() {

  background(0);

  for (int i = 0; i<total; i++)
  {
    cajon[i].display();
  }

  barra1.display();
  pelota1.display();
  pelota1.animar();

  if (pelota1.ypos == barra1.y
    && pelota1.xpos > barra1.x
    && pelota1.xpos <= barra1.x + barra1.w/2)
  {
    pelota1.rebotarxder();
    pelota1.rebotary();
  }

  
  if (pelota1.ypos == barra1.y
    && pelota1.xpos < barra1.x 
    && pelota1.xpos >= barra1.x - barra1.w/2 )
  {
    pelota1.rebotarxizq();
    pelota1.rebotary();
  }

  for (int i = 0; i < total; i ++)
  {

    if (pelota1.ypos - pelota1.diametro / 2 >= cajon[i].y - cajon[i].h/2
      && pelota1.ypos - pelota1.diametro / 2 <= cajon[i].y + cajon[i].h/2
      && pelota1.xpos >= cajon[i].x - cajon[i].w/2 
      && pelota1.xpos <= cajon[i].x + cajon[i].w/2 
      && cajon[i].golpe == false )
    {
      pelota1.rebotary();
      cajon[i].golpeado();
    }

    if (pelota1.ypos + pelota1.diametro / 2 >= cajon[i].y - cajon[i].h/2
      && pelota1.ypos +  pelota1.diametro / 2 <= cajon[i].y + cajon[i].h/2
      && pelota1.xpos > cajon[i].x - cajon[i].w/2 
      && pelota1.xpos < cajon[i].x + cajon[i].w/2 
      && cajon[i].golpe == false )
    {
      pelota1.rebotary();
      cajon[i].golpeado();
    } 
    if (pelota1.xpos + pelota1.diametro / 2 >= cajon[i].x - cajon[i].w/2
      && pelota1.xpos + pelota1.diametro / 2 <= cajon[i].x + cajon[i].w/2
      && pelota1.ypos >= cajon[i].y - cajon[i].h/2
      && pelota1.ypos <= cajon[i].y + cajon[i].h/2
      && cajon[i].golpe == false)
    {
      pelota1.rebotarxizq();
      cajon[i].golpeado();
    }
    if (pelota1.xpos - pelota1.diametro / 2 <= cajon[i].x + cajon[i].w/2 
      && pelota1.xpos - pelota1.diametro / 2 >= cajon[i].x - cajon[i].w/2 
      && pelota1.ypos >= cajon[i].y - cajon[i].h/2
      && pelota1.ypos <= cajon[i].y + cajon[i].h/2
      && cajon[i].golpe == false)
    {
      pelota1.rebotarxder();
      cajon[i].golpeado();
    }
  }
}

class Barra
{
  float x;
  float y; 
  float w; 
  float h; 
  float r; 
  float g;
  float b; 

  Barra() {
    x = 300;
    y = 500;
    w = 100;
    h = 10;
    r=255;
    g=255;
    b=255;
  }

  void display() {
    float mx = constrain(mouseX, 0+w/2, width-w/2 );
    rectMode(CENTER);
    x=mouseX;
    fill(r, g, b);
    rect(mx, y, w, h);
  }
}

class Bloque
{
  float x;
  float y;
  float w;
  float h;
  float r;
  float g;
  float b;
  boolean golpe;

  Bloque(float xpos, float ypos)
  {
    x = xpos;
    y = ypos;
    r = random(200, 255);
    g = random(200, 255);
    b = random(200, 255);
    w = 50; 
    h = 25;
  }
  
  void display()
  {
    rectMode(CENTER);
    noStroke();
    fill(r, g, b);
    rect(x, y, w, h);
  }
  void golpeado()
  {
    golpe = true; 
 
    r = 0;
    g = 0;
    b = 0;
    rect(x, y, w, h);
  }

}
class Pelota {

  float xpos; 
  float ypos; 
  float xspeed;
  float yspeed; 
  float diametro; 

  Pelota(float x, float y, float xs, float ys, float d) {

    xpos = x;
    ypos = y;
    xspeed = xs;
    yspeed = ys;
    diametro = d;
  }

  void display() {

    fill(255);
    ellipse(xpos, ypos, diametro, diametro);
  }

  void rebotarxder() {
    xspeed = 5;
  }

  void rebotarxizq() {
    xspeed = -5;
  }

  void rebotary() {
    yspeed = yspeed * -1;
  }
  void animar() {

    ypos = ypos + yspeed;
    xpos = xpos + xspeed;

    if (ypos < 0+diametro/2) {
      rebotary();
    }
    if (xpos > width-diametro/2) {
      rebotarxizq();
    }

    if (xpos < 0+diametro/2) {
      rebotarxder();
    }
    if (ypos > height-diametro/2) {
      texto1.display();
    }
  }
}
class Texto {
  void display() {
    if (keyPressed) {
      if (key == ENTER) {
        pelota1.xpos=300;
        pelota1.ypos=300;
      }
    }
    fill(0, 102, 153);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Game Over", 300, 350);
  }
}
