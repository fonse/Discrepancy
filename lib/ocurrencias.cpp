#include <iostream>
#include <fstream>
#include <vector>
#include <assert.h>
#include <stdlib.h>
#include <algorithm>
#include <iterator>
#include <map>

using namespace std;

struct by_second
{
    template <typename Pair>
    bool operator()(const Pair& a, const Pair& b)
    {
        return a.second < b.second;
    }
};


template <typename Fwd>
typename std::map<typename std::iterator_traits<Fwd>::value_type, int>::value_type
most_frequent_element(Fwd begin, Fwd end)
{
    std::map<typename std::iterator_traits<Fwd>::value_type, int> count;

    for (Fwd it = begin; it != end; ++it)
        ++count[*it];

    return *std::max_element(count.begin(), count.end(), by_second());
}

template <class T>
inline void printl (const T& coll){
    typename T::const_iterator pos;

    for (pos=coll.begin(); pos!=coll.end(); ++pos) {
        std::cout << *pos << ' ';
    }
    std::cout << std::endl;
}

int main (int argc, char **argv){
	assert(argc >= 5);
	int a = atoi(argv[1]);
	ifstream file (argv[2]);
	int n = atoi(argv[3]);
	int l = atoi(argv[4]);
	assert(file.is_open());
	
	char *s = new char[n];
	file.read(s, n);
	file.close();
	for (int i = 0; i < n; i++) s[i] -= '0';
	
	int pow = 1;
	for (int i = 0; i < l; i++) pow *= a;
	
	vector<int> occur(pow, 0);
	vector<int> maxs(n, 0);
	vector<int> mins(n, 0);
	vector<int> maxwit(n, 0);
	vector<int> minwit(n, 0);

	// Calculate all maxs
	int index = 0;
	int max = 0;
	int maxwitness = 0;
	for (int i = 0; i < n; i++){
		index = (index * a + s[i]) % pow;
		if (i < l-1){
			maxs[i] = 0;
		} else {
			int curr = ++occur[index];
			if (curr > max){
				max = curr;
				maxwitness = index;
			}
			if (curr == max && index < maxwitness){
				maxwitness = index;
			}
			
			maxs[i] = max;
			maxwit[i] = maxwitness;
		}
	}

	// Calculate all mins
	int min = maxs.back();
	int minwitness = maxwit.back();
	for (int i = 0; i < pow; i++){
		minwitness = occur[i] < min || (occur[i] == min && i < minwitness) ? i : minwitness;
		min = occur[i] < min ? occur[i] : min;
	}
	mins[n-1] = min;
	minwit[n-1] = minwitness;

	for (int i = n-l-1; i >= 0; i--){
		int curr = --occur[index];
		if (curr < min){
			min = curr;
			minwitness = index;
		}
		if (curr == min && index < minwitness){
			minwitness = index;
		}
		
		mins[i+l-1] = min;
		minwit[i+l-1] = minwitness;
		if (l == 1){
			index = s[i];
		} else {
			index = (s[i] * pow + index) / a;
		}
	}
	
	// Output
	for (int i = 0; i < n; i++){
		printf("%d\t%d\t%d\t%d\t%d\n", i+1, mins[i], maxs[i], minwit[i], maxwit[i]);
	}
	
//	cerr << most_frequent_element(maxwit.begin(), maxwit.end()).first << endl;
//	cerr << most_frequent_element(minwit.begin(), minwit.end()).first << endl;
	
	delete[] s;
	return 0;
}
