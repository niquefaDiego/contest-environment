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

  string ansNext, outNext;
  bool ansHasNext, outHasNext;
  for ( int token = 0; ; ++token ) {

    ansHasNext = (bool)( ans >> ansNext );
    outHasNext = (bool)( out >> outNext );
    if ( ansHasNext && outHasNext ) {
      if ( ansNext == outNext ) continue;
      printf ( "Text %s: Wrong :( Token #%d differ (Expected \"%s\", Recieved \"%s\")",
      testId, token, ansNext.c_str(), outNext.c_str() );
    }
    else if ( !ansHasNext && !outHasNext )
      printf ( "Test %s: Correct :)", testId );
    else if ( ansHasNext && !outHasNext ) {
      if ( !token ) printf ( "Test %s: Wrong :( Output empty. Expected \"%s\" as first token", testId, ansNext.c_str() );
      else printf ( "Test %s: Incomplete output, token #%d \"%s\" expected but EOF was found",
      testId, token, ansNext.c_str() );
    }
    else {
      if ( !token ) printf ( "Test %s: There is no expected answer", testId );
      else printf ( "Test %s: Wrong :( Extra output found, expected EOF but token number %d \"%s\" was found",
      testId, token, outNext.c_str() );
    }
    printf ( "\n" );
    return 0;
  }
  
  ans.close();
  out.close();
  return 0;
}
