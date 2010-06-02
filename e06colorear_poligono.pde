/********************************************************
 *                                                       *
 *  21/04/2010                                           *
 *  TÉCNICAS GRAFICAS - Ejercicio 6: eBucket             *
 *                                                       *
 *  Alejandro Riera Mainar                               *
 *  NºMat: 010381                                        *
 *  ariera@gmail.com                                     *
 *                                                       *
 ********************************************************/

int limit = 1;
int SIZE = 200;
int NVERTICES = 7;
color COLOR = color(100,100,100);
int[][] vertices = new int[NVERTICES][2];
int vertices_left = 0;
VertexStack pila = new VertexStack(40000);
int TITLE_HEIGHT = 30;


void setup() {
  colorMode(RGB);
  stroke(255);
  background(0);
  size(SIZE+100, SIZE+TITLE_HEIGHT+60);
  displayTitle();
  display_instructions(SIZE, SIZE);
}
void displayTitle(){
  textFont(createFont("Helvetica", 13));
  fill(color(255));
  text("Ejercicio 6: Coloreado de Poligonos" , 10, 10);
}

void display_instructions(int base_width, int base_height){
  fill(color(255));
  textFont(createFont("Helvetica", 12));
  text("Clique " + NVERTICES + " veces para definir los vertices del poligono\nA continuacion clique en el interior del poligono\n\n¡¡POLIGONOS PEQUEÑOS POR FAVOR!!" , 10, base_height + TITLE_HEIGHT);  
}


void draw() {

}

void process(int x, int y){
  colorearSemilla(x,y);
}

void dibujarPoligono(int[][] vertices){
  for(int i = 0; i < vertices.length - 1; i++)
    line(vertices[i][0], vertices[i][1], vertices[i+1][0], vertices[i+1][1]);
  
  line(vertices[vertices.length-1][0], vertices[vertices.length-1][1], vertices[0][0], vertices[0][1]);
}


void colorearSemilla(int x, int y){
  int[] siguiente;
  guardarEnPilaVecinos(x,y,COLOR);
  colorearVecindad4(x,y,COLOR);
  siguiente = pila.pop();
  if (siguiente != null){
      colorearSemilla(siguiente[0], siguiente[1]);
  }
}

void colorearVecindad4(int x, int y,color c){
  int[][] vecinos = {{x+1,y}, {x-1,y}, {x,y+1}, {x, y-1}, {x+1, y+1}};
  for (int i = 0; i < vecinos.length -1; i++){
    int vx = vecinos[i][0];
    int vy = vecinos[i][1];
    if (get(vx,vy) != c && get(vx,vy) != color(255))
      set(vx,vy, c);
  }


}
void guardarEnPilaVecinos(int x, int y,color c){
//  int[][] vecinos = {{x+1,y}, {x-1,y}, {x,y+1}, {x, y-1}, {x+1, y+1}, {x+1, y-1}, {x-1, y+1}, {x-1, y-1}};
  int[][] vecinos = {{x+1,y}, {x-1,y}, {x,y+1}, {x, y-1}, {x+1, y+1}};
  for (int i = 0; i < vecinos.length -1; i++){
    int vx = vecinos[i][0];
    int vy = vecinos[i][1];
    if (get(vx,vy) != c && get(vx,vy) != color(255))
      pila.push(vx,vy);
  }
}

void keyPressed(){
      vertices_left = 0;
}
void mousePressed() {
  if (vertices_left < NVERTICES){
    vertices[vertices_left][0] = mouseX;
    vertices[vertices_left][1] = mouseY;
    point(mouseX, mouseY);
    vertices_left++;
    if (vertices_left ==  NVERTICES)
      dibujarPoligono(vertices);
  }
  else{
    process(mouseX, mouseY);
    //preubaStack();
  }
}


void preubaStack(){
  for (int x = 0; x < 1000; x++)
    pila.push(x,x+1);
 for (int x = 0; x < 1001; x++)
    pila.pop();
}

public class VertexStack {
      int stack_size;
      int pointer;
      int[][] stack;
      
      VertexStack(int desired_size){
        this.stack_size = desired_size;
        this.pointer = 0;
        this.stack = new int[stack_size][2];
      } 

      public void push(int x, int y){
        this.stack[pointer][0]=x;
        this.stack[pointer][1]=y;
      //  println(this.pointer + ": (" + this.stack[pointer][0] + "," + this.stack[pointer][1] + ")" + "x=" + x + ", y=" + y);
        this.pointer++;        
      }
      
      public int[] pop(){
        if (pointer == 0)
          return null;
        else{
          this.pointer--;
          return this.stack[pointer];
        }
      }


}


