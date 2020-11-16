// Brute Force Algorithm.
class BF extends AlgoBox {
  ArrayList<Point> points;
  ArrayList<Integer> path;
  ArrayList<Integer> bestSoFar;

  int numCase = 0;
  int numPoints = 0;
  long cases = 0;
  double bestDistSoFar = Integer.MAX_VALUE;
  double currentDist = Integer.MAX_VALUE;

  BF(
      Rectangle container,
      TextBox titleBox,
      Rectangle upperBoard,
      Rectangle lowerBoard,
      TextBox stats,
      TextBox startButton,
      TextBox importButton) {
    super(container, titleBox, upperBoard, lowerBoard, stats, startButton, importButton);
  }

  private void nextPermutation(ArrayList<Integer> indices) {
    int i = indices.size() - 2;
    while (i >= 1 && indices.get(i) >= indices.get(i + 1)) {
      i--;
    }
    if (i == 0) {
      // All permutations have finished.
      super.isActive = false;
    }

    if (i >= 1) {
      int j = indices.size() - 1;
      while (j >= 0 && indices.get(j) <= indices.get(i)) {
        j--;
      }
      Collections.swap(indices, i, j);
    }

    reverse(indices, i + 1, indices.size() - 1);
  }

  @Override
  void init() {
    numPoints = super.numPoints;
    points = super.points;
    dists = computeDistMatrix(points);

    numCase = 0;
    cases = fact(numPoints - 1);

    path = new ArrayList<Integer>();
    for (int i = 0; i < numPoints; i++) {
      path.add(i);
    }

    bestDistSoFar = Integer.MAX_VALUE;
    currentDist = Integer.MAX_VALUE;
    super.upperPath = path;
    bestSoFar = new ArrayList<Integer>(path);
    super.lowerPath = bestSoFar;
  }

  @Override
  void run() {
    numCase++;
    currentDist = pathDist(dists, path);
    if (currentDist < bestDistSoFar) {
      bestDistSoFar = currentDist;
      bestSoFar = new ArrayList<Integer>(path);
    }
    super.upperPath = path;
    super.lowerPath = bestSoFar;
    nextPermutation(path);
    super.stats.text = getStats();
  }

  String getStats() {
    return String.format(
        "Iteration: %d\nPercent Completion: %.2f%%\nBest Ever Distance: %.6f",
        numCase, (numCase / (double) cases) * 100, bestDistSoFar);
  }
}
