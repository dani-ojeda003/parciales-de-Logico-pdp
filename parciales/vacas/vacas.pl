%1
seVa(dodain,pehuenia).
seVa(dodain,sanMartinAndes).
seVa(dodain,esquel).
seVa(dodain,sarmiento).
seVa(dodain,camarones).
seVa(dodain,playaDoradas).
seVa(alf,bariloche).
seVa(alf,sanMartinAndes).
seVa(alf,elBolson).
seVa(nico,marDelPlata).
seVa(vale,calafate).
seVa(vale,elBolson).

seVa(martu,Lugar):-
    seVa(nico,Lugar).

seVa(martu,Lugar):-
    seVa(alf,Lugar).
    

%2
atracciones(esquel,parqueNacional(losAlerces)).
atracciones(esquel,excursion(trochita)).
atracciones(esquel,excursion(trevelin)).
atracciones(villaPehuenia,cerro(bateaMahuida,2000)).
atracciones(villaPehuenia,cuerpoDeAgua(moquehue,sePuedePescar,14)).
atracciones(villaPehuenia,cuerpoDeAgua(alumine,sePuedePescar,19)).

persona(dodain).
persona(alf).
persona(nico).
persona(vale).
persona(martu).



vacacionesCopadas(Persona):-
    persona(Persona),
    forall(seVa(Persona,Lugar),tieneAtraccionCopada(Lugar)).

tieneAtraccionCopada(Lugar):-
    atracciones(Lugar,Atraccion),
    esAtraccionCopada(Atraccion).

esAtraccionCopada(cerro(_,Altura)):-
    Altura > 2000.

esAtraccionCopada(cuerpoDeAgua(_,sePuedePescar,_)).
esAtraccionCopada(cuerpoDeAgua(_,_,Temperatura)):-
    Temperatura > 20.

esAtraccionCopada(playa(Diferencia)):-
    Diferencia < 5.

esAtraccionCopada(parqueNacional(_)).

/*
esAtraccionCopada(excursion(Nombre)):-
    length(Nombre, Cantidad),
    Cantidad > 7.
    

excursion con mas de 7 letras??
*/

%3
noSeCruzaron(Persona,OtraPersona):-
    persona(Persona),
    persona(OtraPersona),
    Persona \=OtraPersona,
not(mismoDestino(Persona,OtraPersona)).



mismoDestino(Persona,OtraPersona):-
    Persona \=OtraPersona,
    seVa(Persona,Lugar),
    seVa(OtraPersona,Lugar).


%4
costo(sarmiento,100).
costo(esquel,150).
costo(pehuenia,180).
costo(sanMartinAndes,150).
costo(camarones,135).
costo(playaDoradas,170).
costo(bariloche,140).
costo(calafate,240).
costo(elBolson,145).
costo(marDelPlata,140).


vacacionesGasoleras(Persona):-
    persona(Persona),
    forall(seVa(Persona,Destino),destinoGasolero(Destino)).

destinoGasolero(Destino):-
    costo(Destino,Costo),
    Costo < 160.

%5
/*Falta combinar */
itinerariosPosibles(Persona,Itinerario):-
    persona(Persona),
    findall(Destino, seVa(Persona,Destino), ListaDeDestinos),
    combinar(ListaDeDestinos,Itinerario),
    length(Itinerario,3).
  
combinar([], []).
combinar([Destino|DestinosPosibles], [Destino|Destinos]):-
    combinar(DestinosPosibles, Destinos).
combinar([_|DestinosPosibles], Destinos):-
    combinar(DestinosPosibles,Destinos).



