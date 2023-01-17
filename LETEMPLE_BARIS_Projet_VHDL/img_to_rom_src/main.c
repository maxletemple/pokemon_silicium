#include "rom.h"
#include "stdlib.h"
#include "stdio.h"
#include "string.h"

//Structure de la commande: ./a.out img "output file" img1 img2 img3 etc....
//                          ./a.out font "input file" "output file" sizeX sizeY
int main(int argc, char** argv){

    ROM* rom = createROM();
    picture* pic;
    if (!strcmp("img", argv[1])){
        for (int i = 3; i < argc; i++){
            pic = loadPicture(argv[i]);
            addtoROM(rom, pic);
        }
        printROM_img(rom, argv[2]);
    } else if (!strcmp("font", argv[1])) {
        pic = loadPicture(argv[2]);
        printROM_font(pic, argv[3], atoi(argv[4]), atoi(argv[5]));
    } else printf("Comment ça mon reuf ?");
    //freeROM(rom);
}