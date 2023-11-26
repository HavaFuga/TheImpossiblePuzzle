int[][] puzzle;
int gridSize = 3; // Adjust the size of the puzzle grid as needed
int tileSize;
boolean won = false;

void setup() {
  size(600, 600);
  tileSize = width / gridSize;

  // Initialize the puzzle with a solved configuration
  initPuzzle();
  shufflePuzzle(100); // Shuffle the puzzle pieces
}

void draw() {
  background(255);

  // Display the puzzle
  displayPuzzle();

  // Check if the puzzle is solved
  if (won) {
    won = true;
    displayWinScreen();
  }
}

void displayWinScreen() {
  background(255);  // Clear the background
  textSize(32);
  fill(0, 102, 153);
  text("You Win!", width/2 - 50, height/2);
}


void mousePressed() {
  if (!won) {
    // Attempt to move the clicked puzzle piece
    int clickedRow = mouseY / tileSize;
    int clickedCol = mouseX / tileSize;

    movePiece(clickedRow, clickedCol);
    if (checkWin()) won = true;
  }
}

void initPuzzle() {
  // Initialize the puzzle with a solved configuration
  puzzle = new int[gridSize][gridSize];
  int count = 1;

  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      puzzle[i][j] = count++;
    }
  }

  puzzle[gridSize - 1][gridSize - 1] = 0; // Empty space represented by 0
}

void shufflePuzzle(int moves) {
  // Shuffle the puzzle pieces by making random moves
  for (int i = 0; i < moves; i++) {
    int direction = int(random(4));

    // Attempt to make a random move
    int emptyRow = getEmptySpaceRow();
    int emptyCol = getEmptySpaceCol();

    switch (direction) {
      case 0: // Move up
        if (emptyRow > 0) {
          swap(emptyRow, emptyCol, emptyRow - 1, emptyCol);
        }
        break;
      case 1: // Move down
        if (emptyRow < gridSize - 1) {
          swap(emptyRow, emptyCol, emptyRow + 1, emptyCol);
        }
        break;
      case 2: // Move left
        if (emptyCol > 0) {
          swap(emptyRow, emptyCol, emptyRow, emptyCol - 1);
        }
        break;
      case 3: // Move right
        if (emptyCol < gridSize - 1) {
          swap(emptyRow, emptyCol, emptyRow, emptyCol + 1);
        }
        break;
    }
  }
}

void displayPuzzle() {
  // Display the puzzle pieces
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      int value = puzzle[i][j];
      if (value != 0) {
        fill(200);
        rect(j * tileSize, i * tileSize, tileSize, tileSize);
        fill(0);
        textSize(32);
        textAlign(CENTER, CENTER);
        text(value, j * tileSize + tileSize / 2, i * tileSize + tileSize / 2);
      }
    }
  }
}

void movePiece(int row, int col) {
  // Attempt to move the puzzle piece to the empty space
  int emptyRow = getEmptySpaceRow();
  int emptyCol = getEmptySpaceCol();

  if ((Math.abs(row - emptyRow) == 1 && col == emptyCol) ||
      (Math.abs(col - emptyCol) == 1 && row == emptyRow)) {
    swap(row, col, emptyRow, emptyCol);
  }
}

void swap(int row1, int col1, int row2, int col2) {
  // Swap two puzzle pieces in the grid
  int temp = puzzle[row1][col1];
  puzzle[row1][col1] = puzzle[row2][col2];
  puzzle[row2][col2] = temp;
}

int getEmptySpaceRow() {
  // Find the row of the empty space (0)
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (puzzle[i][j] == 0) {
        return i;
      }
    }
  }
  return -1;
}

int getEmptySpaceCol() {
  // Find the column of the empty space (0)
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (puzzle[i][j] == 0) {
        return j;
      }
    }
  }
  return -1;
}

boolean checkWin() {
  // Check if the puzzle is in the solved configuration
  int count = 1;

  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (puzzle[i][j] != count++ % (gridSize * gridSize)) {
        return false;
      }
    }
  }

  return true;
}
