# Rapport de Projet de Méthodologie de la Programmation

## Objectif du rapport 

Ce rapport présentera le projet réalisé pour le module "Méthodologie de la Programmation" de l'ENSEEIHT Toulouse.   
Il  abordera les différentes parties de la conception de ce projet. Il y sera présenté les choix techniques, les algorithmes utilisés, la structure du programme et les difficultés rencontrée.

## Introduction 

Le projet proposé consiste à créer un système de gestion d'arbre généalogique d'un individue. L'arbre généalogique permet à un individu de répertorier l'ensemble de ses ancêtres.
On peut représenter l'ensemble des ancêtres par un arbre où chaque ou chaque individu est représenté par un nœud qui peut avoir deux parents. 
> Exemple :
> - Bernard
>	 - pere : Jackie
>		- pere : Dominique 
>	 - mere : Jane 
>		- mere : Dominique 

On voudra pouvoir designer les individus en relation des uns par rapport aux autres avec la notion de génération d'ancêtre et de descendant
> Exemple : 
> - Un individue est sont propre ancetre/decendant  de generation 0
> - Le pere d'un individue est sont ancetre de generation 1
> - La grand mere d'un  individue est son ancetre de generation 2
> - Le fils d'un individue est sont dedendant de generation 1

## Plan 

Les modules étant déjà une sous-division structurante du projet du programme nous aborderont chaque aspect de conception pour chaque module.

Le rapport suivra le plan suivant : 

[TOC]

## Architecture du programme : 

Afin d'assurer une bonne lisibilité et une bonne modularité, le code du projet a été décomposé en plusieurs moules ada par rapport à leurs fonctions. 

Dans cette partie les modules constituant ce projet seront présenté avec leur but. Nous nous intéresserons qu'aux modules appartenant au projet et nous omettrons les modules standard de ada.

Les modules développé sont : 
- **``p_arbre_binaire``** : Ce module générique contient l'entièreté des fonctions et des types nécessaire pour faire fonctionner un arbre binaire non trié. On y trouve le type générique``T_AB`` et les sous programmes permettant de le manipuler.
*Paramètre de généricité* : 
	- T : type des donnés
	- "=" : comparaison entre deux T
	- put(x :T) : procédure d'affichage de T
- **``p_personne``** : Ce module contient le type ``t_personne`` qui représente un individu. Il y a aussi les différents sous-programmes permettant de le manipuler (init/getter/setter/comparaison/affichage).
- **``p_arbre_genealogique``** : Ce module instancie ``p_arbre_binaire`` avec ``t_persone`` et ses sous programme associé. Dans ce 

<!--stackedit_data:
eyJoaXN0b3J5IjpbMjczMjU2NjcxLDIwMzM4ODkwNzYsLTEwMz
g5NzU4NzAsMTg4NzU5OTUxLC0xMzMzOTgwNTkwLC0xOTQ0NDQ0
NDgzLDE0ODM3MzgyMzAsLTEyNzgxMTQ1NSw3ODY3MDUyMTFdfQ
==
-->