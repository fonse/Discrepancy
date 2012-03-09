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
	char *s = (char*) malloc(3 * n);
	s[0]=0;s[1]=1;s[2]=2;
	int i = 3;

	int pow = 3;
	int order = 1;
	while (i < n){
		order++;
		pow *= 3;
		vector<bool> taken (pow, false);
		list<int> path;

		// Follow given prefix
		int index = 0;
		for (int j = 0; j < i; j++){
			index = (index * 3 + s[j]) % pow;
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
				for (int j = 0; j < 3; j++){
					int shift = (*curr * 3 + j) % pow;
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
		int pow2 = pow / 3;
		while (i < order){
			s[i++] = first / pow2;
			first %= pow2;
			pow2 /= 3;
		}

		it++;
		while (it != path.end()){
			s[i++] = *it++ % 3;
		}
	}
	
	for(int j = 0; j < i; j++){
		cout << (int) s[j];
	}
	cout << endl;
	
	free(s);
	return 0;
}
