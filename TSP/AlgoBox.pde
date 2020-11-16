abstract class AlgoBox {
  Rectangle container;
  TextBox titleBox;
  Rectangle upperBoard;
  Rectangle lowerBoard;
  TextBox startButton;
  // Import button is used to duplicate points from neighbouring AlgoBox.
  TextBox importButton;
  TextBox stats;

  ArrayList<Point> points = new ArrayList<Point>();
  double[][] dists;

  ArrayList<Integer> upperPath = new ArrayList<Integer>();
  ArrayList<Integer> lowerPath = new ArrayList<Integer>();
  int numPoints = 0;

  boolean isStarted = false;
  boolean isActive = false;

  AlgoBox(
      Rectangle container,
      TextBox titleBox,
      Rectangle upperBoard,
      Rectangle lowerBoard,
      TextBox stats,
      TextBox startButton,
      TextBox importButton) {
    this.container = container;
    this.titleBox = titleBox;
    this.upperBoard = upperBoard;
    this.lowerBoard = lowerBoard;
    this.stats = stats;
    this.startButton = startButton;
    this.importButton = importButton;
    this.numPoints = 0;
  }

  void draw() {
    container.draw();
    titleBox.draw();
    upperBoard.draw();
    lowerBoard.draw();
    startButton.draw();
    importButton.draw();
    stats.draw();

    stroke(255);
    strokeWeight(10);
    for (int i = 0; i < numPoints; i++) {
      Point point = points.get(i);
      point(point.x, point.y);
      point(point.x, point.y - upperBoard.y + lowerBoard.y);
    }

    // Draw upper and lower board paths.
    strokeWeight(3);
    if (isStarted) {
      for (int i = 0; i < numPoints; i++) {
        Point upperA = points.get(upperPath.get(i));
        Point upperB = points.get(upperPath.get((i + 1) % numPoints));
        line(upperA.x, upperA.y, upperB.x, upperB.y);

        Point lowerA = points.get(lowerPath.get(i));
        Point lowerB = points.get(lowerPath.get((i + 1) % numPoints));
        line(
            lowerA.x,
            lowerA.y - upperBoard.y + lowerBoard.y,
            lowerB.x,
            lowerB.y - upperBoard.y + lowerBoard.y);
      }
    }
  }

  void mousePressedMayBe(ArrayList<Point> importedPoints, int xRef) {
    if (startButton.isMouseOver()) {
      if (numPoints == 0) {
        return;
      }
      isStarted = true;
      isActive = true;
      init();
    } else if (importButton.isMouseOver()) {
      reset();
      for (int i = 0; i < importedPoints.size(); i++) {
        addPoint(importedPoints.get(i).x - xRef + upperBoard.x, importedPoints.get(i).y);
      }
    } else if (upperBoard.isMouseOver() && !isStarted) {
      addPoint(mouseX, mouseY);
    }
  }

  void clearPoints() {
    points.clear();
    upperPath.clear();
    lowerPath.clear();
    numPoints = 0;
  }

  void stop() {
    isActive = false;
  }

  void reset() {
    isActive = false;
    isStarted = false;
    clearPoints();
    stats.text = "";
  }

  void addPoint(int x, int y) {
    if (!isStarted) {
      points.add(new Point(x, y));
      numPoints++;
    }
  }

  abstract void init();

  abstract void run();
}
