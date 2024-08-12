
%1
seVa(dodain,pehuenia).
seVa(dodain,sanMartinDeLosAndes).
seVa(dodain,esquel).
seVa(dodain,sarmiento).
seVa(dodain,camarones).
seVa(dodain,playasDoradas).
seVa(alf,bariloche).
seVa(alf,sanMartinDeLosAndes).
seVa(alf,elBolson).
seVa(nico,marDelPlata).
seVa(vale,calafate).
seVa(vale,elBolson).

seVa(martu,Lugar):-
    seVa(nico,Lugar).

seVa(martu,Lugar):-
    seVa(alf,Lugar).

seVa(dani,esquel).


/*
2) Incorporamos ahora información sobre las atracciones de cada lugar. 
Las atracciones se dividen en: 
parque nacional, donde sabemos su nombre
cerro sabemos su nombre y la altura
cuerpo de agua (cuerpoAgua, río, laguna, arroyo), sabemos si se puede pescar y la 
temperatura promedio del agua
una playa: tenemos la diferencia promedio de marea baja y alta
una excursión: sabemos su nombre

Queremos saber qué vacaciones fueron copadas para una persona. Esto ocurre cuando todos 
los lugares a visitar tienen por lo menos una atracción copada. 
un cerro es copado si tiene más de 2000 metros
un cuerpoAgua es copado si se puede pescar o la temperatura es mayor a 20
una playa es copada si la diferencia de mareas es menor a 5
una excursión que tenga más de 7 letras es copado
cualquier parque nacional es copado
El predicado debe ser inversible. 
*/
atracciones(esquel,parqueNacional(losAlerces)).
atracciones(esquel,excursion(trochita)).
atracciones(esquel,excursion(trevelin)).
atracciones(villaPuhuenia,cerro(bateaMahuida,2000)).
atracciones(villaPuhuenia,cuerpoAgua(sePuedePescar,14)).
atracciones(villaPuhuenia,cuerpoAgua(sePuedePescar,19)).

esPersona(Persona):-
    seVa(Persona,_).

vacacionesCopadas(Persona):-
    esPersona(Persona),
    forall(seVa(Persona,Lugar),tieneUnaAtraccionCopada(Lugar)).

tieneUnaAtraccionCopada(Lugar):-
    atracciones(Lugar,Atraccion),
    esAtraccionCopada(Atraccion).


esAtraccionCopada(cerro(_,Altura)):-
    Altura > 2000.

esAtraccionCopada(cuerpoAgua(sePuedePescar,_)).

esAtraccionCopada(cuerpoAgua(_,Temperatura)):-
    Temperatura >20.


esAtraccionCopada(playa(Diferencia)):-
    Diferencia <5.


/* una excursión que tenga más de 7 letras es copado ?????????
esAtraccionCopada(excursion(Nombre)):-
    length(Nombre, Cantidad),
    Cantidad >7.
 */ 

esAtraccionCopada(parqueNacional(_)).

/*
3) Cuando dos personas distintas no coinciden en ningún lugar como destino decimos que no 
se cruzaron. Por ejemplo, Dodain no se cruzó con Nico ni con Vale (sí con Alf en San Martín 
de los Andes). Vale no se cruzó con Dodain ni con Nico (sí con Alf en El Bolsón). 
 El predicado debe ser completamente inversible.
*/
noSeCruzaron(Persona1,Persona2):-
    esPersona(Persona1),
    esPersona(Persona2),
    Persona1 \= Persona2,
    not(seCruzaron(Persona1,Persona2)).
    

seCruzaron(Persona1,Persona2):-
    seVa(Persona1,Lugar),
    seVa(Persona2,Lugar),
    Persona1 \= Persona2.


/*
4) Queremos saber si unas vacaciones fueron gasoleras para una persona. Esto ocurre si 
todos los destinos son gasoleros, es decir, tienen un costo de vida menor a 160. Alf, Nico y
 Martu hicieron vacaciones gasoleras.
El predicado debe ser inversible.
*/
costoVida(sarmiento,100).
costoVida(esquel,150).
costoVida(villaPuhuenia,180).
costoVida(sanMartinDeLosAndes,150).
costoVida(camarones,135).
costoVida(playasDoradas,170).
costoVida(bariloche,140).
costoVida(calafate,240).
costoVida(elBolson,145).
costoVida(marDelPlata,140).

vacacionesGasoleras(Persona):-
    esPersona(Persona),
    forall(seVa(Persona,Destino),esDestinoGasolero(Destino)).

esDestinoGasolero(Destino):-
    costoVida(Destino,Costo),
    Costo <160.


/*
5) Queremos conocer todas las formas de armar el itinerario de un viaje para 
una persona sin importar el recorrido. Para eso todos los destinos tienen que aparecer 
en la solución (no pueden quedar destinos sin visitar).
*/

itinerario(Persona, Itinerario) :-
    esPersona(Persona),
    findall(Lugar, seVa(Persona, Lugar), Destinos),
    permutation(Destinos, Itinerario).

/*

    itinerario(Persona, Itinerario) :-
        esPersona(Persona),
        findall(Lugar, seVa(Persona, Lugar), Destinos),
        itinerario_aux(Destinos, [], Itinerario).
    
    % Predicado auxiliar para construir el itinerario
    itinerario_aux([], Itinerario, Itinerario).
    itinerario_aux(Destinos, ItinerarioParcial, Itinerario) :-
        seleccionar(Destino, Destinos, RestoDestinos),
        itinerario_aux(RestoDestinos, [Destino|ItinerarioParcial], Itinerario).
    
    % Predicado para seleccionar un elemento de la lista
    seleccionar(Elemento, [Elemento|Resto], Resto).
    seleccionar(Elemento, [OtroElemento|Resto], [OtroElemento|RestoSinElemento]) :-
        seleccionar(Elemento, Resto, RestoSinElemento).


itinerario/2:
Encuentra todos los destinos de una persona con findall/3 y luego llama al predicado 
auxiliar itinerario_aux/3, pasando la lista de destinos, una lista vacía para el itinerario 
parcial, y una variable para el itinerario final.

itinerario_aux/3:
Si no hay destinos restantes (Destinos es una lista vacía), el itinerario parcial es el
 itinerario completo.
Si hay destinos restantes, selecciona uno (seleccionar/3), lo agrega al itinerario parcial, 
y llama recursivamente al mismo predicado para seguir construyendo el itinerario.

seleccionar/3:
Este predicado selecciona un elemento (Elemento) de una lista, devolviendo el resto de la 
lista sin ese elemento (Resto).
Se recorre la lista hasta encontrar el elemento y se construye una nueva lista con 
el resto de los elementos.
*/