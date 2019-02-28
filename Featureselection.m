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

%now appending all 5 feature extraction matrices column wise and appending
%the instances of same action row wise ie made into a different file
Drive=horzcat(FFT(1:2,:),DWT(1:2,:),RMS(1:2,:),Mode(1:2,:),STD(1:2,:))
cook=horzcat(FFT(2:4,:),DWT(2:4,:),RMS(2:4,:),Mode(2:4,:),STD(2:4,:))
eat=horzcat(FFT(4:6,:),DWT(4:6,:),RMS(4:6,:),Mode(4:6,:),STD(4:6,:))
eatfood=horzcat(FFT(6:10,:),DWT(6:10,:),RMS(6:10,:),Mode(6:10,:),STD(6:10,:))
gui=horzcat(FFT(11,:),DWT(11,:),RMS(11,:),Mode(11,:),STD(11,:))
key=horzcat(FFT(11:13,:),DWT(11:13,:),RMS(11:13,:),Mode(11:13,:),STD(11:13,:))
nomov=horzcat(FFT(13:15,:),DWT(13:15,:),RMS(13:15,:),Mode(13:15,:),STD(13:15,:))

%[coeff,score,latent] = pca(cov(Drive));


%calculating eigen values which are in latent matrix
%here pca is applied on the each file 
[eigen,qw,latent]=pca(cov(Drive))
[eigen1,qw1,latent1]=pca(cov(cook))
[eigen2,qw2,latent2]=pca(cov(eat))
[eigen3,qw3,latent3]=pca(cov(eatfood))
[eigen4,qw4,latent4]=pca(cov(gui))
[eigen5,qw5,latent5]=pca(cov(key))
[eigen6,qw6,latent6]=pca(cov(nomov))
%latent matrices obtained above have eigen values of the corresponding co
%variance matrix
q=transpose(latent)
q1=transpose(latent1)
q2=transpose(latent2)
q3=transpose(latent3)
q4=transpose(latent4)
q5=transpose(latent5)
q6=transpose(latent6)
%taking the top 10 eigen values of each of the matrix obtained
[c,t]=maxk(q,10)
[c,t1]=maxk(q1,10)
[c,t2]=maxk(q2,10)
[c,t3]=maxk(q3,10)
[c,t4]=maxk(q4,10)
[c,t5]=maxk(q5,10)
[c,t6]=maxk(q6,10)
[w,v]=eig(cov(Drive))
[w1,v1]=eig(cov(cook))
[w2,v2]=eig(cov(eat))
[w3,v3]=eig(cov(eatfood))
[w4,v4]=eig(cov(gui))
[r,v]=eig(cov(gui))
[w5,v5]=eig(cov(key))
[w6,v6]=eig(cov(nomov))
%multiplying the corresponding eigen vectors of top 10 eigen value to obtain the pricipal components and storing them in an array such that each 
%row represents the principal componants
for i=1:10
    drivepc(i,:)=(mtimes(cov(Drive),w(1:end,t(i))))    
end
for i=1:10
    cookpc(i,:)=(mtimes(cov(cook),w1(1:end,t1(i))))    
end
for i=1:10
    eatpc(i,:)=(mtimes(cov(eat),w2(1:end,t2(i))))    
end
for i=1:10
    eatfoodpc(i,:)=(mtimes(cov(eatfood),w3(1:end,t3(i))))    
end
for i=1:length(t4)
    guipc(i,:)=(mtimes(cov(gui),w4(1:end,t4(i))))    
end
for i=1:10
    keypc(i,:)=(mtimes(cov(key),w5(1:end,t5(i))))    
end
for i=1:10
    nomovpc(i,:)=(mtimes(cov(nomov),w6(1:end,t6(i))))    
end







