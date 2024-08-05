

%1
sangre(harry,mestiza).
sangre(draco,pura).
sangre(hermione,impura).

casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).


mago(Mago):-
sangre(Mago,_).

permiteEntrar(Casa,Mago):-
mago(Mago),
casa(Casa),
Casa \= slytherin.

permiteEntrar(slytherin,Mago):-
sangre(Mago,Sangre),
Sangre \= impura.


%2


caracteristicas(harry,coraje).
caracteristicas(harry,amistad).
caracteristicas(harry,orgullo).
caracteristicas(harry,inteligencia).
caracteristicas(draco,inteligencia).
caracteristicas(draco,orgullo).
caracteristicas(draco,responsable).
caracteristicas(hermione,inteligencia).
caracteristicas(hermione,orgullo).
caracteristicas(hermione,responsable).



necesidades(gryffindor,coraje).
necesidades(slytherin,orgullo).
necesidades(slytherin,inteligencia).
necesidades(ravenclaw,inteligencia).
necesidades(ravenclaw,responsabilidad).
necesidades(hufflepuff,amistad).

odia(harry,slytherin).
odia(draco,hufflepuff).

caracterApropiado(Casa,Mago):-
  mago(Mago),
  casa(Casa),
  forall(necesidades(Casa,Caracteristica),caracteristicas(Mago,Caracteristica)).


%3


puedeIr(Casa,Mago):-
  caracterApropiado(Casa,Mago),
  permiteEntrar(Casa,Mago),
  not(odia(Mago,Casa)).

puedeIr(gryffindor,hermione).

%4

magoAmistoso(Mago):-
  caracteristicas(Mago,amistad).

todosAmistosos(Magos):-

forall(member(Mago,Magos),magoAmistoso(Mago)).

cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
puedeIr(Casa,Mago1),
puedeIr(Casa,Mago2),
cadenaDeCasas([Mago | MagosSiguientes]).
cadenaDeCasas([_]).
cadenaDeCasas([]).

cadenaDeAmistades(Magos):-
todosAmistosos(Magos),
cadenaDeCasas(Magos).
  


%parte2_1

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).


buenAlumno(Mago):-
  hizo(Mago,_),
  not(esMalaAccion(Mago)).


hizo(harry,fueraDeCama).
hizo(hermione,fueA(tercerPiso)).
hizo(hermione,fueA(biblioteca)).
hizo(harry,fueA(bosque)).
hizo(harry,fueA(tercerPiso)).
hizo(draco,fueA(mazmorras)).
hizo(ron,buenaAccion(50,ganarAjedrez)).
hizo(hermione,buenaAccion(50,salvarAmigos)).
hizo(harry,buenaAccion(60,derrotarVoldemort)).
hizo(harry,buenaAccion(110,buenPibe)).

%4
hizo(hermione,responde(bezoar,20,snape)).
hizo(hermione,responde(levitarPluma,25,flitwick)).
%4

hizoAlgunAccion(Mago):-
  hizo(Mago,_).

esMalaAccion(Mago):-
  hizo(Mago,Accion),
  puntajeGenerado(Accion, Puntaje),
  Puntaje < 0 .

puntajeGenerado(fueraDeCama,-50).
puntajeGenerado(fueA(Lugar),Puntaje):-
lugarProhibido(Lugar,Puntaje).

puntajeGenerado(fueA(Lugar),0):-
 not(lugarProhibido(Lugar, _)).

puntajeGenerado(buenaAccion(Puntaje,_), Puntaje).


%4
puntajeGenerado(responde(_,Dificultad,snape),Puntaje):-
  Puntaje is Dificultad //2.

puntajeGenerado(responde(_,Dificultad,Profesor),Dificultad):-
  Profesor \= snape.

%4

lugarProhibido(bosque,-50).
lugarProhibido(tercerPiso,-75).
lugarProhibido(biblioteca,-10).

recurrente(Accion):-
hizo(Mago,Accion),
hizo(Mago2,Accion),
Mago \= Mago2.



%2

puntajeTotal(Casa, PuntajeTotal):-
  casa(Casa),
  findall(Puntaje,puntosGeneradosPara(Casa,Puntaje),ListaPuntos),
  sumlist(ListaPuntos,PuntajeTotal).

puntosGeneradosPara(Casa,Puntaje):-
  esDe(Mago,Casa),
  hizo(Mago,Accion),
  puntajeGenerado(Accion,Puntaje).


%3

ganador(Casa):-
  puntajeTotal(Casa,PuntajeMayor),
  forall((puntajeTotal(OtraCasa,PuntajeMenor), Casa \= OtraCasa ),PuntajeMayor >PuntajeMenor).


