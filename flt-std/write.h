#ifndef PARSER_H
#define PARSER_H

#include <iostream>
#include <string>
#include <fstream>
#include <ctime>

using namespace std;

class write
{
	string out_file;
        float jc[1024], mi[1024];
	int jc_count, mi_count;

	public:
	void write_header(string f_name);
	void counter(char nodes_beams, int value);
        void store_values(char nodes_beams, float value, int i);
	void write_joint_coordinates();
	void write_member_incidences();
	void write_nodes();
	void write_elements();
	void write_end();
	void write_content();
};
#endif
