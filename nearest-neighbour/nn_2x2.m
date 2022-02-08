function out = nn_2x2(f, STEP = 0.1)
    % =========================================================================
    % Aplica interpolare nearest-neighbour pe imaginea 2x2 f cu puncte
    % intermediare echidistante.
    % f are valori cunoscute in punctele (1, 1), (1, 2), (2, 1) si (2, 2).
    % 
    % Parametrii:
    % - f = imaginea ce se doreste sa fie interpolata
    % - STEP = distanta dintre doua puncte succesive
    % =========================================================================
    
    % TODO: defineste coordonatele x si y ale punctelor intermediare
    x_int = 1 : STEP : 2;
    y_int = 1 : STEP : 2;

    % afla nr. de puncte
    n = length(x_int);

    % cele 4 punctele incadratoare vor fi aceleasi pentru toate punctele din
    % interior
    x1 = y1 = 1;
    x2 = y2 = 2;
    % TODO: initializeaza rezultatul cu o matrice n x n plina de zero
    out=zeros(n,n);
    % parcurge fiecare pixel din imaginea finala
    pxl=0;
    for i = 1 : n
        for j = 1 : n
            % TODO: afla cel mai apropiat pixel din imaginea initiala
            d(1)=sqrt((x_int(i)-x1)^2 + (y_int(j)-y1)^2);
            d(2)=sqrt((x_int(i)-x1)^2 + (y_int(j)-y2)^2);
            d(3)=sqrt((x_int(i)-x2)^2 + (y_int(j)-y1)^2);
            d(4)=sqrt((x_int(i)-x2)^2 + (y_int(j)-y2)^2);
            dist_minima=min(d);
            if (j!=ceil(n/2))
              if (dist_minima==d(3))
                pxl=f(y2,x1);
              elseif (dist_minima==d(4))
                pxl=f(y2,x2);
              elseif (dist_minima==d(1))
                pxl=f(y1,x1);
              elseif (dist_minima==d(2))
                pxl=f(y1,x2);
              endif
            elseif (j==ceil(n/2)) 
              if (i<ceil(n/2))
                pxl=f(y1,x2);
              elseif (i>=(n/2))
                pxl=f(y2,x2);
              endif
            endif
            % TODO: calculeaza pixelul din imaginea finala
            out(i,j)=pxl;
        endfor
    endfor
endfunction
