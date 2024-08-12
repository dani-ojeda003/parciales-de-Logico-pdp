
% dueno(dueno,juguete, añosQueloTiene)
dueno(andy, woody, 8).
dueno(sam, jessie, 3).

% Relaciona al juguete con su nombre
% los juguetes son de la forma:
% deTrapo(tematica)
% deAccion(tematica, partes)
% miniFiguras(tematica, cantidadDeFiguras)
% caraDePapa(partes)
juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(senorCaraDePapa,caraDePapa([ original(pieIzquierdo),original(pieDerecho),repuesto(nariz) ])).

% Dice si un juguete es raro
esRaro(deAccion(stacyMalibu, [sombrero])).

esColeccionista(sam).

%1
tematica(woody,vaquero).
tematica(jessie,vaquero).
tematica(buzz,espacial).
tematica(soldados,soldado).
tematica(monitosEnBarril,mono).
tematica(senorCaraDePapa,caraDePapa(_)).

esDePlastico(Juguete):-
    juguete(Juguete,miniFiguras(_,_)).

esDePlastico(Juguete):-
    juguete(Juguete,caraDePapa(_)).
    

esDeColeccion(Juguete):-
    juguete(Juguete,deTrapo(_)).

esDeColeccion(Juguete):-
    juguete(Juguete,Caracteristica),
    esRaro(Caracteristica),
    Caracteristica \= miniFiguras(_,_).

%2
amigoFiel(Juguete,Dueno):-
    dueno(Dueno,Juguete,AniosQueTiene),
    not(esDePlastico(Juguete)),
    forall(dueno(Dueno,_,Ano), AniosQueTiene >= Ano).

%3
superValioso(Juguete):-
    esDeColeccion(Juguete),
    tienePiezasOriginales(Juguete),
    dueno(Dueno,Juguete,_),
    not(esColeccionista(Dueno)).

esJuguete(woody).
esJuguete(jessie).
esJuguete(buzz).
esJuguete(soldados).
esJuguete(monitosEnBarril).
esJuguete(senorCaraDePapa).


tienePiezasOriginales(Juguete):-
    esJuguete(Juguete),
    forall(juguete(Juguete, Caracteristica), esPiezaOriginal(Caracteristica)).

esPiezaOriginal(caraDePapa(Piezas)):-
    member(original(_), Piezas).
    
esPiezaOriginal(deAccion(_, Piezas)):-
    member(original(_), Piezas).

esPiezaOriginal(Caracteristica):-
    Caracteristica \= deAccion(_,_),
    Caracteristica \= caraDePapa(_).
    
%4
duoDinamico(Dueno,Juguete1,Juguete2):-
    dueno(Dueno,Juguete1,_),
    dueno(Dueno,Juguete2,_),
    Juguete1 \= Juguete2,
    hacenBuenaPareja(Juguete1,Juguete2).

    

hacenBuenaPareja(woody,buzz).

hacenBuenaPareja(Juguete1,Juguete2):-
    tematica(Juguete1,Tematica),
    tematica(Juguete2,Tematica).


%5
esDueno(andy).
esDueno(sam).

felicidad(Dueno,FelicidadTotal):-
    esDueno(Dueno),
    findall(Felicidad,(dueno(Dueno,Juguete,_), felicidadPorJuguete(Juguete,Felicidad)),ListaFelicidad),
    sumlist(ListaFelicidad, FelicidadTotal).
    

felicidadPorJuguete(Juguete,Felicidad):-
    juguete(Juguete,miniFiguras(_,Cantidad)),
    Felicidad is 20*Cantidad.

felicidadPorJuguete(Juguete,Felicidad):-
    juguete(Juguete,caraDePapa(Piezas)),
    findall(Pieza, member(original(_), Piezas), ListaOriginales),
    findall(Pieza, member(repuesto(_), Piezas), ListaRepuestos),
    length(ListaOriginales, CantOriginales),
    length(ListaRepuestos, CantRepuestos),
    Felicidad is (CantOriginales*5) + (CantRepuestos*8).


felicidadPorJuguete(Juguete,100):-
    juguete(Juguete,deTrapo(_)).


felicidadPorJuguete(Juguete,120):-
    juguete(Juguete,deAccion(_,_)),
    deColeccionistaODeColeccion(Juguete).


felicidadPorJuguete(Juguete,100):-
    juguete(Juguete,deAccion(_,_)),
    not(deColeccionistaODeColeccion(Juguete)).
    

deColeccionistaODeColeccion(Juguete):-
    esDeColeccion(Juguete),
    dueno(Dueno,Juguete,_),
    esColeccionista(Dueno).



%6
puedeJugarCon(Persona,Juguete):-
    dueno(Persona,Juguete,_).

puedeJugarCon(Persona,Juguete):-
    dueno(Persona,Juguete,_),
    puedePrestar(Persona,_).


puedePrestar(Persona,OtraPersona):-
    esDueno(Persona),
    esDueno(OtraPersona),
    Persona \= OtraPersona,
    cantidadDeJuguetes(Persona,Cantidad),
    cantidadDeJuguetes(OtraPersona,OtraCantidad),
    Cantidad >  OtraCantidad.


cantidadDeJuguetes(Persona,Cantidad):-
    esDueno(Persona),
    findall(Juguete,dueno(Persona,Juguete,_),ListaDeJuguetes),
    length(ListaDeJuguetes,Cantidad).


%7
%creo que esta mal :)
podriaDonar(Dueno,Juguetes,FelicidadTotal):-
    esDueno(Dueno),
    findall(Felicidad,(member(Juguete,Juguetes),felicidadPorJuguete(Juguete,Felicidad)),ListaFelicidad),
    sumlist(ListaFelicidad,FelicidadJuguetes),
    FelicidadTotal>FelicidadJuguetes.

