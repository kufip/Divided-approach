function [count] = Zsiros_Peter_counting_algorithm(parasites_bw)

    CC=bwconncomp(parasites_bw); % objektumok detektálása
    stats=regionprops(CC, 'all'); % objektumok tulajdonságainak meghatározása
    count=0;
    for i=1:length(stats)
        if stats(i).Area>75 % ha a megadott méret fölötti az objektum, akkor a számláló növelése
            count=count+1;
        end
    end
end