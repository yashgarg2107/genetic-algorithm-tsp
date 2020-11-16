class Population {
  ArrayList<DNA> population;
  ArrayList<Double> normalizedFitness;
  ArrayList<DNA> matingPool;

  ArrayList<Point> points;
  ArrayList<Integer> bestSoFar;
  ArrayList<Integer> bestInGeneration;

  int generation = 0;
  int populationSize = 0;
  int maxGenerations = 0;
  double mutationRate = 0;
  double bestFitnessSoFar = 0;
  double bestFitnessInGeneration = 0;
  double bestDistanceSoFar = Integer.MAX_VALUE;
  double[][] dists;

  Population(ArrayList<Point> points, int populationSize, int maxGenerations, double mutationRate) {
    this.points = points;
    dists = computeDistMatrix(points);
    this.populationSize = populationSize;
    this.maxGenerations = maxGenerations;
    this.mutationRate = mutationRate;

    this.population = new ArrayList<DNA>();
    this.normalizedFitness = new ArrayList<Double>();
    this.matingPool = new ArrayList<DNA>();

    generation++;
    for (int i = 0; i < populationSize; i++) {
      population.add(new DNA(dists));
    }
    calcFitness();
  }

  void calcFitness() {
    bestFitnessInGeneration = 0;
    double totalFitness = 0;
    for (int i = 0; i < populationSize; i++) {
      double fitness = population.get(i).calcFitness();
      totalFitness += fitness;

      if (fitness > bestFitnessInGeneration) {
        bestFitnessInGeneration = fitness;
        bestInGeneration = population.get(i).genes;
      }

      if (fitness > bestFitnessSoFar) {
        bestFitnessSoFar = fitness;
        bestSoFar = new ArrayList<Integer>(population.get(i).genes);
        bestDistanceSoFar = pathDist(dists, bestSoFar);
      }
    }

    for (int i = 0; i < populationSize; i++) {
      normalizedFitness.add(population.get(i).fitness / totalFitness);
      normalizedFitness.set(
          i, normalizedFitness.get(i) + (i - 1 >= 0 ? normalizedFitness.get(i - 1) : 0));
    }
  }

  void naturalSelection() {
    matingPool = new ArrayList<DNA>();
    for (int i = 0; i < populationSize * 2; i++) {
      float val = random(1);
      for (int j = 0; j < populationSize; j++) {
        if (val < normalizedFitness.get(j)) {
          matingPool.add(population.get(j));
          break;
        }
      }
    }
  }

  void generatePopulation() {
    population.clear();
    for (int i = 0; i < populationSize * 2; i += 2) {
      DNA parentA = matingPool.get(i);
      DNA parentB = matingPool.get(i + 1);
      DNA child = parentA.crossover(parentB);
      child.mutate(mutationRate);
      population.add(child);
    }
    generation++;
  }
}
