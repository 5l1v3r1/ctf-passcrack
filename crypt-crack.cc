#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <unistd.h>

using namespace std;

int main(int argc,char *argv[])
{
    if(argc!=3) printf("%s [hash] [wordlist]",argv[0]);
    else
    {
        char *salt=new char[1+strlen(argv[1])];
        strcpy(salt,argv[1]);
        const size_t I=strlen(salt);
        for(size_t i=0,k=0;i<I;i++)
        {
            if(salt[i]=='$') k++;
            if(k==3)
            {
                salt[i+1]=0;
                break;
            }
        }
        FILE *file=fopen(argv[2],"r");
        if(file)
        {
            char passwd[4096];
            while(true)
            {
                fgets(passwd,4096,file);
                if(feof(file)) break;
                else
                {
                    char *hash=crypt(passwd,salt);
                    if(!strcmp(hash,argv[1]))
                    {
                        printf("%s\n",passwd);
                        break;
                    }
                }
            }
            free(salt);
            fclose(file);
        }
        else
        {
            fprintf(stderr,"%s: unable to open file \"%s\"\n",argv[0],argv[2]);
            free(salt);
            return EXIT_FAILURE;
        }
    }
    return EXIT_SUCCESS;
}
