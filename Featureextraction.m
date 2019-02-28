%all the filenames except emg in every action 
sensors = {'Drive1.csv', 'Drive2.csv', 'cook1.csv', 'cook2.csv', 'eat1.csv', 'eat2.csv', 'eatfood1.csv', 'eatfood2.csv', 'EatFood3.csv', 'eatfood4.csv', 'guiall.csv', 'key1all.csv', 'key2all.csv', 'nomov1all.csv', 'nomov2ALL.csv'}
%emg filenames in every action 
emg={'Drive1emg.csv','Drive2emg.csv', 'cook1emg.csv', 'cook2emg.csv', 'eat1emg.csv', 'eat2emg.csv', 'eatfood1emg.csv', 'eatfood2emg.csv', 'EatFood3emg.csv',  'eatfood4emg.csv', 'guiemg.csv', 'key1allemg1.csv', 'keyall2emg.csv', 'nomov1emg.csv', 'nomov2emg.csv'}

%calculation of fft,rms,mode,standard deviation.
for i=1:15
    %opening files using the sensors array
         matrix = csvread(string(sensors(i)),1);
        for j = 1:(size(matrix,2))
            timeSeries = matrix(1:end,j);
            %calculation of std, rms, mode,fft,dwt
            STD1(i,j) = std(timeSeries);
            RMS1(i,j) = rms(timeSeries);
            MODE1(i,j) = mode(timeSeries);
            FFT1(i,j) = norm(fft(timeSeries));
            DWT1(i,j) = norm(dwt(timeSeries,'sym4'));
           
           
            
        end
        
        
end
for i=1:15
    
    %opening of files using eng files
         matrix = csvread(string(emg(i)),1);
        for j = 1:(size(matrix,2))
        %opening files using the sensors array
            timeSeries = matrix(1:end,j);
            STD2(i,j) = std(timeSeries);
            RMS2(i,j) = rms(timeSeries);
            MODE2(i,j) = mode(timeSeries);
            DWT2(i,j) = norm(dwt(timeSeries,'sym4'));
            FFT2(i,j) = norm(fft(timeSeries));
           
            
            
           
        end

        
end 
%concatinating fft1 and fft2 to form whole matrix    
FFT=horzcat(FFT1,FFT2)
%FFTco=cov(FFT)
DWT=horzcat(DWT1,DWT2)
RMS=horzcat(RMS1,RMS2)
Mode=horzcat(MODE1,MODE2)
STD= horzcat(STD1,STD2)
sensors1={'acc_x','acc_y','acc_z','gyro_x','gyro_y','gyro_z','ori_x','ori_y','ori_z','ori_w','orie_x','orie_y','orie_z','emg1','emg2','emg3','emg4','emg5','emg6','emg7','emg8'}

for i=1:21
FFTall(i,:)=var(FFT(:,i))
end
fftallt=transpose(FFTall)
[z,l]=maxk(fftallt,5)
disp("according to fft")
for i=1:5
    a(i,:)=sensors1(l(i))
end

for i=1:21
DWTall(i,:)=var(DWT(:,i))
end
DWTallt=transpose(DWTall)
[z1,l1]=maxk(DWTallt,5)
disp("according to DWT")
for i=1:5
    a1(i,:)=sensors1(l1(i))
end


for i=1:21
Modeall(i,:)=var(Mode(:,i))
end
modeallt=transpose(Modeall)
[z2,l2]=maxk(modeallt,5)
disp("according to mode")
for i=1:5
    a2(i,:)=sensors1(l2(i))
end

for i=1:21
Rmsall(i,:)=var(RMS(:,i))
end

Rmsallt=transpose(Rmsall)
[z3,l3]=maxk(Rmsallt,5)
disp("according to rms")
for i=1:5
    a3(i,:)=sensors1(l3(i))
end


for i=1:21
stdall(i,:)=var(STD(:,i))
end
stdallt=transpose(stdall)
[z4,l4]=maxk(stdallt,5)
disp("according to std")
for i=1:5
    a4(i,:)=sensors1(l4(i))
end
