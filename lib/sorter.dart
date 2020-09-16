List sortHand(List tiles){
  List tilesLeft = tiles;
  List sortedHand = [];
  int duplicates = 0;
  String handInfo = "";
  for (int i = 0;i < tilesLeft.length;i++){
    duplicates = 0;
    for (int f = 0; f < tilesLeft.length;f++){
      if (i != f && tilesLeft[i] == tilesLeft[f]) {
        duplicates++;
      }
    }
    if (duplicates == 2) {
      handInfo += " A pung of " + tilesLeft[i] + ", ";
      for (int f = 0; f < tilesLeft.length;f++) {
        if (i != f && tilesLeft[i] == tilesLeft[f]) {
          sortedHand.add(tilesLeft[f]);
          tilesLeft.removeAt(f);
          f--; // F stays the same so even after removing the tile from the list it links to the next tile
        }
      }
      sortedHand.add(tilesLeft[i]);
      tilesLeft.removeAt(i);
      i--;
    }
    if (duplicates == 3) {
      handInfo += " A kong of " + tilesLeft[i] + ", ";
      for (int f = 0; f < tilesLeft.length;f++) {
        if (i != f && tilesLeft[i] == tilesLeft[f]) {
          sortedHand.add(tilesLeft[f]);
          tilesLeft.removeAt(f);
          f--; // F stays the same so even after removing the tile from the list it links to the next tile
        }
      }
      sortedHand.add(tilesLeft[i]);
      tilesLeft.removeAt(i);
      i--;
    }
  }
  List dotList = [];
  List bamList = [];
  List crackList = [];
  for (int i = 0;i < tilesLeft.length; i++) {
      for (int f = 1; f <= 9; f++) {
        if (tilesLeft.length != 0 && tilesLeft[i] == f.toString() + " Dot") {
          dotList.add(f);
          tilesLeft.removeAt(i);
          i = 0;
          f = 0;
        }
      }
  }
  for (int i = 0;i < tilesLeft.length; i++) {
    for (int f = 1; f <= 9;f++){
      if (tilesLeft.length != 0 && tilesLeft[i] == f.toString() + " Bam"){
        bamList.add(f);
        tilesLeft.removeAt(i);
        i = 0;
        f = 0;
      }
    }
  }
  for (int i = 0;i < tilesLeft.length; i++) {
    for (int f = 1; f <= 9; f++) {
      if (tilesLeft.length != 0 && tilesLeft[i] == f.toString() + " Crack") {
        crackList.add(f);
        tilesLeft.removeAt(i);
        i = 0;
        f = 0;
      }
    }
  }
  dotList.sort();
  bamList.sort();
  crackList.sort();
  bool below = false;
  bool above = false;
  int belowIndex = 0;
  int aboveIndex = 0;
  for (int i = 0; i < dotList.length;i++){
    above = false;
    below = false;
    for (int f = 0;f < dotList.length;f++){
      if (dotList[i] == dotList[f] + 1){
        below = true;
        belowIndex = f;
      }
      if (dotList[i] == dotList[f] - 1){
        above = true;
        aboveIndex = f;
      }
    }
    if (below && above){
      handInfo += " A chow of Dots, ";
      sortedHand.add(dotList[aboveIndex].toString() + " Dot");
      sortedHand.add(dotList[i].toString() + " Dot");
      sortedHand.add(dotList[belowIndex].toString() + " Dot");
      dotList.removeAt(aboveIndex);
      dotList.removeAt(i);
      dotList.removeAt(belowIndex);
      i = 0;
    }
  }
  for (int i = 0; i < bamList.length;i++){
    above = false;
    below = false;
    for (int f = 0;f < bamList.length;f++){
      if (bamList[i] == bamList[f] + 1){
        below = true;
        belowIndex = f;
      }
      if (bamList[i] == bamList[f] - 1){
        above = true;
        aboveIndex = f;
      }
    }
    if (below && above){
      handInfo += " A chow of Bams, ";
      sortedHand.add(bamList[aboveIndex].toString() + " Bam");
      sortedHand.add(bamList[i].toString() + " Bam");
      sortedHand.add(bamList[belowIndex].toString() + " Bam");
      bamList.removeAt(aboveIndex);
      bamList.removeAt(i);
      bamList.removeAt(belowIndex);
      i = 0;
    }
  }
  for (int i = 0; i < crackList.length;i++){
    above = false;
    below = false;
    for (int f = 0;f < crackList.length;f++){
      if (crackList[i] == crackList[f] + 1){
        below = true;
        belowIndex = f;
      }
      if (crackList[i] == crackList[f] - 1){
        above = true;
        aboveIndex = f;
      }
    }
    if (below && above){
      handInfo += " A chow of Cracks, ";
      sortedHand.add(crackList[aboveIndex].toString() + " Crack");
      sortedHand.add(crackList[i].toString() + " Crack");
      sortedHand.add(crackList[belowIndex].toString() + " Crack");
      crackList.removeAt(aboveIndex);
      crackList.removeAt(i);
      crackList.removeAt(belowIndex);
      i = 0;
    }
  }
  for (int i = 0;i < dotList.length; i++) {
    if (dotList.length != 0) {
      sortedHand.add(dotList[i].toString() + " Dot");
    }
  }
  for (int i = 0;i < bamList.length; i++) {
    if (bamList.length != 0) {
      sortedHand.add(bamList[i].toString() + " Bam");
    }
  }
  for (int i = 0;i < crackList.length; i++) {
    if (crackList.length != 0) {
      sortedHand.add(crackList[i].toString() + " Crack");
    }
  }
  tilesLeft.sort();
  sortedHand += tilesLeft;
  print(dotList);
  print(handInfo);
  print(sortedHand.toString());
  sortedHand.add(handInfo);
  return sortedHand;
}