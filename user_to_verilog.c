#include<stdio.h>
#include<stdlib.h>


int main(){
    //opening file pointers
    //output.txt : outputs length of string and ascii codes of corresponding characters.
    //inputstring.txt :  a txt file which contains the message to be
    FILE *fptr;
    FILE *wptr;
    wptr = fopen("./text_files/output.txt","w");
    fptr = fopen("./text_files/inputstring.txt", "r");

    //storing the string in character array 'ch' ; word limit of the message to be transmitted is 2000 characters.
    char ch[2000];
    char c;
    int counter=0;
    
    
    while ((c = fgetc(fptr)) != EOF)
    {
        ch[counter] = c;
        counter++;
    }

    //to convert the characters of 'ch' into a (2 x length/2) matrix, we need to check if number of characters is odd or even.
    //if it's odd , length = length +1 and append a 'space' character at the end of the string.
    if(counter%2!=0){
        ch[counter]=' ';
        counter++;
    }
    fprintf(wptr,"%d\n",counter);

    //printing corresponing ascii codes in a txt file i.e. output.txt
    for(int i=0; i < counter ; i++){
        fprintf(wptr,"%d\n",ch[i]);
    }
    
    //closing file pointers
    fclose(fptr);
    fclose(wptr);

    return 0;
}