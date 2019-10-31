function preprocessa_load_files

%
% carrega os arquivos de trabalho nos diretorios certos.
% sao usadas 2 imagens de cada modalidade, para cada paciente
%

%paciente0
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000000/ST000000/SE000000');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000000/ST000000/SE000001');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000000/ST000000/SE000002');

if (location_flair(14) == location_t1c(14) && location_t1c(14) == location_t1(14)) && ...
   (location_flair(13) == location_t1c(13) && location_t1c(13) == location_t1(13)) && ...   
   (location_flair(12) == location_t1c(12) && location_t1c(12) == location_t1(12))
   
% img14 = uint16(volume_t1(:,:,14)); img13 = uint16(volume_t1(:,:,13)); img12 = uint16(volume_t1(:,:,12));
% dicomwrite(img14,'paciente0/T1_#14.dcm');dicomwrite(img13,'paciente0/T1_#13.dcm');dicomwrite(img12,'paciente0/T1_#12.dcm');
% img14 = uint16(volume_t1c(:,:,14)); img13 = uint16(volume_t1c(:,:,13)); img12 = uint16(volume_t1c(:,:,12));
% dicomwrite(img14,'paciente0/T1c_#14.dcm');dicomwrite(img13,'paciente0/T1c_#13.dcm');dicomwrite(img12,'paciente0/T1c_#12.dcm');
% img14 = uint16(volume_flair(:,:,14)); img13 = uint16(volume_flair(:,:,13)); img12 = uint16(volume_flair(:,:,12));
% dicomwrite(img14,'paciente0/FLAIR_#14.dcm');dicomwrite(img13,'paciente0/FLAIR_#13.dcm');dicomwrite(img12,'paciente0/FLAIR_#12.dcm');

end

%paciente1
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000001/ST000000/SE000000');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000001/ST000000/SE000001');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000001/ST000000/SE000002');

if (location_flair(14) == location_t1c(14) && location_t1c(14) == location_t1(14)) && ...
   (location_flair(13) == location_t1c(13) && location_t1c(13) == location_t1(13)) && ...   
   (location_flair(12) == location_t1c(12) && location_t1c(12) == location_t1(12))
   
% img14 = uint16(volume_t1(:,:,14)); img13 = uint16(volume_t1(:,:,13)); img12 = uint16(volume_t1(:,:,12));
% dicomwrite(img14,'paciente1/T1_#14.dcm');dicomwrite(img13,'paciente1/T1_#13.dcm');dicomwrite(img12,'paciente1/T1_#12.dcm');
% img14 = uint16(volume_t1c(:,:,14)); img13 = uint16(volume_t1c(:,:,13)); img12 = uint16(volume_t1c(:,:,12));
% dicomwrite(img14,'paciente1/T1c_#14.dcm');dicomwrite(img13,'paciente1/T1c_#13.dcm');dicomwrite(img12,'paciente1/T1c_#12.dcm');
% img14 = uint16(volume_flair(:,:,14)); img13 = uint16(volume_flair(:,:,13)); img12 = uint16(volume_flair(:,:,12));
% dicomwrite(img14,'paciente1/FLAIR_#14.dcm');dicomwrite(img13,'paciente1/FLAIR_#13.dcm');dicomwrite(img12,'paciente1/FLAIR_#12.dcm');

end

%paciente2
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000002/ST000000/SE000000');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000002/ST000000/SE000001');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000002/ST000000/SE000002');

if (location_flair(6) == location_t1c(6) && location_t1c(6) == location_t1(6)) && ...
   (location_flair(4) == location_t1c(4) && location_t1c(4) == location_t1(4)) && ...   
   (location_flair(5) == location_t1c(5) && location_t1c(5) == location_t1(5))
   
% img14 = uint16(volume_t1(:,:,4)); img13 = uint16(volume_t1(:,:,6)); img12 = uint16(volume_t1(:,:,5));
% dicomwrite(img14,'paciente2/T1_#4.dcm');dicomwrite(img13,'paciente2/T1_#6.dcm');dicomwrite(img12,'paciente2/T1_#5.dcm');
% img14 = uint16(volume_t1c(:,:,4)); img13 = uint16(volume_t1c(:,:,6)); img12 = uint16(volume_t1c(:,:,5));
% dicomwrite(img14,'paciente2/T1c_#4.dcm');dicomwrite(img13,'paciente2/T1c_#6.dcm');dicomwrite(img12,'paciente2/T1c_#5.dcm');
% img14 = uint16(volume_flair(:,:,4)); img13 = uint16(volume_flair(:,:,6)); img12 = uint16(volume_flair(:,:,5));
% dicomwrite(img14,'paciente2/FLAIR_#4.dcm');dicomwrite(img13,'paciente2/FLAIR_#6.dcm');dicomwrite(img12,'paciente2/FLAIR_#5.dcm');

end

%paciente5
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000005/ST000000/SE000000');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000005/ST000000/SE000001');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000005/ST000000/SE000002');

if (location_flair(14) == location_t1c(14) && location_t1c(14) == location_t1(14)) && ...
   (location_flair(13) == location_t1c(13) && location_t1c(13) == location_t1(13)) && ...   
   (location_flair(12) == location_t1c(12) && location_t1c(12) == location_t1(12))
   
% img14 = uint16(volume_t1(:,:,14)); img13 = uint16(volume_t1(:,:,13)); img12 = uint16(volume_t1(:,:,12));
% dicomwrite(img14,'paciente5/T1_#14.dcm');dicomwrite(img13,'paciente5/T1_#13.dcm');dicomwrite(img12,'paciente5/T1_#12.dcm');
% img14 = uint16(volume_t1c(:,:,14)); img13 = uint16(volume_t1c(:,:,13)); img12 = uint16(volume_t1c(:,:,12));
% dicomwrite(img14,'paciente5/T1c_#14.dcm');dicomwrite(img13,'paciente5/T1c_#13.dcm');dicomwrite(img12,'paciente5/T1c_#12.dcm');
% img14 = uint16(volume_flair(:,:,14)); img13 = uint16(volume_flair(:,:,13)); img12 = uint16(volume_flair(:,:,12));
% dicomwrite(img14,'paciente5/FLAIR_#14.dcm');dicomwrite(img13,'paciente5/FLAIR_#13.dcm');dicomwrite(img12,'paciente5/FLAIR_#12.dcm');

end

%paciente6
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000006/ST000000/SE000000');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000006/ST000000/SE000001');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000006/ST000000/SE000002');

if (location_flair(14) == location_t1c(14) && location_t1c(14) == location_t1(14)) && ...
   (location_flair(13) == location_t1c(13) && location_t1c(13) == location_t1(13)) && ...   
   (location_flair(12) == location_t1c(12) && location_t1c(12) == location_t1(12))
   
% img14 = uint16(volume_t1(:,:,14)); img13 = uint16(volume_t1(:,:,13)); img12 = uint16(volume_t1(:,:,12));
% dicomwrite(img14,'paciente6/T1_#14.dcm');dicomwrite(img13,'paciente6/T1_#13.dcm');dicomwrite(img12,'paciente6/T1_#12.dcm');
% img14 = uint16(volume_t1c(:,:,14)); img13 = uint16(volume_t1c(:,:,13)); img12 = uint16(volume_t1c(:,:,12));
% dicomwrite(img14,'paciente6/T1c_#14.dcm');dicomwrite(img13,'paciente6/T1c_#13.dcm');dicomwrite(img12,'paciente6/T1c_#12.dcm');
% img14 = uint16(volume_flair(:,:,14)); img13 = uint16(volume_flair(:,:,13)); img12 = uint16(volume_flair(:,:,12));
% dicomwrite(img14,'paciente6/FLAIR_#14.dcm');dicomwrite(img13,'paciente6/FLAIR_#13.dcm');dicomwrite(img12,'paciente6/FLAIR_#12.dcm');

end

%paciente7
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000007/ST000000/SE000000');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000007/ST000000/SE000001');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000007/ST000000/SE000002');

if (location_flair(14) == location_t1c(14) && location_t1c(14) == location_t1(14)) && ...
   (location_flair(13) == location_t1c(13) && location_t1c(13) == location_t1(13)) && ...   
   (location_flair(12) == location_t1c(12) && location_t1c(12) == location_t1(12))
   
% img14 = uint16(volume_t1(:,:,14)); img13 = uint16(volume_t1(:,:,13)); img12 = uint16(volume_t1(:,:,12));
% dicomwrite(img14,'paciente7/T1_#14.dcm');dicomwrite(img13,'paciente7/T1_#13.dcm');dicomwrite(img12,'paciente7/T1_#12.dcm');
% img14 = uint16(volume_t1c(:,:,14)); img13 = uint16(volume_t1c(:,:,13)); img12 = uint16(volume_t1c(:,:,12));
% dicomwrite(img14,'paciente7/T1c_#14.dcm');dicomwrite(img13,'paciente7/T1c_#13.dcm');dicomwrite(img12,'paciente7/T1c_#12.dcm');
% img14 = uint16(volume_flair(:,:,14)); img13 = uint16(volume_flair(:,:,13)); img12 = uint16(volume_flair(:,:,12));
% dicomwrite(img14,'paciente7/FLAIR_#14.dcm');dicomwrite(img13,'paciente7/FLAIR_#13.dcm');dicomwrite(img12,'paciente7/FLAIR_#12.dcm');

end

%paciente8
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000008/ST000000/SE000000');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000008/ST000000/SE000001');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000008/ST000000/SE000002');

if (location_flair(14) == location_t1c(14) && location_t1c(14) == location_t1(14)) && ...
   (location_flair(13) == location_t1c(13) && location_t1c(13) == location_t1(13)) && ...   
   (location_flair(12) == location_t1c(12) && location_t1c(12) == location_t1(12))
   
% img14 = uint16(volume_t1(:,:,14)); img13 = uint16(volume_t1(:,:,13)); img12 = uint16(volume_t1(:,:,12));
% dicomwrite(img14,'paciente8/T1_#14.dcm');dicomwrite(img13,'paciente8/T1_#13.dcm');dicomwrite(img12,'paciente8/T1_#12.dcm');
% img14 = uint16(volume_t1c(:,:,14)); img13 = uint16(volume_t1c(:,:,13)); img12 = uint16(volume_t1c(:,:,12));
% dicomwrite(img14,'paciente8/T1c_#14.dcm');dicomwrite(img13,'paciente8/T1c_#13.dcm');dicomwrite(img12,'paciente8/T1c_#12.dcm');
% img14 = uint16(volume_flair(:,:,14)); img13 = uint16(volume_flair(:,:,13)); img12 = uint16(volume_flair(:,:,12));
% dicomwrite(img14,'paciente8/FLAIR_#14.dcm');dicomwrite(img13,'paciente8/FLAIR_#13.dcm');dicomwrite(img12,'paciente8/FLAIR_#12.dcm');

end

%paciente9
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000009/ST000000/SE000000');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000009/ST000000/SE000001');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000009/ST000000/SE000002');

if (location_flair(14) == location_t1c(14) && location_t1c(14) == location_t1(14)) && ...
   (location_flair(13) == location_t1c(13) && location_t1c(13) == location_t1(13)) && ...   
   (location_flair(12) == location_t1c(12) && location_t1c(12) == location_t1(12))
   
% img14 = uint16(volume_t1(:,:,14)); img13 = uint16(volume_t1(:,:,13)); img12 = uint16(volume_t1(:,:,12));
% dicomwrite(img14,'paciente9/T1_#14.dcm');dicomwrite(img13,'paciente9/T1_#13.dcm');dicomwrite(img12,'paciente9/T1_#12.dcm');
% img14 = uint16(volume_t1c(:,:,14)); img13 = uint16(volume_t1c(:,:,13)); img12 = uint16(volume_t1c(:,:,12));
% dicomwrite(img14,'paciente9/T1c_#14.dcm');dicomwrite(img13,'paciente9/T1c_#13.dcm');dicomwrite(img12,'paciente9/T1c_#12.dcm');
% img14 = uint16(volume_flair(:,:,14)); img13 = uint16(volume_flair(:,:,13)); img12 = uint16(volume_flair(:,:,12));
% dicomwrite(img14,'paciente9/FLAIR_#14.dcm');dicomwrite(img13,'paciente9/FLAIR_#13.dcm');dicomwrite(img12,'paciente9/FLAIR_#12.dcm');

end

%paciente10
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000010/ST000000/SE000000');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000010/ST000000/SE000001');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000010/ST000000/SE000002');

if (location_flair(11) == location_t1c(11) && location_t1c(11) == location_t1(11)) && ...
   (location_flair(13) == location_t1c(13) && location_t1c(13) == location_t1(13)) && ...   
   (location_flair(12) == location_t1c(12) && location_t1c(12) == location_t1(12))
   
% img14 = uint16(volume_t1(:,:,11)); img13 = uint16(volume_t1(:,:,13)); img12 = uint16(volume_t1(:,:,12));
% dicomwrite(img14,'paciente10/T1_#11.dcm');dicomwrite(img13,'paciente10/T1_#13.dcm');dicomwrite(img12,'paciente10/T1_#12.dcm');
% img14 = uint16(volume_t1c(:,:,11)); img13 = uint16(volume_t1c(:,:,13)); img12 = uint16(volume_t1c(:,:,12));
% dicomwrite(img14,'paciente10/T1c_#11.dcm');dicomwrite(img13,'paciente10/T1c_#13.dcm');dicomwrite(img12,'paciente10/T1c_#12.dcm');
% img14 = uint16(volume_flair(:,:,11)); img13 = uint16(volume_flair(:,:,13)); img12 = uint16(volume_flair(:,:,12));
% dicomwrite(img14,'paciente10/FLAIR_#11.dcm');dicomwrite(img13,'paciente10/FLAIR_#13.dcm');dicomwrite(img12,'paciente10/FLAIR_#12.dcm');

end



%paciente3
[volume_flair,location_flair] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000003/ST000000/SE000001');
[volume_t1,location_t1] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000003/ST000000/SE000000');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/nex/LSI/Mestrado/imagens/CD-HC/PA000003/ST000000/SE000002');

if (location_flair(11) == location_t1c(11) && location_t1c(11) == location_t1(11)) && ...
   (location_flair(12) == location_t1c(12) && location_t1c(12) == location_t1(12)) && ...   
   (location_flair(13) == location_t1c(13) && location_t1c(13) == location_t1(13))
   
% img14 = uint16(volume_t1(:,:,13)); img13 = uint16(volume_t1(:,:,12)); img12 = uint16(volume_t1(:,:,11));
% dicomwrite(img14,'paciente3/T1_#13.dcm');dicomwrite(img13,'paciente3/T1_#12.dcm');dicomwrite(img12,'paciente3/T1_#11.dcm');
% img14 = uint16(volume_t1c(:,:,13)); img13 = uint16(volume_t1c(:,:,12)); img12 = uint16(volume_t1c(:,:,11));
% dicomwrite(img14,'paciente3/T1c_#13.dcm');dicomwrite(img13,'paciente3/T1c_#12.dcm');dicomwrite(img12,'paciente3/T1c_#11.dcm');
% img14 = uint16(volume_flair(:,:,13)); img13 = uint16(volume_flair(:,:,12)); img12 = uint16(volume_flair(:,:,11));
% dicomwrite(img14,'paciente3/FLAIR_#13.dcm');dicomwrite(img13,'paciente3/FLAIR_#12.dcm');dicomwrite(img12,'paciente3/FLAIR_#11.dcm');

end


%paciente4
[volume_flair,location_flair] = carrega_volume_dicom('/home/maryana/LSI/Mestrado/imagens/CD-HC/DICOM/PA000004/ST000000/SE000001');
[volume_t1,location_t1] = carrega_volume_dicom('/home/maryana/LSI/Mestrado/imagens/CD-HC/DICOM/PA000004/ST000000/SE000002');
[volume_t1c,location_t1c] = carrega_volume_dicom('/home/maryana/LSI/Mestrado/imagens/CD-HC/DICOM/PA000004/ST000000/SE000003');

if (location_flair(14) == location_t1c(14) && location_t1c(14) == location_t1(14)) && ...
   (location_flair(16) == location_t1c(16) && location_t1c(16) == location_t1(16)) && ...   
   (location_flair(15) == location_t1c(15) && location_t1c(15) == location_t1(15))
   
% img14 = uint16(volume_t1(:,:,14)); img13 = uint16(volume_t1(:,:,16)); img12 = uint16(volume_t1(:,:,15));
% dicomwrite(img14,'paciente4/T1_#14.dcm');dicomwrite(img13,'paciente4/T1_#16.dcm');dicomwrite(img12,'paciente4/T1_#15.dcm');
% img14 = uint16(volume_t1c(:,:,14)); img13 = uint16(volume_t1c(:,:,16)); img12 = uint16(volume_t1c(:,:,15));
% dicomwrite(img14,'paciente4/T1c_#14.dcm');dicomwrite(img13,'paciente4/T1c_#16.dcm');dicomwrite(img12,'paciente4/T1c_#15.dcm');
% img14 = uint16(volume_flair(:,:,14)); img13 = uint16(volume_flair(:,:,16)); img12 = uint16(volume_flair(:,:,15));
% dicomwrite(img14,'paciente4/FLAIR_#14.dcm');dicomwrite(img13,'paciente4/FLAIR_#16.dcm');dicomwrite(img12,'paciente4/FLAIR_#15.dcm');

end
