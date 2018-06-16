#include <bits/stdc++.h>
using namespace std;

// args[] = { call, test id, input, answer file, output file }
int main ( int nArgs, const char* args[] )
{
  if ( nArgs != 5 ) {
    printf ( "Token checker requeries arguments: test id, input file, answer file and output file.\n" );
    printf ( "The arguments given are: " );
    for ( int i = 0; i < nArgs; ++i )
      printf ( "args[%d] = %s\n", i, args[i] );
    return 0;
  }
  const char* testId = args[1];

  ifstream ans (args[3]);
  ifstream out (args[4]);

  string next[2];
  bool hasNext[2];
  for ( int token = 0; ; ++token ) {

    hasNext[0] = !ans.eof();
    hasNext[1] = !out.eof();
    if ( hasNext[0] && hasNext[1] ) {
      ans >> next[0]; out >> next[1];
      if ( next[0] == next[1] ) continue;
      printf ( "Text %s: Wrong :( Token #%d differ (Expected \"%s\", Recieved \"%s\")",
      testId, token, next[0].c_str(), next[1].c_str() );
    }
    else if ( !hasNext[0] && !hasNext[1] )
      printf ( "Test %s: Correct :)", testId );
    else if ( hasNext[0] && !hasNext[1] ) {
      ans >> next[0];
      if ( !token ) printf ( "Test %s: Wrong :( Output empty. Expected \"%s\" as first token", testId, next[0].c_str() );
      else printf ( "Test %s: Incomplete output, token #%d \"%s\" expected but EOF was found",
      testId, token, next[0].c_str() );
    }
    else {
      out >> next[1];
      if ( !token ) printf ( "Test %s: There is no expected answer", testId );
      else printf ( "Test %s: Wrong :( Extra output found, expected EOF but token number %d \"%s\" was found",
      testId, token, next[1].c_str() );
    }
    printf ( "\n" );
    return 0;
  }
  
  ans.close();
  out.close();
  return 0;
}
