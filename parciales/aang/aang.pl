
% esPersonaje/1 nos permite saber qué personajes tendrá el juego
esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla
controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)
visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).


%1
esElAvatar(Personaje):-
    controlaTodosElementosBasicos(Personaje).

controlaTodosElementosBasicos(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento),controla(Personaje,Elemento)).

%2
noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    forall(esPersonaje(Personaje),noControlaNingunElemento(Personaje)).

noControlaNingunElemento(Personaje):-
    esPersonaje(Personaje),
    not(controla(Personaje,_)).


esMaestroPrincipiante(Personaje):-
    controlaElementoBasico(Personaje),
    not(controlaElementoAvanzado(Personaje)).

controlaElementoBasico(Personaje):-
    controla(Personaje,Elemento),
    esElementoBasico(Elemento).

controlaElementoAvanzado(Personaje):-
    controla(Personaje,Elemento),
    elementoAvanzadoDe(_,Elemento).


esMaestroAvanzado(Personaje):-
    controlaElementoAvanzado(Personaje).

esMaestroAvanzado(Personaje):-
    esElAvatar(Personaje).

%3
sigueA(zuko,aang).

sigueA(Personaje,OtroPersonaje):-
    esPersonaje(Personaje),
    esPersonaje(OtroPersonaje),
    Personaje \= OtroPersonaje,
    forall(visito(Personaje,Lugares),visito(OtroPersonaje,Lugares)).

%4
esDignoDeConocer(temploAire(_)).

esDignoDeConocer(tribuAgua(norte)).

esDignoDeConocer(Lugar):-
    visito(_,Lugar),
    noTieneMuros(Lugar).

noTieneMuros(reinoTierra(_,Estructura)):-
    not(member(muro,Estructura)).

%5
esPopular(Lugar):-
    visito(_,Lugar),
    findall(Personaje,visito(Personaje,Lugar),ListaDeLugares),
    length(ListaDeLugares, Cantidad),
    Cantidad > 4.
    
%6

/*
bumi es un personaje que controla el elemento tierra y visitó Ba Sing Se en el 
reino Tierra;

suki es un personaje que no controla ningún elemento y que visitó una prisión de
 máxima seguridad en la nación del fuego protegida por 200 soldados. 

esPersonaje(bumi).
visito(bumi,reinoTierra(baSingSe,[muro, zonaAgraria, sectorBajo, sectorMedio]))

esPersonaje(suki).
visito(suki,nacionDelFuego(prisionMaximaSeguridad,200)).
*/