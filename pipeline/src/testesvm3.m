function [model] = testesvm3()

m1 = 1.5;
m2 = 3;

c = 0.2;

nSet = 1000;
y = 1:1000;

amostras1 = mvnrnd(m1,c,nSet); %classe 1
amostras2 = mvnrnd(m2,c,nSet); %classe 2

%plot(amostras1,y,'r.');
%hold on
%plot(amostras2,y,'b.');

treino = [amostras1; amostras2];

labels = ones(size(treino,1),1);
labels(1001:2000,:) = 2;

model = svmtrain(labels,treino,'-c 1 -g 2 -b 1');

t1 = mvnrnd(m1,c,200);
t2 = mvnrnd(m2,c,200);


teste = [t1; t2];
labels_teste = ones(size(teste,1),1);

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);

y2 = 1:200;

figure,plot(t1,y2,'r.');
hold on
plot(t2,y2,'b.');

classe1 = teste(find(classificacao==1),:);
classe2 = teste(find(classificacao==2),:);


plot(classe1,1:size(classe1,1),'ro');
plot(classe2,1:size(classe2,1),'bs');



