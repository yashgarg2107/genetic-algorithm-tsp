class TextBox extends Rectangle {
  int textSize = 18;
  String text = "";
  color textCol;

  TextBox(int x, int y, int width, int height, color col, color textCol) {
    super(x, y, width, height, col);
    this.textCol = textCol;
  }

  TextBox(int x, int y, int width, int height, color col, String text, color textCol) {
    super(x, y, width, height, col);
    this.text = text;
    this.textCol = textCol;
  }

  @Override
  void draw() {
    super.draw();
    fill(textCol);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(this.text, super.x, super.y, width, height);
  }
}
