#include "stdio.h"
#include "rom.h"
#include "stdlib.h"
#include "string.h"

picture* loadPicture(char* src_path){
    FILE *src = fopen(src_path, "r");
    picture *res = malloc(sizeof(picture));
    res->name = src_path;
    fscanf(src, "P6\n%d %d\n255\n", &(res->width), &(res->height));
    int size = res->height * res->width;
    color* pixels = malloc(sizeof(color[size]));
    for (int i = 0; i < size; i++){
        fscanf(src, "%c", &(pixels[i].r));
        fscanf(src, "%c", &(pixels[i].g));
        fscanf(src, "%c", &(pixels[i].b));
    }
    res->pixels = pixels;
    fclose(src);
    return res;
}

int printROM_font(picture* fontPic, char* dest_path, int sizeX, int sizeY){
    FILE* file = fopen(dest_path, "w");
    fprintf(file, "type rom_type is array (0 TO %d) of std_logic_vector (%d DOWNTO 0);\nsignal rom : rom_type := (",
                   fontPic->width * fontPic->height / (sizeX * sizeY),
                   (sizeX * sizeY - 1));
    char temp[30];
    for (int j = 0; j < fontPic->height / sizeY; j++){
        for (int i = 0; i < fontPic->width / sizeX; i++){
            fputs("\"", file);
            for (int m = 0; m < sizeY; m++){
                for (int n = 0; n < sizeX; n++){
                    int val = fontPic->width * sizeY * j + i * sizeX + n + m * fontPic->width;
                    printf("%d %d %d %d\n", val, fontPic->pixels[ val].r, fontPic->pixels[ val].g, fontPic->pixels[ val].b);
                    if (fontPic->pixels[val].r == 0 
                            && fontPic->pixels[val].g == 0
                            && fontPic->pixels[val].b == 0){
                        sprintf(temp, "1");
                    } else {
                        sprintf(temp, "0");
                    }
                fputs(temp, file);
                }
            }
            fputs("\", ", file);
        }
    }
    fputs("\"", file);
    for(int i = 0; i < sizeX * sizeY; i++){
        fputs("0", file);
    }
    fputs("\");", file);
    fclose(file);

}


int printROM_img(ROM* rom, char* dest_path){
    FILE* fvhdl = fopen(dest_path, "w");
    fprintf(fvhdl, "type rom_type is array (0 TO %d) of signed (7 DOWNTO 0);\nsignal rom : rom_type := (", rom->ROMsize);


    int line = 0;
    for (int i = 0; i < rom->size; i++)
    {
        picture* pic = rom->pictures[i];
        char temp[30];
        unsigned char val_addr = 0;
        for(int j = 0; j < pic->height * pic->width; j++){
            
            val_addr = (unsigned char)((double)pic->pixels[j].r * 7.0 / 255.0);
            val_addr = (val_addr << 3) | (unsigned char)((double)pic->pixels[j].g * 7.0 / 255.0);
            val_addr = (val_addr << 2) | (unsigned char)((double)pic->pixels[j].b * 3.0 / 255.0);
            
            sprintf(temp, "to_signed(%d, 8), ", val_addr);
            fputs(temp, fvhdl);
            line ++;
            if (line >= 8) {
                line = 0;
                fputs("\n", fvhdl);
            }
        }
    }
    fputs("to_signed(0, 8));", fvhdl);
    fclose(fvhdl);
    FILE* flog = fopen("log.txt", "w");
    fprintf(flog, "Summary of pictures stored in ROM %s :\n\n", dest_path);
    int current_addr = 0;
    char temp[100];
    for (int i = 0; i < rom->size; i++)
    {
        sprintf(temp, "--%s : from %d to %d\n", rom->pictures[i]->name, current_addr, current_addr + rom->pictures[i]->height * rom->pictures[i]->width - 1);
        fputs(temp, flog);
        current_addr += rom->pictures[i]->height * rom->pictures[i]->width;
    }
    sprintf(temp, "--end : %d\n", current_addr);
    fputs(temp, flog);
    
    fclose(flog);
}

int addtoROM(ROM* rom, picture* picture){
    rom->ROMsize += picture->height * picture->width;
    rom->pictures[rom->size] = picture;
    rom->size += 1;
    if(rom->size == MAX_ROM_SIZE) printf("Warning : too much pictures added to ROM");
}

ROM* createROM(){
    ROM* res = malloc(sizeof(ROM));
    res->pictures = malloc(sizeof(picture[MAX_ROM_SIZE]));
    res->size = 0;
    res->ROMsize = 0;
    return res;
}

int freeROM(ROM* rom){
    for (int i = 0; i < rom->size; i++)
    {   
        free(rom->pictures[i]->pixels);
        free(&(rom->pictures[i]));
    }
    free(rom);
}