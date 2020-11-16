class Rectangle {
  int x;
  int y;
  int width;
  int height;
  color col;

  Rectangle(int x, int y, int width, int height, color col) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.col = col;
  }

  void draw() {
    stroke(0);
    strokeWeight(1);
    fill(col);
    rect(x, y, width, height);
  }

  boolean isMouseOver() {
    if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height) {
      return true;
    } else {
      return false;
    }
  }
}
