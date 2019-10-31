function em = energia_media(filtrado)

%
%calcula energia media para uma imagem filtrada por Filtros de Gabor
%

    [r c N] = size(filtrado);
    a = abs(filtrado);
    a = a.^2;
    em = sum(sum(a))/(r*c);