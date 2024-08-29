class Individual {
  int[] genome;
  int genomeSize;
  float length;

  Individual(int size) {
    genomeSize = size;
    genome = new int[genomeSize];
    ArrayList<Integer> indices = new ArrayList<Integer>();
    for (int i = 0; i < genomeSize; i++) {
      indices.add(i);
    }
    Collections.shuffle(indices);
    for (int i = 0; i < genomeSize; i++) {
      genome[i] = indices.get(i);
    }
  }

  Individual(int[] genes) {
    genomeSize = genes.length;
    genome = Arrays.copyOf(genes, genes.length);
  }

  void mutate(float rate) {
    if (random(1) < rate) {
      int i = int(random(genomeSize));
      int j = int(random(genomeSize));
      int temp = genome[i];
      genome[i] = genome[j];
      genome[j] = temp;
    }
  }

  void evaluate() {
    orderedCircles.placeCircles(genome);
    length = orderedCircles.computeBoundary();
  }
}
