#include "write_felt.h"

write::write() {
	jc_count = 0;
	mi_count = 0;
}

void write::store_values(char nodes_beams, float value, int i) {
	if (nodes_beams == 'n') {
	    jc[i] = value;
	    jc_count++;
	} else if (nodes_beams == 'b') {
	    mi[i] = value;
	    mi_count++;
	}
}

void write::write_description(string f_name) {
	out_file = f_name;
	ofstream f(out_file.c_str(), ios::out);
	f << "problem description" << endl;
}

void write::write_title() {
	ofstream f(out_file.c_str(), ios::app);
	f << "title=\"Beam sample problem\"" << endl;
}

void write::total_node_beam() {
	ofstream f(out_file.c_str(), ios::app);

	int nodes, elements;
	nodes = jc_count/3;
	elements = mi_count/2;
//cout << "jc_count = " << jc_count << " nodes = " << nodes << endl;
//cout << "mi_count = " << mi_count << " elements = " << elements << endl;
	f << "nodes=" << nodes << " elements=" << elements << endl;
}

void write::write_nodes() {
//	total_node_beam();
//cout <<"	aj	" <<  mi_count << endl;
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "nodes" << endl;

	for (int j = 0, i = 1; j < jc_count; j++) {
	    if (j % 3 == 0) {
		f << i << "  x=" << jc[j];
		i++;
	    } else if (j % 3 == 1) {
		f << " y=" << jc[j];
	    } else if (j % 3 == 2) {
		f << " z=" << jc[j] << endl;
	    }
	}
}

void write::write_beams() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "beam elements" << endl;
//cout << "	" << mi_count << endl;
        for (int j = 0, i = 1; j < mi_count; j++) {
	    if (j % 2 == 0) {
		f << i << "  nodes=[" << mi[j];
		i++;
	    } else if (j % 2 == 1) {
		f << "," << mi[j] << "]" << endl;
	    }
	}
}

void write::write_data() {
	total_node_beam();
	write_nodes();
	write_beams();
}
void write::write_end_file() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "end";
}

