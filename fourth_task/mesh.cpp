#include "inmost.h"
#include <iostream>

using namespace INMOST;

int main(int argc, char *argv[]){
    if (argc != 2){
        std::cout << "Usage: mesh <VTK_file>" << std::endl;
        return -1;
    }

    Mesh mesh;
    mesh.Load(argv[1]);

    double x_mozhaysk = 8.6654;
    double y_mozhaysk= 21.66;
    Tag tagNormal = mesh.CreateTag("Normal_Vector", DATA_REAL, NODE, NONE, 3);

    for (Mesh::iteratorNode inode = mesh.BeginNode(); inode != mesh.EndNode(); ++inode){
        double coords[3];
        inode->Barycenter(coords);

        double dx = coords[0] - x_mozhaysk;
        double dy = coords[1] - y_mozhaysk;

        inode->RealArray(tagNormal)[0] = -dy;
        inode->RealArray(tagNormal)[1] = dx;
        inode->RealArray(tagNormal)[2] = 0.0;
    }

    mesh.Save("../result.vtk");

    return 0;
}