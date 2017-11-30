function [count] = Zsiros_Peter_counting_algorithm(parasites_bw)

    CC=bwconncomp(parasites_bw); % objektumok detekt�l�sa
    stats=regionprops(CC, 'all'); % objektumok tulajdons�gainak meghat�roz�sa
    count=0;
    for i=1:length(stats)
        if stats(i).Area>75 % ha a megadott m�ret f�l�tti az objektum, akkor a sz�ml�l� n�vel�se
            count=count+1;
        end
    end
end