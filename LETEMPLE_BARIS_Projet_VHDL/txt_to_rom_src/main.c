#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

FILE* startROM(char* path, int ROMlen){
    FILE* f = fopen(path, "w");
    fprintf(f, "type rom_type is array(0 to %d) of unsigned(6 downto 0); \n signal rom : rom_type := (", ROMlen);
    return f;
}

int addToROM(FILE* f, char * txt){
    int len = strlen(txt);
    char temp[100];
    for(int i = 0; i < len; i++){
        if (txt[i] <= 90 && txt[i] >= 65){
            sprintf(temp, "to_unsigned(%d, 7),", (int)(txt[i] - 65));
            fputs(temp, f);
        } else if (txt[i] <= 122 && txt[i] >= 97){
            sprintf(temp, "to_unsigned(%d, 7),", (int)(txt[i] - 97 + 26));
            fputs(temp, f);
        } else if (txt[i] <= 57 && txt[i] >= 48){
            sprintf(temp, "to_unsigned(%d, 7),", (int)(txt[i] - 48 + 2 * 26));
            fputs(temp, f);
        } else if (txt[i] == 33) fputs("to_unsigned(62, 7), ", f); // !
        else if (txt[i] == 63) fputs("to_unsigned(63, 7), ", f);     // ?
        else if (txt[i] == 46) fputs("to_unsigned(64, 7), ", f);     // .
        else if (txt[i] == 36) fputs("to_unsigned(65, 7), ", f);     // è ($)
        else if (txt[i] == 64) fputs("to_unsigned(66, 7), ", f);     // é (@)
        else if (txt[i] == 39) fputs("to_unsigned(67, 7), ", f);     // '
        else if (txt[i] == 95) fputs("to_unsigned(69, 7), ", f);     // espace (_)
    }
    fputs("\n", f);


}

int endROM(FILE* f){
    fputs("to_unsigned(0, 7));", f);
    fclose(f);
}

int main(int argc, char ** argv){
    if (argc < 2){
        printf("Mauvaise utilisation");
        exit(1);
    }

    FILE* f_log = fopen("log.txt", "w");
    char temp[100];

    int ROMlen = 1;
    int current_addr = 0;

    for (int i = 2; i < argc; i++){
        ROMlen += strlen(argv[i]);
    }
    FILE* f = startROM(argv[1], ROMlen);
    for (int i = 2; i < argc; i++){
        addToROM(f, argv[i]);
        sprintf(temp, "%d to %d : %s\n", current_addr, current_addr + strlen(argv[i]) - 1, argv[i]);
        current_addr += strlen(argv[i]);
        fputs(temp, f_log);
    }
    endROM(f);
    fclose(f_log);
}
