function limiar = acha_limiar_cinapce(img)

%acha limiar de threshold do histograma fazendo fit de uma gaussiana no
%pico de maior intensidade
%melhor usar imagem sem ajuste de contraste

histograma = imhist(img);
histograma = interpola(histograma);
S = size(histograma,1);
histograma(1) = 0;
histograma(S) = 0;

x = 1:size(histograma,1);
fitted = fit(x',histograma,'gauss2');

%plot de curva
% plot(x,histograma,'o');
% hold on;
% plot(fitted,'r');
% legend('Histograma','Gaussiana');
% hold off;

coeficientes = coeffvalues(fitted);
media1 = coeficientes(2);
desvio1 = coeficientes(3);
media2 = coeficientes(5);
desvio2 = coeficientes(6);

media1 = floor(media1);
media2 = floor(media2);

fwhm1 = 2.35*desvio1;
fwhm2 = 2.35*desvio2;

limiar = media1 + 2*fwhm1
limiar = ceil(limiar);

%verifica se as gaussianas estao mto proximas
% lim1 = media1 + ceil(2*fwhm1);
% lim2 = media2 - ceil(2*fwhm2);
% 
% if lim1 > S
%     lim1 = S;
% end
% 
% if lim2 < 1
%     lim2 = 1;
% end

% %caso estejam proximas, arranca cabeca do histograma e refaz fit
% %importante para imagens do agar
% if lim1 >= lim2
%     histograma(1:lim1) = 0;
%     fitted = fit(x',histograma,'gauss1');
%     coeficientes = coeffvalues(fitted);
%     media1 = coeficientes(2);
%     desvio1 = coeficientes(3);
%     media2 = coeficientes(5);
%     desvio2 = coeficientes(6);
%     
%     fwhm1 = 2.35*desvio1;
%     fwhm2 = 2.35*desvio2;
%     
%     %plot de curva
%     figure,plot(x,histograma,'o');
%     hold on;
%     plot(fitted,'r');
%     legend('Histograma','Gaussiana');
%     hold off;
% end

%do contrario faz processamento normal, sempre usa 2a gaussiana
% limiar = media2 - ceil(2*fwhm2);
% limiar = ceil(limiar);
% if limiar < 1
%     %limiar = media2 - ceil(fwhm2);
%     limiar = media2 - desvio2/2;
%     limiar = ceil(limiar);
% end

