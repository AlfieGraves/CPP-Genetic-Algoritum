class Bunch {
  Circle[] circles;
  int numCircles;

  Bunch(int[] radii) {
    circles = new Circle[radii.length];
    numCircles = radii.length;
    for (int i = 0; i < numCircles; i++) {
      circles[i] = new Circle(radii[i], i);
    }
  }

  void draw() {
    float bound = computeBoundary();
    stroke(0);
    fill(255);
    ellipse(cx, cy, bound * 2, bound * 2);

    for (int i = 0; i < numCircles; i++) {
      if (circles[i].computed)
        circles[i].draw();
    }
  }

  float computeBoundary() {
    float outerLimit = 0;
    for (int i = 0; i < numCircles; i++) {
      if (circles[i].computed) {
        float distance = dist(cx, cy, circles[i].x, circles[i].y) + circles[i].radius;
        if (distance > outerLimit) {
          outerLimit = distance;
        }
      }
    }
    return outerLimit;
  }

  void placeCircles(int[] order) {
    for (int i = 0; i < numCircles; i++) {
      circles[i].computed = false;
    }

    for (int i = 0; i < numCircles; i++) {
      int index = order[i];
      if (i == 0) {
        circles[index].x = cx;
        circles[index].y = cy;
        circles[index].computed = true;
      } else {
        circles[index].computePosition(circles);
      }
    }
  }
}
