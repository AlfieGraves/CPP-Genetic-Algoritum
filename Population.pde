class Population {
  Individual[] population;
  int size;
  float mutationRate;
  int maxGens;
  boolean finished;
  Individual bestSolution;
  float bestLength;

  Population(int size, int maxGens, float mutationRate) {
    this.size = size;
    this.maxGens = maxGens;
    this.mutationRate = mutationRate;
    population = new Individual[size];
    for (int i = 0; i < size; i++) {
      population[i] = new Individual(numCircles);
    }
    bestSolution = null;
    bestLength = Float.MAX_VALUE;
    finished = false;
  }

  Individual getBest() {
    return bestSolution;
  }

  Individual tournamentSelection() {
    Individual[] tournament = new Individual[tournamentSize];
    for (int i = 0; i < tournamentSize; i++) {
      tournament[i] = population[int(random(size))];
    }
    Individual best = tournament[0];
    for (int i = 1; i < tournamentSize; i++) {
      if (tournament[i].length < best.length) {
        best = tournament[i];
      }
    }
    return best;
  }

  void evolve(int gen) {
    if (gen > maxGens) {
      finished = true;
      return;
    }

    for (int i = 0; i < size; i++) {
      population[i].evaluate();
      if (population[i].length < bestLength) {
        bestLength = population[i].length;
        bestSolution = population[i];
      }
    }

    Individual[] newPopulation = new Individual[size];
    for (int i = 0; i < size; i++) {
      Individual parent1 = tournamentSelection();
      Individual parent2 = tournamentSelection();
      newPopulation[i] = crossover(parent1, parent2);
      newPopulation[i].mutate(mutationRate);
    }
    population = newPopulation;
  }

  Individual crossover(Individual parent1, Individual parent2) {
    int[] child = new int[parent1.genomeSize];
    Arrays.fill(child, -1);
    int start = int(random(parent1.genomeSize));
    int end = int(random(parent1.genomeSize));
    if (start > end) {
      int temp = start;
      start = end;
      end = temp;
    }
    for (int i = start; i < end; i++) {
      child[i] = parent1.genome[i];
    }
    int index = end;
    for (int i = 0; i < parent2.genomeSize; i++) {
      if (!containsGene(child, parent2.genome[i])) {
        if (index >= child.length) index = 0;
        child[index++] = parent2.genome[i];
      }
    }
    return new Individual(child);
  }

  boolean containsGene(int[] genome, int gene) {
    for (int i : genome) {
      if (i == gene) return true;
    }
    return false;
  }
}
