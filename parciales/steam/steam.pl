
juego(accion(callOfDuty),5).
juego(accion(batmanAA),10).
juego(mmorpg(wow,5000000),30).
juego(mmorpg(lineage2,6000000),15).
juego(puzzle(plantsVsZombies,40,media),10).
juego(puzzle(tetris,10,facil),0).

oferta(callOfDuty,10).
oferta(plantsVsZombies,50).

usuario(nico,[batmanAA,plantsVsZombies,tetris],[compra(lineage2)]).
usuario(fede,[],[regalo(callOfDuty,nico),regalo(wow,nico)]).
usuario(rasta,[lineage2],[]).
usuario(agus,[],[]).
usuario(felipe,[plantsVsZombies],[compra(tetris)]).

usuario(brenda,[],[compra(plantsVsZombies)]).

%1
nombreDelJuego(accion(Nombre),Nombre).

nombreDelJuego(mmorpg(Nombre,_),Nombre).

nombreDelJuego(puzzle(Nombre,_,_),Nombre).


cuantoSale(Juego,Valor):-
    juego(Juego,ValorSinDescuento),
    tieneOferta(Juego,Oferta),
    Valor is ValorSinDescuento - (ValorSinDescuento * (Oferta/100)).

cuantoSale(Juego,Valor):-
    juego(Juego,Valor),
    not(tieneOferta(Juego,_)).


tieneOferta(Juego,Oferta):-
    nombreDelJuego(Juego,Nombre),
    oferta(Nombre,Oferta).

%2
esJuego(Juego):-
    juego(Juego,_).

juegoPopular(Juego):-
    esJuego(Juego),
    esPopular(Juego).

esPopular(accion(_)).
esPopular(mmorpg(_,Cantidad)):-
    Cantidad> 1000000.
esPopular(puzzle(_,25,_)).
esPopular(puzzle(_,_,facil)).
/*
● accion(NombreDelJuego)
● mmorpg(NombreDelJuego, CantidadDeUsuarios)
● puzzle(NombreDelJuego, CantidadDeNiveles, Dificultad)
*/
%3
tieneUnBuenDescuento(Juego):-
    esJuego(Juego),
    tieneOferta(Juego,Oferta),
    Oferta>50.

%4
esUsuario(Usuario):-
    usuario(Usuario,_,_).

adictoALosDescuentos(Usuario):-
    esUsuario(Usuario),
    forall(usuario(Usuario,_,Juegos),descuentoDeAdquisiciones(Juegos)).

descuentoDeAdquisiciones(Juegos):-
    member(compra(Nombre),Juegos),
    oferta(Nombre,Oferta),
    Oferta>50.

descuentoDeAdquisiciones(Juegos):-
    member(regalo(Nombre,_),Juegos),
    oferta(Nombre,Oferta),
    Oferta>50.

%5
fanaticoDe(Usuario,Genero):-
    usuario(Usuario,JuegosQuePosee,_),
    tieneAlmenosDosJuegosDe(Genero,JuegosQuePosee).


tieneAlmenosDosJuegosDe(Genero,Juegos):-
    member(Juego1,Juegos),
    member(Juego2,Juegos),
    Juego1 \= Juego2,
    esDelGenero(Genero,Juego1),
    esDelGenero(Genero,Juego2).


esDelGenero(accion(_),Juego):-
    juego(accion(Juego),_).

esDelGenero(mmorpg(_,_),Juego):-
    juego(mmorpg(Juego,_),_).

esDelGenero(puzzle(_,_,_),Juego):-
    juego(puzzle(Juego,_,_),_).


%6
%genera a nico y no deberia
monotematico(Usuario,Genero):-
    usuario(Usuario,Juegos,_),
    Juegos \= [],
    esDelGenero(Genero,_),
    forall(member(Juego,Juegos),(esDelGenero(Genero,Juego))).

%7
/*
usuario(nico,[batmanAA,plantsVsZombies,tetris],[compra(lineage2)]).
usuario(fede,[],[regalo(callOfDuty,nico),regalo(wow,nico)]).
usuario(rasta,[lineage2],[]).
usuario(agus,[],[]).
usuario(felipe,[plantsVsZombies],[compra(tetris)]).

juego(accion(callOfDuty),5).
juego(accion(batmanAA),10).
juego(mmorpg(wow,5000000),30).
juego(mmorpg(lineage2,6000000),15).
juego(puzzle(plantsVsZombies,40,media),10).
juego(puzzle(tetris,10,facil),0).
*/
%populares: call, batman,wow, lineage, tetris
buenosAmigos(Usuario,OtroUsuario):-
    esUsuario(Usuario),
    esUsuario(OtroUsuario),
    regalaJuegoPopular(Usuario,OtroUsuario),
    regalaJuegoPopular(OtroUsuario,Usuario).


regalaJuegoPopular(Usuario,OtroUsuario):-
    usuario(Usuario,_,Juegos),
    esUsuario(OtroUsuario),
    Juegos\= [],
    member(regalo(Nombre,OtroUsuario),Juegos),
    nombreDelJuego(Juego,Nombre),
    esPopular(Juego).

%8
cuantoGastara(Usuario,Total):-
    usuario(Usuario,_,Juegos),
    findall(Precio,(futuraAdquisicion(Juegos,Juego),precioFuturaAdquisicion(Juego,Precio)),ListaPrecios),
    sumlist(ListaPrecios,Total).

futuraAdquisicion(Juegos,Juego):-
    member(compra(Juego),Juegos).

futuraAdquisicion(Juegos,Juego):-
    member(regalo(Juego,_),Juegos).
    

precioFuturaAdquisicion(Nombre,Precio):-
    nombreDelJuego(Juego,Nombre),
    cuantoSale(Juego,Precio).







