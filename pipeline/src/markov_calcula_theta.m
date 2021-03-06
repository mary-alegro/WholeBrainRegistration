function [theta] = markov_calcula_theta(w,ordem)

%
% [THETA] = MARKOV_CALCULA_THETA(W,ORDEM)
%
% Calcula medias e variancia de uma janela w utilizando modelo de um campo
% aleatorio de markov gaussiano. Estimativa eh feita utilizando-se o
% metodos dos minimos quadraticos
%
% W : imagem que tera os parametros estimados
% ORDEM : A ordem do campo
%
% THETA : vetor com parametros de saida
%

%cordenadas do vizinhos no formato [x ... x; y ... y]

if ordem < 0 || ordem > 5
    error('Ordem deve ser um valor entre 1 e 4');
end

vizinhos.ordem(1).coords = [1 0; 0 1]; 
vizinhos.ordem(2).coords = [1 0 1 1; 0 1 1 -1];
vizinhos.ordem(3).coords = [1 0 1 1 2 0; 0 1 1 -1 0 2];
vizinhos.ordem(4).coords = [1 0 1 1 2 0 2 1 2 1; 0 1 1 -1 0 2 1 2 -1 -2];
vizinhos.ordem(5).coords = [1 0 1 1 2 0 2 1 2 1 2 2 ;0 1 1 -1 0 2 1 2 -1 -2 2 -2];

[r c N] = size(w);
    
w = double(w);
w = repmat(w,3,3); % faz tilling da janela
t2r = r+1:r*2;
t2c = c+1:c*2;
%indices = sub2ind([r c],t2r,t2c);

S = 0;
M = 0;
V = 0;

vizinhanca = vizinhos.ordem(ordem).coords;
len = size(vizinhanca,2);

q1 = zeros(len,1,'double');
q2 = zeros(len,1,'double');

%calcula medias    
for i = t2r
   for j = t2c              
        %monta q()
        for r = 1:len        
            x = vizinhanca(1,r);
            y = vizinhanca(2,r);
            q1(r) = w(i+x,j+y) + w(i-x,j-y);
        end       

        S = S+(q1*q1');
        M = M+(q1*w(i,j));            
    end
end

S=inv(S);
mu = S*M;

%calcula variancia
for i = t2r
    for j=t2c        
        %monta q()
        for r = 1:len        
            x = vizinhanca(1,r);
            y = vizinhanca(2,r);
            q2(r) = w(i+x,j+y) + w(i-x,j-y);
        end       

        V = V + (w(i,j) - mu'*q2)^2;            
    end
end

v = V/(r*c);

theta = cat(2,mu',v);
