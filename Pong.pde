Ball ball; 

Paddle paddleLeft;
Paddle paddleRight;
int winScore= 5; //First to reach wins
int scoreLeft = 0;
int scoreRight = 0;


void setup(){
  size(800,600);
  ball = new Ball(width/2, height/2, 50); //create a new ball to the center of the window
  ball.speedX = 8; // Giving the ball speed in x-axis
  ball.speedY = 5; // Giving the ball speed in y-axis

  paddleLeft = new Paddle(15, height/2, 30,200);
  paddleRight = new Paddle(width-15, height/2, 30,200);
}

void printscore(int winScore){
     print("First to " + winScore + " Wins "); 
}

void draw(){
  background(0); 
  ball.display(); 
  ball.move(); 
  ball.display(); // Draw the ball on the window
  
  paddleLeft.move();
  paddleLeft.display();
  paddleRight.move();
  paddleRight.display();
  game_end();
  
  
  if (ball.right() > width) { //inreasing the score
    scoreLeft = scoreLeft + 1;
    ball.x = width/2;
    ball.y = height/2;
  }
  if (ball.left() < 0) { //inreasing the score
    scoreRight = scoreRight + 1;
    ball.x = width/2;
    ball.y = height/2;
  }
  

  if (ball.bottom() > height) {
    ball.speedY = -ball.speedY;
  }

  if (ball.top() < 0) {
    ball.speedY = -ball.speedY;
  }
  
  if (paddleLeft.bottom() > height) {
    paddleLeft.y = height-paddleLeft.h/2;
  }

  if (paddleLeft.top() < 0) {
    paddleLeft.y = paddleLeft.h/2;
  }
    
  if (paddleRight.bottom() > height) {
    paddleRight.y = height-paddleRight.h/2;
  }

  if (paddleRight.top() < 0) {
    paddleRight.y = paddleRight.h/2;
  }
  
  
  // If the ball gets behind the paddle 
  // AND if the ball is inside area of the paddle (between paddle top and bottom)
  // bounce the ball to other direction

  if ( ball.left() < paddleLeft.right() && ball.y > paddleLeft.top() && ball.y < paddleLeft.bottom()){
    ball.speedX = -ball.speedX;
    ball.speedY = map(ball.y - paddleLeft.y, -paddleLeft.h/2, paddleLeft.h/2, -10, 10);
  }

  if ( ball.right() > paddleRight.left() && ball.y > paddleRight.top() && ball.y < paddleRight.bottom()) {
    ball.speedX = -ball.speedX;
    ball.speedY = map(ball.y - paddleRight.y, -paddleRight.h/2, paddleRight.h/2, -10, 10);
  }
  
  
  textSize(40);
  textAlign(CENTER);
  text(scoreRight, width/2+200, 40); // Right side score
  text(scoreLeft, width/2-200, 40); // Left side score
  textSize(30);
  textAlign(CENTER);
  text("First to " + winScore + " Wins", width/2, 40); 
 
 
}

void game_end(){
   if(scoreRight == winScore){
     textSize(40);
     gameoverpage("Right Wins");
   }
   if(scoreLeft == winScore){
     textSize(40);
     gameoverpage("Left Wins");
   }
 }
 // Winner Screen
void gameoverpage(String text){
  ball.speedX = 0;
  ball.speedY = 0; 
  text("Game Over", width/2, height/3+40);
  text(text, width/2, height/3);
  text("Click to play again", width/2, height/3+80);
  
  
  if(mousePressed){
    scoreRight = 0;
    scoreLeft = 0;
    ball.speedX = 9;
    ball.speedY= 5;
  }
}

void keyPressed(){
  if(keyCode == UP){
    paddleRight.speedY=-6;
  }
  if(keyCode == DOWN){
    paddleRight.speedY=6;
  }
  if(key == 'w'){
    paddleLeft.speedY=-6;
  }
  if(key == 's'){
    paddleLeft.speedY=6;
  }
}

void keyReleased(){
  if(keyCode == UP){
    paddleRight.speedY=0;
  }
  if(keyCode == DOWN){
    paddleRight.speedY=0;
  }
  if(key == 'w'){
    paddleLeft.speedY=0;
  }
  if(key == 's'){
    paddleLeft.speedY=0;
  }
}
  

class Ball {
  float x;
  float y;
  float speedX;
  float speedY;
  float diameter;
  color c;
  
  // Constructor method
  Ball(float tempX, float tempY, float tempDiameter) {
    x = tempX;
    y = tempY;
    diameter = tempDiameter;
    speedX = 0;
    speedY = 0;
    c= #ff3300;
  }
  
  void move() {
    // Add speed to location
    y = y + speedY;
    x = x + speedX;
  }
  
  void display() {
    fill(c); //set the drawing color
    ellipse(x,y,diameter,diameter); //draw a circle
  }
  
  //functions to help with collision detection
  float left(){
    return x-diameter/2;
  }
  float right(){
    return x+diameter/2;
  }
  float top(){
    return y-diameter/2;
  }
  float bottom(){
    return y+diameter/2;
  }

}


class Paddle{

  float x;
  float y;
  float w;
  float h;
  float speedY;
  float speedX;
  color c;
  
  Paddle(float tempX, float tempY, float tempW, float tempH){
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    speedY = 0;
    speedX = 0;
    c=(255);
  }

  void move(){
    y += speedY;
    x += speedX;
  }

  void display(){
    fill(c);
    rect(x-w/2,y-h/2,w,h);
  } 
  
  //helper functions
  float left(){
    return x-w/2;
  }
  float right(){
    return x+w/2;
  }
  float top(){
    return y-h/2;
  }
  float bottom(){
    return y+h/2;
  }
 
}
