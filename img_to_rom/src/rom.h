#ifndef ROM_C
#define ROM_C

#define MAX_ROM_SIZE 100

typedef struct{
    unsigned char r;
    unsigned char g;
    unsigned char b;
} color;

typedef struct{
    char * name;
    int width;
    int height;
    color * pixels;
} picture;

typedef struct{
    int ROMsize;
    int size;
    picture ** pictures;
} ROM;

picture* loadPicture(char* src_path);
int printROM_font(picture* fontPic, char* dest_path, int sizeX, int sizeY);
int printROM_img(ROM* rom, char * dest_path);
int addtoROM(ROM* rom, picture* picture);
ROM* createROM();
int freeROM(ROM* rom);
#endif