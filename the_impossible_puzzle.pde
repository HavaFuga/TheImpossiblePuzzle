int[][] puzzle;
int gridSize = 3;
int tileSize;
boolean hasNumber = true;
boolean isColored = false;
String puzzleColor = "rainbow";
boolean won = false;
boolean wonAllLevels = false;
int maxLevels = 5;
int currentLevel = 1;


void setup() {
  size(600, 600);
  tileSize = width / gridSize;

  startLevel(currentLevel);
}

void draw() {
  background(255);

  displayPuzzle();

  // check if the puzzle is solved
  if (won) {
    displayWinScreen();
  } 
  if (wonAllLevels) {
    displayWinScreen();
  }
}

void keyPressed() {
 
  if (key == 'H' || key == 'h') {
    hasNumber = !hasNumber;
  } 
  
  if (key == 'C' || key == 'c') {
    if (puzzleColor == "rainbow") {
      setLevel(currentLevel);
    } else {
      puzzleColor = "rainbow";
    }
  }
}

void displayWinScreen() {
  if (wonAllLevels) {
    // final screen
      background(255, 182, 193); 
      textSize(32);
      fill(0);
      text("You are the best <3", width / 2 - 150, height / 2);
  } else {
    
    fill(200);
    rect(width/2, height/2,50,50) ;
    textSize(32);
    fill(0, 102, 153);
    text("Good Job!", width/2, height/2);
  
    // "next lvl" button
    rect(width / 2 - 75, height / 2 + 50, 150, 50);
    fill(255);
    textSize(20);
    text("Next Level", width / 2 - 50, height / 2 + 85);
  }
}

void mousePressed() {
  // check if "next lvl" button is pressed
  if (won && mouseX > width / 2 - 75 && mouseX < width / 2 + 75 && mouseY > height / 2 + 50 && mouseY < height / 2 + 100) {
    won = false;
    hasNumber = false;
    currentLevel++;

    if (currentLevel > maxLevels) {
      wonAllLevels = true;
    } else {
      startLevel(currentLevel);
    }
  } else {
    // move clicked puzzle piece
    int clickedRow = mouseY / tileSize;
    int clickedCol = mouseX / tileSize;

    movePiece(clickedRow, clickedCol);
    if (checkWin()) won = true;
  }
}

void setLevel(int level) {
  switch (level) {
    case 1:
      gridSize = 3;
      break;
    case 2:
      hasNumber = false;
      gridSize = 4;
      break;
    case 3:
      puzzleColor = "tritanopia";
      break;
    /*case 4:      
      puzzleColor = "protanopia";   // similar to deutronopia
      break;*/
    case 4:
      puzzleColor = "deutranopia"; // 
      break;
    case 5:
      puzzleColor = "gray";
      break;
    default:
      // unexpected level TO-DO
      break;
  }
}

void startLevel(int level) {
  setLevel(level);

  tileSize = width / gridSize;

  // init puzzle
  initPuzzle();
  shufflePuzzle(100); 
}

void initPuzzle() {
  // init puzzle depending on level configuration
  puzzle = new int[gridSize][gridSize];
  int count = 1;

  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      puzzle[i][j] = count++;
    }
  }

  puzzle[gridSize - 1][gridSize - 1] = 0; // empty space = 0
}

void shufflePuzzle(int moves) {
  // shuffle the puzzle pieces
  for (int i = 0; i < moves; i++) {
    int direction = int(random(4));

    int emptyRow = getEmptySpaceRow();
    int emptyCol = getEmptySpaceCol();

    switch (direction) {
      case 0: // up
        if (emptyRow > 0) {
          swap(emptyRow, emptyCol, emptyRow - 1, emptyCol);
        }
        break;
      case 1: // down
        if (emptyRow < gridSize - 1) {
          swap(emptyRow, emptyCol, emptyRow + 1, emptyCol);
        }
        break;
      case 2: // left
        if (emptyCol > 0) {
          swap(emptyRow, emptyCol, emptyRow, emptyCol - 1);
        }
        break;
      case 3: // right
        if (emptyCol < gridSize - 1) {
          swap(emptyRow, emptyCol, emptyRow, emptyCol + 1);
        }
        break;
    }
  }
}

void displayPuzzle() {
  // display puzzle pieces
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      int value = puzzle[i][j];
      if (value != 0) {
        
        color pieceColor = color(200);
        float normalizedValue = map(value, 1, gridSize * gridSize-1, 0, 1);
        // Use lerpColor to interpolate between yellow, red, and blue
            if (normalizedValue < 0.25) {
              pieceColor = lerpColor(color(255, 0, 0), color(255, 165, 0), map(normalizedValue, 0, 0.25, 0, 1));
            } else if (normalizedValue < 0.5) {
              pieceColor = lerpColor(color(255, 165, 0), color(255, 255, 0), map(normalizedValue, 0.25, 0.5, 0, 1));
            } else if (normalizedValue < 0.75) {
              pieceColor = lerpColor(color(255, 255, 0), color(0, 255, 0), map(normalizedValue, 0.5, 0.75, 0, 1));
            } else {
              pieceColor = lerpColor(color(0, 255, 0), color(0, 0, 255), map(normalizedValue, 0.75, 1, 0, 1));
            }

        fill(pieceColor);
        rect(j * tileSize, i * tileSize, tileSize, tileSize);
        
        if (hasNumber) {
          fill(0);
          textSize(32);
          textAlign(CENTER, CENTER);
          text(value, j * tileSize + tileSize / 2, i * tileSize + tileSize / 2);
        }
      }
    }
  }
  
  
        
        switch (puzzleColor) {         
          case "protanopia":  
            applyProtanopiaFilter();
            break;
          
          case "deutranopia":
            applyDeuteranopiaFilter();
            break;
          
          case "tritanopia":
            applyTritanopiaFilter();
            break;      
            
          case "gray":
            applyGrayFilter();
            break;
            
          default:
            break;

        }
}

// applyProtanopiaFilter();
void applyProtanopiaFilter() {
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float b = blue(pixels[i]);
    float tr = 0.10889 * r + 0.89111 * g + 0 * b;
    float tg = 0.10889 * r + 0.89111 * g + 0 * b;
    float tb = 0.00447 * r - 0.00447 * g + 1 * b;
    pixels[i] = color(tr, tg, tb);
  }
  updatePixels();
}

// applyDeuteranopiaFilter();
void applyDeuteranopiaFilter() {
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float b = blue(pixels[i]);
    float tr = 0.29031 * r + 0.70969 * g + 0 * b;
    float tg = 0.29031 * r + 0.70969 * g + 0 * b;
    float tb = -0.02197 * r + 0.02197 * g + 1 * b;
    pixels[i] = color(tr, tg, tb);
  }
  updatePixels();
}

// applyTritanopiaFilter();
void applyTritanopiaFilter() {
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float b = blue(pixels[i]);
    float tr = 0.93337 * r + 0.19999 * g - 0.13336 * b;
    float tg = 0.05809 * r + 0.82565 * g + 0.11626 * b;
    float tb = -0.37923 * r + 1.13825 * g + 0.24098 * b;
    pixels[i] = color(tr, tg, tb);
  }
  updatePixels();
}

// apply complete color blindness
void applyGrayFilter() {
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    float grayValue = red(pixels[i]) * 0.3 + green(pixels[i]) * 0.59 + blue(pixels[i]) * 0.11;
    pixels[i] = color(grayValue);
  }
  updatePixels();  
}


void movePiece(int row, int col) {
  // move piece to empty space
  int emptyRow = getEmptySpaceRow();
  int emptyCol = getEmptySpaceCol();

  if ((Math.abs(row - emptyRow) == 1 && col == emptyCol) || (Math.abs(col - emptyCol) == 1 && row == emptyRow)) {
    swap(row, col, emptyRow, emptyCol);
  }
}

void swap(int row1, int col1, int row2, int col2) {
  // swap two pieces 
  int temp = puzzle[row1][col1];
  puzzle[row1][col1] = puzzle[row2][col2];
  puzzle[row2][col2] = temp;
}

int getEmptySpaceRow() {
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
  // check if puzzle is solved
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
