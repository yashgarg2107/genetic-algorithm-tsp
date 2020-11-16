import java.lang.Math; 
import java.util.Collections;
import javafx.util.Pair; 

static long fact(long n) {
  long ans = 1;
  for (long i = 1; i <= n; i++) {
    ans *= i;
  }
  return ans;
}

static <T> void reverse(ArrayList<T> list, int start, int end) {
  int i = start, j = end;
  while (i < j) {
    Collections.swap(list, i, j);
    i++;
    j--;
  }
}

// Points are ordered, and wrapped circularly at end.
static double pathDist(double[][] dists, ArrayList<Integer> path) {
  double currentDist = 0;
  for (int i = 0; i < path.size(); i++) {
    currentDist += dists[path.get(i)][path.get((i + 1) % path.size())];
  }
  return currentDist;
}

static double dist(Point a, Point b) {
  int sqDistX = (a.x - b.x) * (a.x - b.x);
  int sqDistY = (a.y - b.y) * (a.y - b.y);
  return Math.sqrt(sqDistY + sqDistX);
}

static double[][] computeDistMatrix(ArrayList<Point> points) {
  int n = points.size();
  double[][] result = new double[n][n];
  for (int i = 0; i < n; i++) {
    for (int j = i + 1; j < n; j++) {
      result[i][j] = dist(points.get(i), points.get(j));
      result[j][i] = result[i][j];
    }
  }
  return result;
}
