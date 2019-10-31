function [model] = testesvm2()

% teste problema não linearmente separavel

m1 = [1.5;1.5];
m2 = [1.5;-0.5];
m3 = [1.5;4];
m4 = [-0.5;1.5];
m5 = [3.5;1.5];

c = [0.2 0; 0 0.2];

nSet = 1000;

amostras1 = mvnrnd(m1,c,nSet); %classe 1
amostras2 = mvnrnd(m2,c,nSet);
amostras3 = mvnrnd(m3,c,nSet);
amostras4 = mvnrnd(m4,c,nSet);
amostras5 = mvnrnd(m5,c,nSet);

%plot(amostras1(:,1), amostras1(:,2),'r.');
%hold on
%plot(amostras2(:,1), amostras2(:,2),'b.');
%plot(amostras3(:,1), amostras3(:,2),'b.');
%plot(amostras4(:,1), amostras4(:,2),'b.');
%plot(amostras5(:,1), amostras5(:,2),'b.');

treino = [amostras1; amostras2; amostras3; amostras4; amostras5];
labels = ones(size(treino,1),1);
labels(1:1000,:) = -1;

model = svmtrain(labels,treino,'-c 1 -g 2 -b 1');

t1 = mvnrnd(m1,c,200);
t2 = mvnrnd(m2,c,200);
t3 = mvnrnd(m3,c,200);
t4 = mvnrnd(m4,c,200);
t5 = mvnrnd(m5,c,200);

teste = [t1; t2; t3; t4; t5];

labels_teste = ones(size(teste,1),1);

[classificacao, precisao, probabilidades] = svmpredict(labels_teste, teste, model);

figure,plot(t1(:,1),t1(:,2),'r.');
hold on
plot(t2(:,1),t2(:,2),'b.');
plot(t3(:,1),t3(:,2),'b.');
plot(t4(:,1),t4(:,2),'b.');
plot(t5(:,1),t5(:,2),'b.');

classe1 = teste(find(classificacao==-1),:);
classe2 = teste(find(classificacao==1),:);


plot(classe1(:,1),classe1(:,2),'rd');
plot(classe2(:,1),classe2(:,2),'bs');










