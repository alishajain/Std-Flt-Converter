#include"write.h"

void write::write_header(string f_name)
{
        time_t now = time(0);
        char* dt = ctime(&now);
        out_file = f_name;
        ofstream f(out_file.c_str(), ios::out);
        f << "STAAD SPACE" << endl; 
	f << "START JOB INFORMATION" << endl;
	f << "ENGINEER DATE "<< dt << "END JOB INFORMATION" << endl;
	f << "INPUT WIDTH 79\nUNIT METER KN"<< endl;	
}

void write::store_values(char nodes_beams, float value, int i)
{
        if (nodes_beams == 'n') {
            jc[i] = value;
        } else if (nodes_beams == 'b') {
            mi[i] = value;
        }
}

void write::counter(char nodes_beams, int value)
{
        if (nodes_beams == 'n') {
            jc_count = value;
        } else if (nodes_beams == 'b') {
            mi_count = value;
        }	
}

void write::write_nodes()
{
	ofstream f(out_file.c_str(), ios::app);
	for (int j = 0; j < jc_count; j++ )
	{
	    f << j+1;
	    for (int i = j; i < j+3; i++)
	    {
		f << " " << jc[i];
	    }
	    f << "; ";
	}
	f << endl;
}

void write::write_joint_coordinates()
{
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "JOINT COORDINATES" << endl;
}

void write::write_elements()
{
        ofstream f(out_file.c_str(), ios::app);
        for (int j = 0; j < mi_count; j++ )
        {
            f << j+1;
            for (int i = j; i < j+2; i++)
            {
                f << " " << mi[i];
            }
            f << "; ";
        }
        f << endl;
}

void write::write_member_incidences()
{       
        ofstream f(out_file.c_str(), ios::app);
        f << endl << "MEMBER INCIDENCES" << endl;
}

void write::write_end()
{
        ofstream f(out_file.c_str(), ios::app);
	f << endl << "FINISH" << endl;
}

void write::write_content()
{
	write_joint_coordinates();
	write_nodes();
	write_member_incidences();
	write_elements();
	write_end();
}
