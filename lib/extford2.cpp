#include <iostream>
#include <list>
#include <vector>
#include <stdlib.h>
#include <assert.h>

using namespace std;

template <class T>
inline void printl (const T& coll){
    typename T::const_iterator pos;

    std::cout << "[ ";
    for (pos=coll.begin(); pos!=coll.end(); ++pos) {
        std::cout << *pos << ' ';
    }
    std::cout << ']' << std::endl;
}


int main (int argc, char **argv){
	assert(argc >= 2);
	srand (836857);
	
	int n = atoi(argv[1]);
	int p = argc >= 3 ? atoi(argv[2]) : 100;
	if (n < 3){
		n = 3;
	}
	
	char *s = (char*) malloc(4 * n);
	s[0]=0;s[1]=1;s[2]=0;s[3]=0;s[4]=0; s[5]=1;s[6]=1;s[7]=1;s[8]=0;s[9]=1;
	int i = 10;

	int order = 3;
	int pow = 8;
	while (i < n){
		order += 2;
		pow *= 4;
		vector<bool> taken (pow, false);
		list<int> path;

		// Follow given prefix
		int index = 0;
		for (int j = 0; j < i; j++){
			index = (index * 2 + s[j]) % pow;
			if (j >= order-1){
				path.push_back(index);
				taken[index] = true;
			}
		}

		// Extend to Eulerian path
		list<int>::iterator next = path.end();
		list<int>::iterator curr = path.end();
		curr--;

		while (next != path.begin()){
			bool stuck = false;
			
			while (!stuck){
				stuck = true;
				int savedEdge = -1;
				
				for (int j = 0; j < 2; j++){
					int shift = (*curr * 2 + j) % pow;
					if (!taken[shift]){
						if (savedEdge != -1 || rand() % 100 < p){
							stuck = false;
							curr = path.insert(next, shift);
							taken[shift] = true;
							break;
						} else {
							savedEdge = shift;
						}
					}
				}
				
				if (stuck && savedEdge != -1){
					stuck = false;
					curr = path.insert(next, savedEdge);
					taken[savedEdge] = true;
				}
			}
		
			next--;
			curr--;
		}

		// Translate to string
		i = 0;
		index = 0;
		list<int>::iterator it = path.begin();
		int first = *it;
		int pow2 = pow / 2;
		while (i < order){
			s[i++] = first / pow2;
			first %= pow2;
			pow2 /= 2;
		}

		it++;
		while (it != path.end()){
			s[i++] = *it++ % 2;
		}
	}
	
	for(int j = 0; j < i; j++){
		cout << (int) s[j];
	}
	cout << endl;
	
	free(s);
	return 0;
}
