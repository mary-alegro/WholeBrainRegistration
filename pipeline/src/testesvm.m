



function [model] = testesvm()

m1 = [1.5;3.5];
m2 = [1.5;1.5];
m3 = [3.5,1.5];
m4 = [3.5,3.5];
c = [0.2 0; 0 0.2];

nSet = 1000;

amostras1 = mvnrnd(m1,c,nSet); %classe 1
amostras2 = mvnrnd(m2,c,nSet); %classe 2
amostras3 = mvnrnd(m3,c,nSet); %classe 3
amostras4 = mvnrnd(m4,c,nSet); %classe 4

plot(amostras1(:,1), amostras1(:,2),'r.');
hold on
plot(amostras2(:,1), amostras2(:,2),'b.');
plot(amostras3(:,1), amostras3(:,2),'g.');
plot(amostras4(:,1), amostras4(:,2),'k.');


treino = [amostras1; amostras2; amostras3; amostras4];
%treino = [amostras1; amostras2];

labels = ones(size(treino,1),1);
labels(1001:2000,:) = 2;
labels(2001:3000,:) = 3;
labels(3001:end,:)  = 4;

model = svmtrain(labels,treino,'-c 1 -g 2 -b 1');

t1 = mvnrnd(m1,c,200);
t2 = mvnrnd(m2,c,200);
t3 = mvnrnd(m3,c,200);
t4 = mvnrnd(m4,c,200);
teste = [t1; t2; t3; t4]; %1os 20 devem ser 1 e ultimos 20 -1
%teste = [t1; t2];
labels_teste = ones(size(teste,1),1);

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);

figure,plot(t1(:,1),t1(:,2),'r.');
hold on
plot(t2(:,1),t2(:,2),'b.');
plot(t3(:,1),t3(:,2),'g.');
plot(t4(:,1),t4(:,2),'k.');

classe1 = teste(find(classificacao==1),:);
classe2 = teste(find(classificacao==2),:);
classe3 = teste(find(classificacao==3),:);
classe4 = teste(find(classificacao==4),:);

plot(classe1(:,1),classe1(:,2),'rd');
plot(classe2(:,1),classe2(:,2),'bs');
plot(classe3(:,1),classe3(:,2),'go');
plot(classe4(:,1),classe4(:,2),'kx');

