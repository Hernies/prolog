:- module(_,_,[assertions]).
%:- module(modulename,exports,[iso]).
:- use_module(library(lists)).
:- use_module(library(aggregates)).
:- use_module(library(between)).


author_data('Aguiar','Calvo','Hernán','B190090').
:- doc(author, "Hernán Calvo Aguiar,b190090").

:- doc(title, "Segunda Práctica: ISO Prolog").
:- doc(module,"
Este modulo define operaciones con 'Marias y Arañas'

@section{Parte 1 (5 pts). Particiones M-arias de un numero:}
Una particion de un número entero positivo N se define como un conjunto de números
enteros positivos que suman N, escritos en orden descendente. Por ejemplo, para el
número 15 tenemos:
@begin{verbatim}15=5+4+3+2+1@end{verbatim}
Una particion es M-aria si cada termino de dicha particion es una potencia de M.
Por ejemplo, las particiones 3-arias de 9 son:
@begin{verbatim}
9
3+3+3
3+3+1+1+1
3+1+1+1+1+1+1
1+1+1+1+1+1+1+1+1
@end{verbatim}
El objetivo de esta parte es escribir un predicado maria/3 tal que el tercer argumento es el numero de 
particiones M-arias del segundo argumento siendo M el primer argumento. 
Por ejemplo, @tt{?- maria(3,9,M).} debe devolver M=5 .
Para ello, se han implementan los siguientes predicados:

@subsection{Predicado 1.1 pots(M,N,Ps):}
Mi solución del predicado pots se basa en 2 ideas:
1. El uso de un corte para limitar la lista de soluciones
2. El cálculo de potencias de manera dinámica

Mi primera idea fue al darme cuenta que la longitud de la lista Ps mas uno sería igual al exponente mas uno:
@begin{verbatim}length(Ps)+1=exp@end{verbatim}
Pero debido a que incrementa demasiado el tiempo de cálculo no es una solución viable par exponentes demasiado grandes.
").

 %% 1.1
 %% dados M y N enteros, devuelve en Ps una lista con las potencias de M  que son menores o iguales que N en orden descendente

:- pred potcalc(M,N,Potencia,ListaPotencias,Ps)
   #"Realiza el cálculo de la potencia y el corte de la potencia. 
@var{M},
@var{N}, 
@var{Potencia} la ultima potencia calculada,
@var{ListaPotencias} la lista de potencias que se ha calculado, 
@var{Ps} la lista de potencias a devolver. @includedef{pot/5} ".
potcalc(M,N,OldPower,Potencias,Potencias):-
    OldPower*M > N,
    !.
    
potcalc(M,N,OldPower,Potencias,Ps):-
    NewPower is OldPower * M,
    potcalc(M,N,NewPower,[NewPower|Potencias],Ps).

:- pred pots(M,N,Ps)
   #"Devuelve en @{Ps} la lista de potencias de @var{M} en orden descendente menores que @var{N}. @includedef{pots/3} ".
pots(M,N,Ps):-
    integer(M),
    integer(N),
    potcalc(M,N,1,[1],Ps).