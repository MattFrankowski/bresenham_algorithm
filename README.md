# Rysowanie linii algorytmem Bresenhama w Assemblerze
Rysowanie linii o kącie nachylenia mniejszym niż 45 stopni algorytmem Bresenhama. W funkcji w języku C są wprowadzane koordynaty dwóch punktów a następnie sprawdzana jest możliwość wykonania programu - czy podane współrzędne mieszczą się w wymiarach obrazka. Następnie wywoływana jest funkcja w asemblerze bresenhamAlgorithm. W tej funkcji zapalany jest najpierw początkowy piksel a następnie liczone jest wyrażenie błędu i na tej podstawie podejmowane są decyzje o inkrementacji współrzędnej Y. Funkcja setPixel w asemblerze zapala kolejne piksele w bitmapie. W języku C przygotowałem pętlę, która rysuje kilkanaście linii pod różnymi nachyleniami w celu sprawdzenia poprawności działania. 

 

Aby uruchomić program należy wejść do katalogu z projektem, wpisać komendę make a następnie wpisać ./bresenha
