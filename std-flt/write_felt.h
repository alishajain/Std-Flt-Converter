#ifndef WRITE_FELT_H
#define WRITE_FELT_H

#include <iostream>
#include <fstream>
#include <string>

using namespace std;

class write {

	string out_file;
	float jc[1024], mi[1024];
	int jc_count, mi_count;

	public:
	write();
	void store_values(char nodes_beams, float value, int i);
	void write_description(string f_name);
	void write_title();
	void total_node_beam();
	void write_nodes();
	void write_beams();
	void write_data();
	void write_material();
	void write_constraints();
	void write_forces();
	void write_end_file();
};

#endif
