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
	f << "title=\"Truss sample problem\"" << endl;
}

void write::total_node_beam() {
	ofstream f(out_file.c_str(), ios::app);

	int nodes, elements;
	nodes = jc_count/3;
	elements = mi_count/2;
	f << "nodes=" << nodes << " elements=" << elements << endl;
}

void write::write_nodes() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "nodes" << endl;

	for (int j = 0, i = 1; j < jc_count; j++) {
	    if (j % 3 == 0) {
		f << i << "  x=" << jc[j];
	    } else if (j % 3 == 1) {
		f << " y=" << jc[j];
	    } else if (j % 3 == 2) {
		if (i == 1) {
		   f << " z=" << jc[j] << "  constraint=" << endl;
		} else if (i == 2) {
                   f << " z=" << jc[j] << "  constraint=" << endl;
		} else {
		   f << " z=" << jc[j] << endl;
		}
		i++;
	    }
	}
}

void write::write_beams() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "truss elements" << endl;

        for (int j = 0, i = 1; j < mi_count; j++) {
	    if (j % 2 == 0) {
		f << i << "  nodes=[" << mi[j];
	    } else if (j % 2 == 1) {
		if (i == 1) {
		   f << "," << mi[j] << "]  material=" << endl;
		} else {
		   f << "," << mi[j] << "]" << endl;
		}
		i++;
	    }
	}
}

void write::write_material() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "material properties" << endl;
	f << endl;
}

void write::write_constraints() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "constraints" << endl;
	f << endl;
	f << endl;
}

void write::write_forces() {
	ofstream f(out_file.c_str(), ios::app);
	f << "forces" << endl;
	f << "" << endl;
}
void write::write_data() {
	total_node_beam();
	write_nodes();
	write_beams();
	write_material();
	write_constraints();
}


void write::write_end_file() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "end";
}
