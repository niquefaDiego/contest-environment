#include <bits/stdc++.h>
using namespace std;
#define SEPARATOR '\\'
#define MARK "==="

string folder;

string fileName ( int id, string ext = "in" ) {
  stringstream ss;
  ss << folder << id << '.' << ext;
  return ss.str();
}

bool canOpen ( string file ) {
  ifstream f( file.c_str() );
  bool r = !f.fail();
  f.close();
  return r;
}

int main ( int nArgs, char* args[] ) {
  if ( nArgs > 1 ) {
    folder = args[1];
    folder.push_back(SEPARATOR);
  }
  
  int caseId = 1;
  while ( canOpen(fileName(caseId)) ) caseId *= 2;
  do { caseId--; }
  while ( caseId >= 0 && !canOpen(fileName(caseId)) );

  for ( string line; getline(cin,line); ) {
    
    while ( canOpen(fileName(++caseId)) );
    
    ofstream inpF ( fileName(caseId).c_str(), ofstream::out );
    while ( line != MARK ) {
      inpF << line << "\n";
      getline ( cin, line );
    }
    inpF.close();
    
    ofstream ansF ( fileName(caseId,"out").c_str(), ofstream::out );
    while ( true ) {
      if ( !getline(cin, line) ) {
        ansF.close();
        return 0;
      }
      if ( line == MARK ) break;
      ansF << line << "\n";
    }
    ansF.close();
  }
  
  return 0;
}
