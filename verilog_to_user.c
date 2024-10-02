#include<stdio.h>
#include<stdlib.h>


int main(){
    
    //opening file pointers 
    //decryptedmatrix.txt : txt file containing decrypted matrix output from Decrypter.v
    //decryptedmessage.txt : txt file containing decrypted message.
    FILE *fptr;
    FILE *wptr;
    fptr = fopen("./text_files/decryptedmatrix.txt", "r");
    wptr = fopen("./text_files/decryptedmessage.txt","w");

    char ch[2000];
    int c;
    
    //reads each integer in decryptedmatrix.txt and prints them as characters in decryptedmessage.txt
    fscanf(fptr,"%d",&c);
    while(!(feof(fptr)))
    {
        fprintf(wptr,"%c",c);
        fscanf(fptr,"%d",&c);
    }

    fclose(fptr);
    fclose(wptr);
    return 0;
}