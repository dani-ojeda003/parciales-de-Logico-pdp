
tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).


ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).


jefe(jefeSupremo,vega ).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).


%1
frecuenta(_,buenosAires).

frecuenta(Agente,Ubicacion):-
    tarea(Agente,_,Ubicacion).

frecuenta(vega,quilmes).

frecuenta(Agente,marDelPlata):-
    tarea(Agente, vigilar(Ubicaciones),_),
    member(negocioDeAlfajores, Ubicaciones).

%2
inaccesible(Ubicacion):-
    ubicacion(Ubicacion),
    not(frecuenta(_,Ubicacion)).

%3
afincado(Agente):-
    cantidadDeTareas(Agente,Cantidad),
    Cantidad > 1,
    tarea(Agente,Tarea1,Ubicacion),
    tarea(Agente,Tarea2,Ubicacion),
    Tarea1\= Tarea2.

afincado(Agente):-
    cantidadDeTareas(Agente,Cantidad),
    Cantidad = 1,
    tarea(Agente,_,_).

cantidadDeTareas(Agente,Cantidad):-
    tarea(Agente,_,_),
    findall(Tarea, tarea(Agente,Tarea,_) ,ListaTareas ),
    length(ListaTareas, Cantidad).
    
%4 no sabe, no contesta

%5
esAgente(Agente):-
    tarea(Agente,_,_).

agentePremiado(Agente):-
    puntuacionTotal(Agente,Total),
    forall(puntuacionTotal(_,Total2), Total >=Total2).
    

puntuacionTotal(Agente,Total):-
    esAgente(Agente),
    findall(Puntuacion, (tarea(Agente,Tarea,_), puntuacion(Tarea,Puntuacion)) , ListaPuntuacion),
    sumlist(ListaPuntuacion, Total).

puntuacion(vigilar(Locaciones),Puntuacion):-
    length(Locaciones,Cantidad),
    Puntuacion is Cantidad * 5.

puntuacion(ingerir(_,Tamano,Cantidad),Puntuacion):-
    Puntuacion is -10 * (Tamano*Cantidad).

puntuacion(apresar(_,Recompensa),Puntuacion):-
    Puntuacion is Recompensa//2.

puntuacion(asuntosInternos(AgenteInvestigado),Puntuacion):-
    puntuacionTotal(AgenteInvestigado,Total),
    Puntuacion is Total *2.
