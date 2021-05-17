function save_to_file_vhdl(array, fileID)
    fprintf(fileID, 'constant ADC_test_vector3: test_arr := (\n');
    for i = 1:length(array)
        if i ~=length(array)
            fprintf(fileID, '\tx"%s",\n', dec2hex(int16(array(i)), 4));
        else
            fprintf(fileID, '\tx"%s"\n);', dec2hex(int16(array(i)), 4));
        end
    end
end
