%%%%%%%%%%%%%%%%%%%
% File: blocks.lp: Blocks World
%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sort and object declaration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% every block is a location
location(B) :- block(B).
% the table is a location
location(table).
%%%%%%%%%%%%%%%%%%%%%%%%%%
% state description
%%%%%%%%%%%%%%%%%%%%%%%%%%
% two blocks can't be on the same block at the same time
:- 2{on(BB,B,T)}, block(B), T = 0..m.
:- on(B1,B2,T), on(B2,B1,T), T = 0..m.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% effect and preconditions of action
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% effect of moving a block
on(B,L,T+1) :- move(B,L,T).
% concurrent actions are limited by num of grippers
:- not {move(BB,LL,T)} grippers,T = 0..m-1.
% a block can be moved only when it is clear
:- move(B,L,T), on(B1,B,T).
% a block can't be moved onto a block that is being moved also
:- move(B,B1,T), move(B1,L,T).
%:- move(B,L,T),move(B1,L,T), B=L.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% domain independent axioms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fluents are initially exogenous
1{on(B,LL,0):location(LL)}1 :- block(B).
% uniqueness and existence of value constraints
:- not 1{on(B,LL,T)}1, block(B), T=1..m.
% actions are exogenous
{move(B,L,T)} :- block(B), location(L), T = 0..m-1.
% commonsense law of inertia
{on(B,L,T+1)} :- on(B,L,T), T < m.
#show move/3.
%%%%%%%%%%%%%%%%%%%
% File: blocks-scenario.lp
%%%%%%%%%%%%%%%%%%%
block(1..6).
% initial state
:- not on(1,2,0; 2,table,0; 3,4,0; 4,table,0; 5,6,0; 6,table,0).
%:- not on(1,2,0;2,1,0;3,3,0;4,table,0;5,6,0;6,table,0).
% goal
:- not on(3,2,m; 2,1,m; 1,table,m; 6,5,m; 5,4,m; 4,table,m).
