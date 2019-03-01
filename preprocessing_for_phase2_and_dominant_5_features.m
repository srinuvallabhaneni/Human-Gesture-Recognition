addpath('\Data_Mining\files')
d='\Data_Mining\files' 
g='\Data_Mining\qwe'
t = {'11.csv','12.csv','13.csv','14.csv','16.csv','17.csv','18.csv','19.csv','21.csv','22.csv','23.csv','24.csv','25.csv','26.csv','27.csv','28.csv','29.csv','30.csv','31.csv','32.csv','33.csv','34.csv','36.csv','37.csv','38.csv','39.csv','40.csv','41.csv'};     
M=[];
%class labelling according to frame start and frame end
for k=1:length(t)
    fid = csvread(g+"/"+t(k));
    y=fid(1:end,1)
    z=fid(1:end,2)
    fid(1:19)=0
    for j=1:length(t)    
        c(j)=round((50*y(j))/30,0)
        e(j)=round((50*z(j))/30,0)
    disp(t(k));
    
    for l=1:length(c)
        for n=c(l):e(l)
            fid(1:19)=1
        end
    [s1,s2]=size(fid);
    for pe=1:length(t)
        for pq=1:s1
            for pf=1:s2
                qwe(pe,:,:)=fid;
            end
        end
    end
end
    
end

    
end

%pca for 30 users saparately representing 5 dominant features
for po=1:length(t)
    [eigen,q(po),latent]=pca(cov(qwe(po,:,:)));
    q(po)=transpose(latent);
    [i(po),o(po)]=maxk(q,5);
    [w(po),v(po)]=eig(cov(qwe(po,:,:)))
    for i=1:5
        data(po,i,:)=(mtimes(cov(qwe(pz,:,:)),i(1:end,o(i))))
    end
end

