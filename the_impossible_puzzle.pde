PImage originalImage;
PImage colorblindImage;

int currentLevel = 1;
int maxLevels = 5;

void setup() {
  size(800, 600);

  // Load the original image
  originalImage = loadImage("original.jpg");  // Replace "original.jpg" with the path to your image

  // Start the game
  startLevel(currentLevel);
}

void draw() {
  // Display the current colorblind image
  image(colorblindImage, 0, 0, width, height);
}

void mousePressed() {
  // Check if the puzzle is solved
  if (puzzleIsSolved()) {
    // Move to the next level
    currentLevel++;

    // Check if all levels are completed
    if (currentLevel > maxLevels) {
      // Display game over or victory screen
      println("Game Over! You completed all levels.");
    } else {
      // Start the next level
      startLevel(currentLevel);
    }
  }
}

void startLevel(int level) {
  // Update the colorblind image for the current level
  updateColorblindImage(level);
}

void updateColorblindImage(int level) {
  // Determine the colorblind type for the current level
  String colorblindType = getColorblindType(level);

  // Save the original image as a temporary file (temp.png)
  originalImage.save("temp.jpg");

  // Call the Python script to perform colorblind simulation
  callPythonScript("temp.jpg", colorblindType);

  // Load the simulated colorblind image
  colorblindImage = loadImage("temp_" + colorblindType + ".jpg");  // Adjust the filename based on your Python script's output
}

boolean puzzleIsSolved() {
  // Add code to check if the puzzle is solved
  return false;
}

String getColorblindType(int level) {
  // Determine the colorblind type for the current level (e.g., alternate between protanopia, deuteranopia, tritanopia)
  if (level % 3 == 1) {
    return "Protanopia";
  } else if (level % 3 == 2) {
    return "Deuteranopia";
  } else {
    return "Tritanopia";
  }
}

void callPythonScript(String inputImage, String cbType) {
  // Get the absolute path to the Python script in the sketch's data folder
String scriptPath = sketchPath("") + "script.py";
String imagePath = sketchPath("") + inputImage;
println("inputImage " + inputImage);
  String[] command = {
    "python",
    scriptPath, 
    imagePath,
    "--cb",
    cbType
  };

  ProcessBuilder processBuilder = new ProcessBuilder(command);
  processBuilder.redirectErrorStream(true);  // Redirect error stream to output stream

  try {
    Process process = processBuilder.start();

    // Read the output of the process
    java.io.InputStream inputStream = process.getInputStream();
    BufferedReader reader = new BufferedReader(new java.io.InputStreamReader(inputStream));
    String line;
    while ((line = reader.readLine()) != null) {
      println(line);
    }

    // Wait for the process to complete
    int exitCode = process.waitFor();
    println("Python script exited with code: " + exitCode);

  } catch (Exception e) {
    e.printStackTrace();
  }
}
