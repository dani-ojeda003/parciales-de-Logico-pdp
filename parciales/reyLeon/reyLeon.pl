

%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).

comio(shenzi,hormiga(conCaraDeSimba)).

pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

/* Tenemos tres tipos de bichos, representados por functores: 
las vaquitas de San Antonio (de quienes nos interesa un peso), 
las cucarachas (de quienes nos interesa un tamaño y un peso) y 
las hormigas, que pesan siempre lo mismo. 
De los personajes también se conoce el peso, mediante hechos. */

%1-a) Qué cucaracha es jugosita: ó sea, hay otra con su mismo tamaño pero ella es más gordita.
jugosita(cucaracha(Nombre,Tamano,Peso)):-
    comio(_,cucaracha(Nombre,Tamano, Peso)),
    comio(_,cucaracha(OtroNombre,Tamano, OtroPeso)),
    Nombre \= OtroNombre,
    Peso > OtroPeso.

%1-b) Si un personaje es hormigofílico... (Comió al menos dos hormigas).
hormigofilico(Personaje):-
    comio(Personaje,hormiga(Nombre)),
    comio(Personaje,hormiga(OtroNombre)),
    Nombre \= OtroNombre.

%1-c) Si un personaje es cucarachofóbico (no comió cucarachas).
esPersonaje(Personaje):-
    comio(Personaje,_).

cucarachofobico(Personaje):-
    esPersonaje(Personaje),
    not(comio(Personaje,cucaracha(_,_,_))).

/*d) Conocer al conjunto de los picarones. Un personaje es picarón si comió una cucaracha 
jugosita ó si se come a Remeditos la vaquita. Además, pumba es picarón de por sí.  */
esPicaron(Personaje):-
    comio(Personaje,Cucaracha),
    jugosita(Cucaracha).

esPicaron(Personaje):-
    comio(Personaje,vaquitaSanAntonio(remeditos,_)).

esPicaron(pumba).

conjuntoPicarones(Picarones):-
    findall(Personaje, esPicaron(Personaje),Picarones).


persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

persigue(scar, mufasa).

/*2-a) Se quiere saber cuánto engorda un personaje (sabiendo que engorda una cantidad igual 
a la suma de los pesos de todos los bichos en su menú). Los bichos no engordan.  */

cuantoEngorda(Personaje,PesoTotal):-
    esPersonaje(Personaje),
    findall(Peso , (comio(Personaje,Bicho), pesoDeBicho(Bicho,Peso)) ,ListaDePesos),
    sumlist(ListaDePesos,PesoTotal).

/*2-b)Pero como indica la ley de la selva, cuando un personaje persigue a otro, se lo termina
comiendo,y por lo tanto también engorda.Realizar una nueva version del predicado cuantoEngorda.
*/
cuantoEngorda(Personaje,PesoTotal):-
    persigue(Personaje,OtroPersonaje),
    peso(OtroPersonaje, PesoTotal).
    

pesoDeBicho(vaquitaSanAntonio(_,Peso),Peso).

pesoDeBicho(hormiga(_),2).

pesoDeBicho(cucaracha(_,_,Peso),Peso).


/*2-c) Ahora se complica el asunto, porque en realidad cada animal antes de comerse a sus 
víctimas espera a que estas se alimenten. De esta manera, lo que engorda un animal no es sólo
 el peso original de sus víctimas, sino también hay que tener en cuenta lo que éstas comieron 
 y por lo tanto engordaron. Hacer una última version del predicado.
*/

/* Sabiendo que todo animal adora a todo lo que no se lo come o no lo
persigue, encontrar al rey. El rey es el animal a quien sólo hay un animal
que lo persigue y todos adoran.
Si se agrega el hecho: */
esPersonaje2(Personaje):-
    persigue(Personaje,_).

esPersonaje2(Personaje):-
    persigue(_,Personaje).


rey(Animal):-
    persigue(OtroAnimal,Animal),
    forall(Otro \= OtroAnimal, not(persigue(Otro, Animal))),
    todosAdoran(Animal).


todosAdoran(Animal):-
    not(comio(Animal,_ )),
    not(persigue(Animal,_ )).

  