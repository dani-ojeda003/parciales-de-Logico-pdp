
%1
vocaloid(megurineLuka,canta(nightFever,4)).
vocaloid(megurineLuka,canta(foreverYoung,5)).
vocaloid(hatsuneMiku,canta(tellYourWorld,4)).
vocaloid(gumi,canta(foreverYoung,4)).
vocaloid(gumi,canta(tellYourWorld,4)).
vocaloid(seeU,canta(novemberRain,6)).
vocaloid(seeU,canta(nightFever,5)).

cantante(megurineLuka).
cantante(hatsuneMiku).
cantante(gumi).
cantante(seeU).
cantante(kaito).

cantanteNovedoso(Cantante):-
sabeDosCanciones(Cantante),
tiempoTotalCanciones(Cantante,Tiempo),
Tiempo < 15.

sabeDosCanciones(Cantante):-
vocaloid(Cantante,Cancion1),
vocaloid(Cantante,Cancion2),
Cancion1 \= Cancion2.


tiempoTotalCanciones(Cantante,TiempoTotal):-
findall(Tiempo,tiempoDeCancion(Cantante,Tiempo),Tiempos),
sumlist(Tiempos,TiempoTotal).

tiempoDeCancion(Cantante,Tiempo):-
vocaloid(Cantante,canta(_,Tiempo)).

%2

cantanteAcelerado(Cantante):-
cantante(Cantante),
not((tiempoDeCancion(Cantante,Tiempo),Tiempo > 4)).


%1


concierto(mikuExpo,eeuu,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, peque(4)).

%2

puedeParticipar(hatsuneMiku,Concierto):-
	concierto(Concierto, _, _, _).

puedeParticipar(Cantante, Concierto):-
  cantante(Cantante),
  Cantante \= hatsuneMiku,
  concierto(Concierto, _,_, Requisito),
  cumpleRequisito(Cantante,Requisito).

cumpleRequisito(Cantante,gigante(CantCanciones,Tiempo)):-
tiempoTotalCanciones(Cantante,TiempoTotal),
TiempoTotal> Tiempo,
cantidadCanciones(Cantante,Cantidad),
Cantidad >= CantCanciones.

cumpleRequisito(Cantante,mediano(Tiempo)):-
cantante(Cantante),
tiempoTotalCanciones(Cantante,Total),
Total > Tiempo.

cumpleRequisito(Cantante,peque(TiempoDado)):-
cantante(Cantante),
tiempoDeCancion(Cantante,Tiempo),
Tiempo > TiempoDado.


cantidadCanciones(Cantante, Cantidad) :- 
findall(Cancion, vocaloid(Cantante, Cancion), Canciones),
length(Canciones, Cantidad).


%3


masFamoso(Cantante) :-
	famaTotal(Cantante, MasFama),
	forall(famaTotal(_, Fama), MasFama >= Fama).


famaTotal(Cantante,FamaTotal):-
cantante(Cantante),
findall(Fama,(famaConcierto(Cantante, Fama)),ListaFama),
sum_list(ListaFama,FamaDeLista),
cantidadCanciones(Cantante,Cantidad),
FamaTotal is FamaDeLista * Cantidad.


famaConcierto(Cantante, Fama):-
puedeParticipar(Cantante,Concierto),
fama(Concierto, Fama).

fama(Concierto,Fama):- 
concierto(Concierto,_,Fama,_).



%4

conoce(megurineLuka,hatsuneMiku).
conoce(megurineLuka,gumi).
conoce(gumi,seeU).
conoce(seeU,kaito).


unicoParticipante(Cantante,Concierto):-
puedeParticipar(Cantante,Concierto),
not((puedeParticipar(OtroCantante,Concierto),conocido(Cantante,OtroCantante))).


conocido(Cantante,OtroCantante):-
conoce(Cantante,OtroCantante).


conocido(Cantante,OtroCantante):-
conoce(Cantante,UnCantante),
conoce(UnCantante,OtroCantante).









