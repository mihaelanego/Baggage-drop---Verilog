Negoita Mihaela
331AA

1. modulul sensors_input

Modulul sensors_input primeste ca input 4 bytes reprezentand 4 sensori si, in functie de disponibiltatea lor, calculeaza media aritmetica a acestora si formeaza inaltimea(outputul). Senzorii sunt impatiti in grupuri de cate 2. Plecand de la ipoteza ca nu pot fi simultan 2 senzori din perechi diferite egali cu 0, verificam pe rand daca in fiecare grupare se afla vreun senzor null, daca afirmatia este adevarata atunci inaltimea va fi suma senzorilor din cealalta pereche shiftata 1 bit la dreapta. 

In cazul in care nu exista niciun senzor null, vom face urmatoarea verificare in functie de paritatea sumelor celor 2 perechi de senzori: daca ambele sume sunt impare atunci inaltimea va fi egala cu suma dintre media aritmetica a fiecarei perechi plus 2 totul shiftat 1 bit la dreapta. Adaugam acest 2 pentru pentru a putea face aproximarea in sus si pentru a acoperii cazurile in care rezultatul este x.5 (ex: rezulat matematic = 155.5 -> calculatorul va aproxima la 155 insa rezultatul corect este 156).
In cazul in care cele doua sume nu sunt impare, functie de paritatea sumelor celor 2 perechi de senzori: daca ambele sume sunt impare atunci inaltimea va fi egala cu suma dintre media aritmetica a fiecarei perechi plus 1 totul shiftat 1 bit la dreapta. Adaugam 1 la finalul sumei pentru a face aproximarea in sus.

2. modulul square_root

Modulul square_root este responsabil de calcularea radacinii patrate a unui numar. Input-ul este constituit dintr-un singur byte reprezentatnd un numar intreg de la 0 la 255. Output-ul este format din 2 bytes reprezentand radacina patrata a numarului ca un numar fixed point (primul byte este partea intreaga, al doilea este partea zecimala).

Pentru calcularea radacinii patrate exista mai multe mecanisme insa toate sunt complexe. Tinand cont ca sunt doar 256 de numere care pot fi folosite ca input, am decis sa implementez un Map intre fiecare input si output-ul pe care trebuie sa il aiba. Desi acest map poate fi scris manual, am decis sa automatizez intreg procesul printr-un script care genereaza codul verilog-ul pentru acest modul.

Script-ul este scris in JavaScript si este gandit sa ruleze in runtime-ul de Node.js.

Pentru prima implementare am folosit metoda Math.sqrt din JavaScript pentru a calcula radacina patrata a fiecarui numar intre 0 si 255. Apoi am calculat partea intreaga si partea zecimala si le-am salvat in codul generat in mod corespunzator (ca un numar 16 bit fixed point cu primul byte partea intreaga si al doilea partea zecimala).

Aceasta implementare a avut totusi cateva probleme de rotunjire (checker-ul se astepta la unele numere sa fie rotunjite in sus iar altele in jos). Am decis sa refac implementarea si sa folosesc output-ul checker-ului pentru testele care nu treceau. Am scris un modul de verilog care sa pice toate testele. Am salvat output-ul intr-un fisier text si am rescris script-ul pentru generarea codului verilog sa parseze fiecare linie din acest fisier folosind un RegEx si sa extraga valoarile expected pentru fiecare input. Am folosit apoi datele extrase pentru a genera codul verilog. Am adaugat totusi un comentariu pentru fiecare linie in care am pus si valoarea calculata folosind Math.sqrt pentru a vedea diferentele intre checker si valoarea calculata de script.

Fisierul text cu output-ul checker-ului poate fi vizualizat aici: https://pastebin.com/mPWMsKGN
Script-ul folosit pentru generarea codului verilog poate fi vizualizat aici: https://gist.github.com/MihaelaNego20/9dfa166fa3b8c5ee919e46ec4fbab806

3. modulul display_and_drop

Modulul display_and_drop primeste ca input timpul (calculat folosing square_root), limata acestui timp si un bit care reprezinta daca modulul este activat sau nu. In functie de aceste input-uri modulul va controla display-urile cu 7 segmente atasate la output-uri pentru a afisa textele COLD, HOT si DROP coresponzand sate-ului in care sse afla modulul. De asemenea modulul va controla si un output atasat la sistemul de drop.

4. modulul top (baggage_drop)

Modulul baggage_drop este o simpla implementare care foloseste toate modulele de mai sus pentru a completa cerinta enuntului. Toate output-urile sunt mapate de la un modulul la celalalt, singura expectie fiind output-ul de la modulul square_root care este shiftat 1 bit la dreapta (practic impartind cu 2) inainte sa fie transmis catre modulul display_and_drop.