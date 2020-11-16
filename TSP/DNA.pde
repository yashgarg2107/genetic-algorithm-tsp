class DNA {
  ArrayList<Integer> genes;
  double[][] dists;

  int numPoints;
  double fitness;

  // These arrays are used for crossover algorithm. These represent circular doubly linked list.
  int[] nextInPath;
  int[] prevInPath;

  DNA(double[][] dists) {
    this.dists = dists;
    numPoints = dists.length;

    genes = new ArrayList<Integer>();
    for (int i = 0; i < numPoints; i++) {
      genes.add(i);
    }
    Collections.shuffle(genes);
  }

  DNA(double[][] dists, ArrayList<Integer> genes) {
    numPoints = dists.length;
    this.dists = dists;
    this.genes = genes;
  }

  double calcFitness() {
    fitness = 0;
    for (int i = 0; i < numPoints; i++) {
      fitness += dists[genes.get(i)][genes.get((i + 1) % numPoints)];
    }
    fitness = 10000.0 / fitness;
    return fitness;
  }

  // Improved Greedy Crossover Algorithm.
  // Reference:- https://arxiv.org/ftp/arxiv/papers/1209/1209.5339.pdf
  DNA crossover(DNA partner) {
    this.initNeighbourPathLists();
    partner.initNeighbourPathLists();

    ArrayList<Integer> childGenes = new ArrayList<Integer>();
    int currPoint = this.genes.get(0);
    while (nextInPath[currPoint] != currPoint) {
      childGenes.add(currPoint);
      this.deleteNode(currPoint);
      partner.deleteNode(currPoint);

      // Next neighbours.
      int nn1 = this.nextInPath[currPoint];
      int nn2 = this.prevInPath[currPoint];
      int nn3 = partner.nextInPath[currPoint];
      int nn4 = partner.prevInPath[currPoint];
      // Neighbouring point closest to currPoint is taken as next point.
      double minDist =
          Math.min(
              Math.min(dists[currPoint][nn1], dists[currPoint][nn2]),
              Math.min(dists[currPoint][nn3], dists[currPoint][nn4]));
      if (minDist == dists[currPoint][nn1]) {
        currPoint = nn1;
      } else if (minDist == dists[currPoint][nn2]) {
        currPoint = nn2;
      } else if (minDist == dists[currPoint][nn3]) {
        currPoint = nn3;
      } else if (minDist == dists[currPoint][nn4]) {
        currPoint = nn4;
      }
    }
    childGenes.add(currPoint);
    return new DNA(dists, childGenes);
  }

  void initNeighbourPathLists() {
    nextInPath = new int[numPoints];
    prevInPath = new int[numPoints];

    for (int i = 0; i < numPoints; i++) {
      nextInPath[genes.get(i)] = genes.get((i + 1) % numPoints);
      prevInPath[genes.get(i)] = genes.get((i - 1 + numPoints) % numPoints);
    }
  }

  // Remove pointers pointing to 'point' in circular doubly linked list.
  void deleteNode(int point) {
    int prevPoint = prevInPath[point];
    int nextPoint = nextInPath[point];
    nextInPath[prevPoint] = nextPoint;
    prevInPath[nextPoint] = prevPoint;
  }

  // Mutation functions.
  void twoPointSwap() {
    int a = int(random(numPoints));
    int b = int(random(numPoints));
    Collections.swap(genes, a, b);
  }

  void threePointSwap() {
    if (numPoints < 3) {
      return;
    }
    int a = int(random(numPoints));
    int b = int(random(numPoints));
    int c = int(random(numPoints));
    Collections.swap(genes, a, b); // a->b, b->a
    Collections.swap(genes, a, c); // b->c, c->a
  }

  void reverseSegment() {
    int a = int(random(numPoints));
    int b = int(random(numPoints));

    if (a > b) {
      int temp = a;
      a = b;
      b = temp;
    }
    reverse(genes, a, b);
  }

  void mutate(double mutationRate) {
    if (random(1) < mutationRate) {
      float val = random(1);
      if (val < 0.34) {
        twoPointSwap();
      } else if (val < 0.66) {
        threePointSwap();
      } else {
        reverseSegment();
      }
    }
  }
}
