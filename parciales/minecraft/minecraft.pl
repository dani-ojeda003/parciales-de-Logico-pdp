
jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).
%jugador(nombre,Items,hambre)

%lugar(lugar,quien esta, oscuridad)
lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

%1a
tieneItem(Jugador,Item):-
    jugador(Jugador,Items,_),
    member(Item,Items).

%1b
sePreocupaPorSuSalud(Jugador):-
    jugador(Jugador,Items,_),
    member(Item1,Items),
    member(Item2,Items),
    esComestible(Item1),
    esComestible(Item2),
    Item1\= Item2.

esComestible(Item):-
    comestible(Item).

%1c
esItem(Item):-
    jugador(_,Items,_),
    member(Item,Items).

esJugador(Jugador):-
    jugador(Jugador,_,_).

cantidadDelItem(Jugador,Item,Cantidad):-
    esItem(Item),
    esJugador(Jugador),
    findall(Item, (jugador(Jugador,Items,_),member(Item,Items)) , ListadeItem),
    length(ListadeItem, Cantidad).
    
%1d
tieneMasDe(Jugador,Item):-
    cantidadDelItem(Jugador,Item,Cantidad),
    forall(cantidadDelItem(_,Item,Cantidad2), Cantidad>=Cantidad2).

%2a
hayMonstruos(Lugar):-
    lugar(Lugar,_,Nivel),
    Nivel >6.

%2b
correPeligro(Jugador):-
    lugar(Lugar,Jugadores,_),
    member(Jugador,Jugadores),
    hayMonstruos(Lugar).

correPeligro(Jugador):-
    jugador(Jugador,Items,_),
    member(Item,Items),
    not(esComestible(Item)),
    hambriento(Jugador).

hambriento(Jugador):-
    jugador(Jugador,_,Hambre),
    Hambre <4.

%2c
nivelPeligrosidad(Lugar,Nivel):-
    peligro(Lugar,Nivel).

peligro(Lugar,Peligro):-
    lugar(Lugar,Poblacion,_),
    Poblacion \=[],
    not(hayMonstruos(Lugar)),
    findall(Jugador, (member(Jugador,Poblacion),hambriento(Jugador)) ,ListaJugador),
    length(ListaJugador,Hambrientos),
    poblacionDe(Lugar,Cantidad),
    Peligro is (Hambrientos/Cantidad) * 100.


peligro(Lugar,100):-
    hayMonstruos(Lugar).

peligro(Lugar,Peligro):-
    lugar(Lugar,[],Oscuridad),
    Peligro is Oscuridad*10.

poblacionDe(Lugar,Cantidad):-
    lugar(Lugar,Poblacion,_),
    length(Poblacion,Cantidad).

%3
item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

puedeConstruir(Jugador,Item):-
    esJugador(Jugador),
    item(Item,_),
    forall(item(Item,Necesidades), (member(Necesidad,Necesidades), construye(Jugador,Necesidad))).

construye(Jugador,itemSimple(Item,Cantidad)):-
    esJugador(Jugador),
    cantidadDelItem(Jugador,Item,CantidadInventario),
    CantidadInventario >=Cantidad.


construye(Jugador,itemCompuesto(Nombre)):-
    item(Nombre,Necesidad),
    member(itemCompuesto(Nombre2),Necesidad),
    construye(Jugador,itemCompuesto(Nombre2)).

construye(Jugador,itemCompuesto(Nombre)):-
    item(Nombre,Necesidad),
    member(itemSimple(Item,Cantidad),Necesidad),
    construye(Jugador,itemSimple(Item,Cantidad)).
