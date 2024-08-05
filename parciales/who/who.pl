

caza(peter).
caza(egon).
caza(ray).
caza(winston).


herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).
herramientasRequeridas(barrer, [trapeador]).


%1
cazador(egon,aspiradora(200)).
cazador(egon,trapeador).
cazador(peter,trapeador).
cazador(winston,varitaNeutrones).

%2

poseeHerramientaRequerida(Cazador,Herramienta):-
  caza(Cazador),
  cumple(Cazador,Herramienta).


cumple(Cazador,aspiradora(PotenciaMinima)):-
  caza(Cazador),
  cazador(Cazador,aspiradora(Potencia)),
  Potencia >= PotenciaMinima.

cumple(Cazador,Requisito):-
  caza(Cazador),
  cazador(Cazador,Requisito).


%3

puedeHacer(Cazador,_):-
  cazador(Cazador,varitaNeutrones).


puedeHacer(Cazador,Tarea):-
  caza(Cazador),
  herramientasRequeridas(Tarea, _),
  forall(herramientasRequeridas(Tarea,Herramientas),(member(Herramienta,Herramientas),poseeHerramientaRequerida(Cazador,Herramienta))).



%4

tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).


precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

  

valorTotal(Cliente,PrecioTotal):-
tareaPedida(Cliente, _, _),
findall(Precio, precioPorTareaPedida(Cliente,_,Precio) ,ListaPrecios),
sumlist(ListaPrecios,PrecioTotal).


precioPorTareaPedida(Cliente, Tarea, Precio):-
	tareaPedida(Tarea, Cliente, Metros),
	precio(Tarea, PrecioPorMetro),
	Precio is PrecioPorMetro * Metros.


%5

aceptaTarea(ray, limpiarTecho):-
  tareaPedida(limpiarTecho,_,_),
  not(tareaPedida(limpiarTecho,_,_)).





