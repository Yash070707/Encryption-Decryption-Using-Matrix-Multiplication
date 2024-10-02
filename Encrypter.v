module Encrpter();

    integer f_ptr,w_ptr,f_ptr1;
    integer len,c,determinant;
    integer i = 0;
    integer temp = 0;
    
    //ascii_matrix has limit of encrypting upto 2000 characters. We will look for a way to declare a variable length matrix.
    reg [7:0] ascii_matrix[0:1][0:1000];
    reg [7:0] key_matrix [0:1][0:1];
    reg [14:0] encrypted_matrix[0:1][0:1000];

    initial begin
        //opening 2 files: output.txt and inputkey.txt.
        //output.txt : ascii codes of respective characters from input string.
        //inputkey.txt : a txt file containing the key matrix.
        f_ptr = $fopen("./text_files/output.txt","r");
        f_ptr1 = $fopen("./text_files/inputkey.txt","r");
        

        //scanning first line of output.txt (which contains len of input string) and stores it in variable 'len'.
        repeat(1)begin
          c=$fscanf(f_ptr,"%d",len);
        end


        // input key_matrix : which contains the secret key that only the sender and receiver knows
        for(integer i =0 ;i < 2 ; i=i+1) begin
            for(integer j =0 ; j < 2 ; j = j+1) begin
                c=$fscanf(f_ptr1,"%d",temp);
                key_matrix[i][j]=temp;          
            end
        end

        //calculating and checking if input key matrix has an inverse else, message can't be decrypted.
        determinant = key_matrix[0][0]*key_matrix[1][1]-key_matrix[0][1]*key_matrix[1][0];

        if(determinant == 0) begin
          $display("Please Choose another Key!");
        end

        else begin

            // displaying the input matrix made out of string 
            for(integer i =0 ;i < 2 ; i=i+1) begin
                for(integer j =0 ; j < len/2 ; j = j+1) begin
                    c=$fscanf(f_ptr,"%d",temp);
                    ascii_matrix[i][j]=temp;
                end
            end

            //opening enryptedmatrix.txt file , to output encrypted matrix as txt.
            w_ptr = $fopen("./text_files/encryptedmatrix.txt","w");
            $fdisplay(w_ptr,"%0d",len);
            for(integer i = 0 ; i < 2 ; i = i+1 ) begin
                for(integer k = 0 ; k < len/2; k = k+1) begin
                    encrypted_matrix[i][k] = ascii_matrix[0][k]*key_matrix[i][0] + ascii_matrix[1][k]*key_matrix[i][1];
                    $fdisplay(w_ptr,"%0d",encrypted_matrix[i][k]);
                end
            end
            $fclose(w_ptr);
        
        end
        
        //closing files
        $fclose(f_ptr);
        $fclose(f_ptr1);
        
    end
    
    
endmodule