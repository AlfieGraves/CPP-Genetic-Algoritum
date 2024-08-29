class Circle {
  int x, y, radius, index;
  boolean computed;

  Circle(int r, int idx) {
    x = 0;
    y = 0;
    radius = r;
    index = idx;
    computed = false;
  }

  void draw() {
    fill(255);
    ellipseMode(CENTER);
    ellipse(x, y, radius * 2, radius * 2);
    fill(255, 0, 0);
    textFont(f, 12);
    text("" + index, x, y);
  }

  void computePosition(Circle[] c) {
    boolean placed = false;
    for (int i = 0; i < c.length; i++) {
      if (c[i].computed) {
        for (int ang = 0; ang < 360; ang++) {
          int newX = c[i].x + int(cos(radians(ang)) * (radius + c[i].radius + 1));
          int newY = c[i].y + int(sin(radians(ang)) * (radius + c[i].radius + 1));
          boolean collision = false;
          for (int j = 0; j < c.length; j++) {
            if (c[j].computed && dist(newX, newY, c[j].x, c[j].y) < radius + c[j].radius) {
              collision = true;
              break;
            }
          }
          if (!collision) {
            x = newX;
            y = newY;
            computed = true;
            placed = true;
            break;
          }
        }
        if (placed) break;
      }
    }
  }
}
