void checkport() {
  char val;
  if (port.available() > 0)
  {
    val = port.lastChar();
    if (val == 'a')
    {
      print("a");
      showVectors = !showVectors;
    } else if (val == 'b')
    {
      print("b");
      showCircles = !showCircles;
    }
  }
}
