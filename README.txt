-NEAREST-NEIGHBOUR INTERPOLATION
	->Pentru functia nn_2x2 am calculat distantele dintre punctul (x_int(i),y_int(j)) fata de punctele (x1,y1), (x1,y2), (x2,y1), (x2,y2).
	->Dupa calculul celor 4 distante o selectam pe cea minima si verificam pentru ce punct am obtinut-o si in functie de valoare acelui punct in functia noastra ofeream functiei valoarea respectiva in punctul(x_int(i),y_int(j)).
	->De asemenea am mai realizat urmatoarele cazuri:cazul in care ne aflam cu j-ul fix pe coloana din mijloc practic "umpleam coloana cu valorile din dreapta", si alte 2 subcazuri in functie de valoarea lui i.
	->Pentru functia de resize doar am urmarit fiecare TODO in parte:
		*am calculat factorii de scalare.
		*matricea de transformare si inversa acesteia dupa formulele oferite in PDF-ul temei.
		*aflam x_p si y_p aplicand transformarea inversa vectorului [x; y].
		*ii deplasam in sistemul de coordonate de la 1 la n.
		*ii calculam cel mai apropiat vecin cu ajutorul functiei round.
		*valoarea pixelului din matricea finala este data de valoare pixelului din imaginea initiala in functie de cel mai apropiat vecin calculat anterior.
	->Pentru ambele functii RGB doar am extras cele 3 matrici, reprezentand cele 3 canale ale imaginii(R, G, B) si am aplicat interpolarea/resize-ul pe fiecare dintre ele.
	->La sfarsit am folosit functia cat pentru a alipi cele 3 matrici intr-o imagine finala.
-BILINEAR INTERPOLATION
	->Pentru functia bilinear_coef doar am aplicat regulile prezentate in PDF.
	->Practic am rezolvat sistemul cu cele 4 necunoscute (coeficientii de interpolare), cu mentiunea ca inainte de a rezolva sistemul am facut un cast vectorului b la double.
	->Pentru functia bilinear_2x2 am aplicat functia anterior prezentata pentru a obtine coeficientii de interpolare.
	->Am calculat valoare pixelului din imaginea finala in functie de coeficientii obtinuti cu ajutorul careia puteam obtine o forma a functiei(cum ne-a fost prezentata in PDF).
	->De fiecare data calculam valoarea functiei in punctul x_int(j) si y_int(i).
	->Am definit functia de surrounding_points in care x1=floor(x), x2=x1+1(floor(x)+1), analog pentru y1 si y2.
	->In plus verificam cazurile daca y1 a fost aproximat ca fiind pe ultima linie:aici pur si simplu decrementam valoarea lui y1 si y2 lua valoarea lui m(ultima linie)
	->La fel si pentru x doar ca aplicat pentru ultima linie.
	->Am parcurs cam aceeasi pasi ca la resize-ul de la nearest-neighbour doar ca de aceasta data se schimba metoda de calculare a valorii pixelului.
	->De aceasta data ne foloseam de functia surrounding_points pentru a determina punctele ce inconjoara x_p si y_p.
	->Determinam coeficientii de interpolare si calculam valoarea functiei in punctul x_p si y_p (asemanator cu bilinear_2x2).
	->Pentru functia bilinear_rotate m-am folosit de formulele prezentate in PDF si am urmarit urmatorii pasi:
		*am calculat sin si cos de rotation_angle.
		*am calculat matricea de rotatie si inversa acesteia.
		*aplicam matricea de transformare inversa pe vectorul [x; y] pentru a afla x_p si y_p.
		*aduceam x_p si y_p in sistemul de coordonate de la 1 la n.
		*verificam daca acest (x_p, y_p) se afla in afara matricei si in acest caz dadeam pixelului valoarea 0.
		*in cazul in care se afla in matrice calculam valoarea pixelului la fel ca la bilinear_resize.
	->Pentru functiile de RGB am facut acelasi lucru ca la nearest-neighbour doar ca a diferit functia pe care o apelam.
-BICUBIC INTERPOLATION
	->Pentru functia bicubic_coef defineam matricile ca in formulele prezentate.
	->Pe cea din stanga si din dreapta le defineam identic ca in PDF.
	->Pe cea din mijloc asemanator ca in PDF doar ca in loc de 0 si 1 puneam valorile lui x1, y1, x2, y2.
	->Acest punct necesita putina atentie deoarece in PDF formulele ne erau prezentate in ordinea x, y si implementarea necesita implementarea y, x.
	->Pentru functiile fx, fy, fxy m-am folosit de formulele prezentate in PDF(Aproximarea derivatelor cand acestea nu sunt cunoscute).
	->La fel, trebuia sa fim atenti sa interschimbam pozitia lui y cu cea a lui x.
		*mai exact: in loc sa avem f(x+1, y)(varianta din PDF) vom avea f(y, x+1)(varianta din implementare).
	->Verificam si cazurile pentru care y=1 sau x=1(marginile imaginii) acolo unde aproximam derivata cu 0.
	->In functie precalc_d am creat matricile Ix, Iy si Ixy folosindu-ma de 2 iteratii for.
		*In principiu ne foloseam de functiile fx, fy si respectiv fxy pentru a calcula valoarea derivatei pe acea pozitie.
		*Verificam in plus cazul in care x-ul sa afla pe ultima coloana(la marginea imaginii) si ofeream aproximarea 0 derivatei, y-ul pe ultima linie(pentru matricea Iy) si x pe ultima coloana sau y pe ultima linie(pentru matricea Ixy).
	->Defineam aceeasi functie surrounding_points ca la interpolarea biliniara.
	->Pentru functia de resize urmaream aceeasi pasi ca la cea facuta la interpolarea biliniara.
	->Diferenta consta in modul in care calculam valoarea pixelului din matricea finala:
		*determinam in primul rand matricele cu aproximatiile derivatelor(Ix, Iy, Ixy).
		*calculam punctele ce inconjoara x_p si y_p.
		*calculam coeficientii de interpolare cu ajutorul functiei bicubic_coef si ii introduceam intr-o matrice.
		*ne foloseam de formulele din PDF pentru a calcula valoarea pixelului din matricea finala.
		*defineam cei doi vectori, cel linie pentru x_p si cel coloana pentru y_p.
		*in final realizam inmultirea dintre vectorul linie, matricea de coeficienti si vectorul coloana pentru a obtine valoarea pixelului.
