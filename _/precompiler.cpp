#include <bits/stdc++.h>
using namespace std;
//What a Terrible Failure
#define wtf(x)   { cerr<<x<<endl; exit(EXIT_FAILURE); }

const int SIGMA = 26*2+10+1; //0-9a-zA-Z_
char charId[1<<8];

struct ShortCut {
  int nArgs;
  vector<string> strs;
  vector<int> argAt;
  
  static pair<string,ShortCut> fromLine(const string& line) {
    unsigned space = line.find(' ');
    if ( space == string::npos ) wtf("No space found in short '" << line << "'")
    if ( isdigit(line[0]) )
      wtf("keys can't start with a digit, shortcut =\"" << line << "\"")
      
    unsigned open = line.find('(');
    unsigned close = line.find(')');
    if ( !( open > 0 && close == space-1 && open == space-3 && isdigit(line[open+1]) ) )
      wtf("shortcut \"'" << line << "\" doesn't follow format: "
        << "\"key(nArgs_from_0_to_9) value\"\n"
        << "Example: \"rep(2) for(int %0 = 0; %0 < %1; ++%0)\"");
    
    ShortCut shortCut;
    shortCut.nArgs = line[open+1]-'0';
    unsigned last = space+1;
    for ( unsigned i = space+1; i+1 < line.size(); ++i )
      if ( line[i] == '%' && isdigit(line[i+1]) ) {
        if ( line[i+1]-'0' >= shortCut.nArgs )
          wtf("Invalid argument %" << line[i+1] << " in \"" << line << "\"");
        shortCut.argAt.push_back ( line[i+1]-'0' );
        shortCut.strs.push_back ( line.substr(last, i-last) );
        last = ++i + 1;
      }
    shortCut.strs.push_back ( line.substr(last) );
    return make_pair ( line.substr(0,open), shortCut );
  }
  
  string eval ( const vector<string>& args ) {
    stringstream ss;
    for ( unsigned i = 0; i < argAt.size(); ++i )
      ss << strs[i] << args[argAt[i]];
    ss << strs.back();
    return ss.str();
  }
};

struct TrieNode
{
  TrieNode* child[SIGMA];
  string value; //if not empty, then it's a leaf
  vector<ShortCut> shortCuts; 
  
  void addShortCut ( const string& key, ShortCut shortCut ) {
    TrieNode* node = this;
      for ( unsigned i = 0; i < key.size(); ++i ) {
        const int ch = charId[(int)key[i]];
        if ( ch == -1 )
          wtf("keys must match regex [0-9a-zA-Z_]* (shortcuts.txt, key=\"" << key << "\")")
        if ( !node->child[ch] ) node->child[ch] = new TrieNode();
        node = node->child[ch];
      }
      for ( auto& it : node->shortCuts )
        if ( it.nArgs == shortCut.nArgs )
          wtf ( "Can't have two shortcuts with the same key and same args" );
      node->shortCuts.push_back ( shortCut );
  }

  void add ( const string& key, string _value )
  {
      if(key.empty()) wtf("keys can't be empty")
      if(isdigit(key[0])) wtf("keys can't start with a digit")
      TrieNode* node = this;
      bool flag = false; // true if one or more nodes are instantiated
      for ( int i = 0; i < key.size(); ++i ) {
        const int ch = charId[(int)key[i]];
        if ( ch == -1 )
          wtf("keys must match regex [0-9a-zA-Z_]* (key=\"" << key << "\")")
        if ( !node->child[ch] ) {
          node->child[ch] = new TrieNode();
          flag = true;
        }
        node = node->child[ch];
      }

      if(!flag) wtf( "a key can't be preffix of another key" );
      node->value = _value;
  }

  TrieNode ( ) {
    memset ( child, 0, sizeof(child) );
    value = "";
  }

} trie;

void readDefines ( const char* definesFile ) {
  ifstream in (definesFile, ifstream::in);
  for ( string line; getline(in, line); ) {
    if ( line.empty() ) continue;
    unsigned i = line.find(' ');
    if ( i == string::npos )
      wtf("line '" << line << "' in define.txt doesn't have a space")
    string key = line.substr(0,i);
    string val = line.substr(i+1);
    trie.add(key, "#define " + key + " " + val );
  }
  in.close();
}

void readTypedefs ( const char* definesFile ) {
  ifstream in (definesFile, ifstream::in);
  for ( string line; getline(in, line); ) {
    if ( line.empty() ) continue;
    unsigned i = line.find(' ');
    if ( i == string::npos )
      wtf("line '" << line << "' in typedef.txt doesn't have a space")
    string key = line.substr(0,i);
    string val = line.substr(i+1);
    trie.add(key, "typedef " + val + " " + key + ";");
  }
  in.close();
}

void readShortCuts ( const char* shortCutsFile ) {
  ifstream in (shortCutsFile, ifstream::in);
  for ( string line; getline(in, line); ) {
    if ( line.empty() ) continue;
    pair<string,ShortCut> tmp = ShortCut::fromLine(line);
    trie.addShortCut(tmp.first, tmp.second);
  }
  in.close();
}

int main(int nArgs, char* args[])
{
  int charCnt = 0;
  memset ( charId, -1, sizeof(charId) );
  for ( char c = '0'; c <= '9'; ++c ) charId[(int)c] = charCnt++;
  for ( char c = 'a'; c <= 'z'; ++c ) charId[(int)c] = charCnt++;
  for ( char c = 'A'; c <= 'Z'; ++c ) charId[(int)c] = charCnt++;
  charId['_'] = charCnt++;
  assert ( charCnt == SIGMA );

  readDefines("_\\defines.txt");
  readTypedefs("_\\typedefs.txt");
  readShortCuts("_\\shortcuts.txt");
  
  vector<string> source, source1;
  for ( string line; getline ( cin, line ); ) {
    if ( !line.empty() && line[0] == '@' ) {
      line[0] = ' ';
      stringstream ss ( line );
      string file;
      vector<string> args;
      ss >> file;
      for ( string arg; ss >> arg; )
        args.push_back ( arg );
      ifstream inp ( ("_\\notebook\\" + file + ".txt").c_str(), ifstream::in );
      if ( inp.fail() )
        wtf ( "notebook file " << file << " couldn't be opened" );
      for ( string x; getline ( inp, x ); ) {
        for ( int i = args.size()-1; i >= 0; --i ) {
          stringstream ss;
          ss << "%" << i;
          string old = ss.str();
          for ( unsigned j; ( j = x.find(old) ) != string::npos; ) {
            x.replace ( j, old.size(), args[i] );
          }
        }
        source.push_back ( x );
      }
      inp.close();
    }
    else
      source.push_back ( line );
  }

  unordered_set<string> sourceSet;
  unordered_set<string> found;

  for ( string line : source ) {
    for ( unsigned i = 0; i < line.size(); ++i ) {
      if ( i > 0 && charId[(int)line[i-1]] != -1 ) continue;
      TrieNode* node = &trie;
      int ch, oldI = i;
      for ( ; node && i < (int)line.size() && ( ch = charId[(int)line[i++]] ) != -1; )
        node = node->child[ch];
      i--;
  
      if ( !node ) continue;
      if ( node->shortCuts.size() ) {
        int open = i, close = -1;
        vector<int> commas;
        while ( open < line.size() && line[open] <= 32 ) open++;
        if ( open == line.size() || line[open] != '(' ) continue;
        for ( int k = open+1, bal = 1; k < line.size(); ++k ) {
          if ( line[k] == '(' ) bal++;
          else if ( line[k] == ',' && bal == 1 ) commas.push_back(k);
          else if ( line[k] == ')' ) if ( --bal == 0 ) { close = k; break; }
        }
        int argsFound = close == open+1 ? 0 : commas.size()+1;
        for ( auto& scut : node->shortCuts ) {
          if ( scut.nArgs == argsFound ) {
            vector<string> args;
            int last = open+1;
            
            for ( int x : commas ) {
              args.push_back ( line.substr ( last, x - last ) );
              last = x+1;
            }
            args.push_back ( line.substr ( last, close - last ) );
            
            line = line.substr ( 0, i=oldI ) + scut.eval ( args ) + line.substr(close+1);
            break;
          }
        }
      }
      else if ( node->value.size() )
        found.insert(node->value);
    }
    
    source1.push_back ( line );
    sourceSet.insert ( line );
  }
  source.swap(source1);
  source1.clear();

  vector<string> defines, typedefs;
  for ( string line : found ) {
    if ( sourceSet.count(line) ) continue;
  	if ( line[0] == '#' ) defines.push_back ( line );
    else typedefs.push_back ( line );
  }

  for ( string line : source ) {
	  if ( line.find ( "using namespace std" ) != string::npos ) {
      for ( string s : defines ) cout << s << endl;
      cout << line << endl;
      for ( string s : typedefs ) cout << s << endl;
	  }
    else cout << line << endl;
  }

  return 0;
}
