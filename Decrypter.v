module Decrypter();
    //defining file pointers
    integer f_ptr,f_ptr1,c,w_ptr;
    integer i=0;
    integer len = 0;

    //temporary variable to store integer while scanning file.
    integer temp; 
    integer determinant;

    //input matrix i.e. encrypted_matrix
    reg [14:0] encrypted_matrix[0:1][0:1000];

    //output matrix i.e. decrypted_matrix
    reg signed [24:0] decrypted_matrix [0:1][0:1000];

    //stores inverse of password matrix, that user inputs in password.txt
    reg signed [7:0] inverse[0:1][0:1];

    initial begin
    
        //encryptedmatrix.txt: txt file containing encrypted matrix outputted from Encrypter.v
        //password.txt : txt file containing expected key matrix, if this is same as key matrix, then the decrypted matrix will make sense.
        f_ptr = $fopen("./text_files/encryptedmatrix.txt","r");
        f_ptr1 = $fopen("./text_files/password.txt","r");

        //scanning length that is present in first line of encryptedmatrix.txt
        repeat(1) begin
          c=$fscanf(f_ptr,"%d",len);
        end


        //storing integer from encryptedmatrix.txt into a 2D reg array encrypted_matrix
        for(integer i =0 ;i < 2 ; i=i+1) begin
            for(integer j =0 ; j < len/2 ; j = j+1) begin
                c=$fscanf(f_ptr,"%d",temp);
                encrypted_matrix[i][j]=temp;
                //$display("encrypted_matrix[%0d][%0d] = %d", i, j, encrypted_matrix[i][j]);
            end
        end
        

        //storing inverse in inverse matrix, calculated while we scan password.txt
        for(integer i =0 ;i < 2 ; i=i+1) begin
            for(integer j =0 ; j < 2 ; j = j+1) begin
                c=$fscanf(f_ptr1,"%d",temp);
                if(i==j)begin
                    inverse[1-i][1-j] = temp;  // for (-1)pwr(i+j)
                end
                else begin
                    inverse[i][j] = temp;
                end
            end
        end

            // determinant
            determinant = inverse[0][0]*inverse[1][1] - inverse[0][1]*inverse[1][0];
            if(determinant<0)begin
                determinant = -determinant;
            end
            if (determinant==0) begin
                determinant = 20001;
            end

            
            w_ptr = $fopen("./text_files/decryptedmatrix.txt","w");

            for (integer j = 0; j < len/2 ; j = j + 1 )begin
                temp = inverse[0][0]*encrypted_matrix[0][j] - inverse[0][1]*encrypted_matrix[1][j];
                if(temp<0)begin
                temp = -temp;   
            end
            
            decrypted_matrix[0][j] = temp/determinant;

            temp = inverse[1][1]*encrypted_matrix[1][j] - inverse[1][0]*encrypted_matrix[0][j];

            if(temp<0)begin
                temp = -temp;   
            end

            decrypted_matrix[1][j] = temp/determinant;
        end

            for (integer h = 0; h < 2 ; h= h+1 ) begin
                for (integer j = 0; j < len/2  ; j = j+1) begin
                    $fdisplay(w_ptr,"%0d",decrypted_matrix[h][j]);
                end
            end
    end
endmodule
