m = csvread("\groundTruth\user36\fork\1503944237832.txt")
file1 = csvread("\MyoData\user36\fork\1503944237832_EMG.txt")
file2 = csvread("\MyoData\user36\fork\1503944237832_IMU.txt")
y=m(1:end,1)
z=m(1:end,2)
c4 = file2(:,4)
c5 = file2(:,6)
l = size(c5,1)
c1 = file1(1:l,3)
c2 = file1(1:l,6)
c3 = file1(1:l,7)
mixed = [c1,c2,c3,c4,c5]
A_zeros = [mixed zeros(size(mixed,1),1)];

for n=1:length(y)
    c(n)=round((50*y(n))/30,0)
    d(n)=round((50*z(n))/30,0)
end

for i=1:length(c)
    for n=c(i):d(i)
        A_zeros(n,6)=1
    end
end
a=A_zeros

[rows, columns] = size(A_zeros)
lastRow = int32(floor(0.4 * rows))
M = A_zeros(1:lastRow, :)
N = A_zeros(lastRow+1:end, :)
vai = N(:,1:5)
dd = vai
div = N(:,6)
predic = M(:,1:5)

tre = fitctree(vai,div)
output=predict(tre,predic)
sri = fitctree(vai,div,'MaxNumSplits',30,'CrossVal','on');
view(sri.Trained{1},'Mode','graph')
h=[];
h= findall(0,'type','figure','Name','Classification tree viewer');
destfile = strcat('\user36.fig');
saveas(h,destfile);
close(h);

svm=fitcsvm(vai,div);
outputlabelsvm=predict(svm,predic);
net=patternnet(10);
dd = dd'
div = div'
[net,tr] = train(net,dd,div);
nntraintool
TX=dd(:,tr.testInd);
TT=div(:,tr.testInd);
TY=net(TX); 
testIndices = vec2ind(TY);
plotconfusion(TT,TY);
[c,cm] = confusion(TT,TY);
plotroc(TT,TY);
EVAL = Evaluate(N(:,6),outputlabelsvm);