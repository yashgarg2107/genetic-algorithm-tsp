// Genetic Algorithm.
class GA extends AlgoBox {
  Population population;
  static final int populationSize = 100;
  static final int maxGenerations = 5000;
  static final double mutationRate = 0.01;

  GA(
      Rectangle container,
      TextBox titleBox,
      Rectangle upperBoard,
      Rectangle lowerBoard,
      TextBox stats,
      TextBox startButton,
      TextBox importButton) {
    super(container, titleBox, upperBoard, lowerBoard, stats, startButton, importButton);
  }

  @Override
  void init() {
    population = new Population(super.points, populationSize, maxGenerations, mutationRate);
    super.upperPath = population.bestInGeneration;
    super.lowerPath = population.bestSoFar;
  }

  @Override
  void run() {
    if (population.generation == population.maxGenerations) {
      super.isActive = false;
      return;
    }
    population.calcFitness();
    population.naturalSelection();
    population.generatePopulation();

    super.upperPath = population.bestInGeneration;
    super.lowerPath = population.bestSoFar;
    super.stats.text = getStats();
  }

  String getStats() {
    return String.format(
        "Generation: %d\nGen Best Fitness: %.6f\n\nBest Ever Fitness: %.6f\nBest Ever Distance: %.6f",
        population.generation,
        population.bestFitnessInGeneration,
        population.bestFitnessSoFar,
        population.bestDistanceSoFar);
  }
}
