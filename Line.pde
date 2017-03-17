class Line
{
  ArrayList<PVector> history;
  float len;
  float noise_x;
  float noise_y;
  float noise_z;
  color body_color;
  
  Line(color c, float l)
  {
    history = new ArrayList<PVector>();
    
    noise_x = random(10);
    noise_y = random(10);
    noise_z = random(10);
    
    body_color = c;
    len = l;
  }
  
  void update()
  {
    float x = map(noise(noise_x), 0, 1, -100, 100);
    float y = map(noise(noise_y), 0, 1, -100, 100);
    float z = map(noise(noise_z), 0, 1, -100, 100);
    noise_x += 0.025;
    noise_y += 0.025;
    noise_z += 0.025;
  
    PVector direction = PVector.sub(new PVector(0, 0, 0), new PVector(x, y, z));
    direction.normalize();
    direction.mult(len);
  
    x = direction.x;
    y = direction.y;
    z = direction.z;
   
    history.add(new PVector(x, y, z));
  }
  
  void display()
  {
    fill(body_color, 32);
    stroke(body_color);
    strokeWeight(0.5);
    
    line(0, 0, 0, history.get(history.size() - 1).x, history.get(history.size() - 1).y, history.get(history.size() - 1).z);
    noStroke();
    for(int i = 0; i < history.size(); i++)
    {
      ArrayList<PVector> nearPoint = new ArrayList<PVector>();
      for(int j = 0; j < history.size(); j++)
      {
        float distance = PVector.dist(history.get(i), history.get(j));
        if(distance < 75)
        {
          nearPoint.add(history.get(j));
        }
      }
      
      beginShape();
      for(PVector p : nearPoint)
      {
        vertex(p.x, p.y, p.z);
      }
      endShape(CLOSE);
    }
  }
}