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
- **``p_linked_list``** : Ce module générique contient les sous-programmes et les types afin de faire une liste chainée.  Pour éviter de répéter du travail. On utilise un module développé dans le cadre des TPs 
*Paramètre de généricité* : 
	- T : type des donnés
	- afficher(x :T) : procédure d'affichage de T
- **``p_personne``** : Ce module contient le type ``t_personne`` qui représente un individu. Il y a aussi les différents sous-programmes permettant de le manipuler (init/getter/setter/comparaison/affichage).
- **``p_arbre_genealogique``** : Ce module instancie ``p_arbre_binaire`` avec ``t_persone`` et ses sous programme associé. Dans ce module on retrouve aussi toutes les procédures de manipulation d'un arbre généalogique qui ne n'ont pas de sens dans un arbre binaire non trié quelconque.  Dans ce module on renomme ``T_AB`` en ``T_AG``. Dans ce module on instancie aussi ``p_linked_list `` avec ``t_personne`` car certaines fonctions ont besoin de renvoyer une liste d'individus.
- **``p_front``** : dans ce module on retrouve toutes les procédures et fonction d'entré/sortie nécessaire pour le programme principal(``main``).
- **``main``** et le programme principal il contient la logique du menu et fait les appels à ``p_arbre_généalogique`` et à ``p_arbre_binaire`` en fonction des entré de l'utilisateur.


## Choix de conception 


## Types

Dans cette partie nous nous intéresserons aux types contenue dans les différents modules. 

### ``p_arbre_binaire`` : 

Dans ce module on veut mettre en place un arbre binaire non trié. Un arbre binaire non trié structurellement n'est pas diffèrent de tout autre arbre binaire. Il est constitué de cellules contenant chacune deux références à d'autre cellule et un élément de donné 
  
Pour ce faire il nous faut trois types :
- **``T_Element``**(privé) : Un type en paramètre de généricité du module.
- **``T_AB``**(visible privé) : Un pointeur vers une cellule de l'arbre(``T_AB_Cell``). Représente un arbre binaire.
- **``T_AB_Cell``**(privé) : Un record qui représente une cellule d'arbre : 
```
- gauche : T_AB
- droite : T_AB
- valeur : T_Element
```


### ``p_personne`` 

Nous allons vouloir représenter des individus. Pour ce faire on utilisera un type record ``T_Personne`` :
```
- id : integer
- nom : string
- prenom : string
```
Le type ``T_personne`` n'est encore utilisé que pour contenir le nom et le prénom de l'individue mais le type pourrait être très facilement étendu en modifiant la déclaration du type.   

### ``P_linked_list``

Certains sous programmes nécessiterons une liste pour fonctionner. Il faudra donc un type ``T_linked_list`` qui représente une liste 

Dans ce module on a 2 types :  
- ``T_linked_list_cell`` : Un record qui constitue la liste
```
- value : T
- next : T_linked_list
``` 
- ``T_linked_list`` : un pointeur vers ``T_linked_list_cell``.

### ``p_arbre_genealogique`` 

Nous allons vouloir faire un arbre généalogique. On peut se servir de l'arbre binaire de ``p_arbre_binaire`` pour faire notre arbre généalogique.
On utilisera le type ``T_AG`` qui est une implémentation de ``T_AB`` avec ``T_personne`` renommé.

Les sous programmes de ce module nécessite de faire des listes de personnes nous implémenterons donc le module ``p_linked_list`` avec ``T_personne`` pour obtenir une ``t_linked_list`` qu'on renommera en ``L_personne``.


## Fonctions Et Procédures

Dans cette partie nous nous intéresserons aux procédures et fonctsion 
### Fonctions et procédures de ``T_AB`` : 

#### Initialiser

##### Specification
```ada
-- nom : init
-- sémantique:  Crée un arbre binaire avec un noeud racine. 
-- paramètres:
  -- arbre : out T_AB; -- Arbre qui est initialisé par la procedure
  -- e_racine : in T_element; -- Element contenue dans le noeud racine
-- pré-condition : ∅
-- post-condition :
  -- arbre.all /= null 
  -- arbre.all.value = e_racine
  -- arbre.all.gauche = null
  -- arbre.all.droite = null
-- Tests de la procédure :
procedure init(arbre : out T_AB, e_racine : in T_element);
```

##### Rafinage
```
R0 : “Créer un arbre binaire avec un noeud racine”
R1 : comment “Créer un arbre binaire avec un noeud racine”   -- arbre : out t_AB; e_racine : in T_element
  attribuer la valeur au noeud
R2 : comment “attribuer la valeur au noeud”  -- e_racine : in T_element
  arbre:=new T_AB_Cell
  arbre.all.element <- e_racine
```


#### Insérer une valeur à gauche

##### Spécification
```ada
-- Nom : inserer_gauche
-- sémantique : inserer un noeud a gauche d’un noeud donner
--paramètres : 
    --noeud : in out T_AB -- noeud ou il faut insérer à gauche    
    -- valeur : in T_element ; -- element à insérer
--précondition : l’arbre est initialiser 
--postcondition : noeud.all.gauche.all.element = valeur
procedure inserer_gauche(noeud : in out T_AB ; valeur : in t_element)
```

#### Raffinage
```
R0 : “inserer un noeud a gauche d’un noeud donné"
R1 : Comment “inserer un noeud a gauche d’un noeud donner” -- noeud : out T_AB; valeur : in T_element; 
    if noeud.all.gauche /= null then
        raise exception_insertion;
    else 
        assigner valeur à gauche
    end if; 
R2 : Comment “assigner valeur à gauche” -- noeud : out T_AB; valeur : in T_element; 
    noeud.all.gauche = new T_AB_Cell
noeud.all.gauche.all.element <- valeur
```

#### Inserer une valeur à droite

##### Specification
```ada
-- Nom : inserer_droite
-- sémantique : inserer un noeud a droite d’un noeud donner
--paramètres : 
    --noeud : in out T_AB -- noeud ou il faut insérer à droite    
    -- valeur : in T_element ; -- element à insérer
--précondition : l’arbre est initialiser 
--postcondition : noeud.all.droite.all.element = valeur
procedure inserer_droit(noeud : in out T_AB ; valeur : in t_element)
```

#### Rafinage
```
R0 : “inserer un noeud a droite d’un noeud donné"
R1 : Comment “inserer un noeud a droite d’un noeud donner” -- noeud : out T_AB; valeur : in T_element; 
    if noeud.all.gauche /= null then
        raise exception_insertion;
    else 
        assigner valeur à droite
    end if; 
R2 : Comment “assigner valeur à droite” -- noeud : out T_AB; valeur : in T_element; 
    noeud.all.droite = new T_AB_Cell
noeud.all.droite.all.element <- valeur
```


#### Calculer la taille 

##### Specification 
```ada
-- nom : calcul_taille
-- sémantique :  renvoie nombre de nœuds de l’arbre 
-- paramètres :
  -- arbre : in  T_AB -- Arbre dont on veut le nombre de nœuds
-- retour : integer --nombre nœud de l’arbre
-- pré-condition : 
-- post-condition : 
-- Tests de la procédure :
function calcul_taille(arbre : in T_AB) return integer;
```

##### Rafinage
```
R0 : calculer le  nombre de nœuds de l’arbre 
R1 : comment “calculer le  nombre de nœuds de l’arbre”  --arbre : in T_AB
ajouter le noeud courant + sosu arbre gauche + sous_arbre droit
R2 : comment “ajouter le noeud courant + sosu arbre gauche + sous_arbre droit”
  if(arbre = null) then
    return 0;
  else
    return 1+ calcul_taille(arbre.all.gauche) + calcul_taille(arbre.all.droite)
  end if;
```


#### Rechercher un noeud

##### Specification 
```ada
-- nom : rechercher
-- sémantique :  rechercher un noeud dans un arbre
-- paramètres : racine : in T_AB --l’arbre où on fait une recherche
  -- valeur : in T_element -- le noeud à rechercher
  -- arbre : in  T_AB -- Arbre dont on veut le nombre de nœuds
-- retour : T_AB -- le noeud
-- pré-condition : l’arbre est initialisé
-- post-condition : retourne le noeud ou null si le noeud existe pas
-- Tests de la procédure :
function rechercher(racine : in  T_AB ; valeur : in T_element) return T_AB
```

##### Rafinage 
```
R0 : ”rechercher un noeud dans un arbre”
R1 : comment “rechercher un noeud dans un arbre”  -- arbre : in  T_AB ; valeur : in 
  if(arbre =null or else arbre.all.element = valeur) then
    return arbre;
  end if;
  result := rechercher(arbre.all.gauche);
  if(result = null)
      result := rechercher (arbre.all.droite);
  end if;
  return result;
```

#### afficher arbre

##### Spécification 
```ada
-- nom : afficher
-- sémantique :  affiche un arbre  
-- paramètres :
  -- arbre : in  T_AB -- Arbre qu’on veut afficher
  -- profondeur : in integer -- Profondeur de cette arbre pour affichage (déterminé le décalage de l’arbre)
  -- etiquette_gauche : in string(0..10)  -- Étiquette pour la partie gauche 
  -- etiquette_droite : in string(0..10) -- Étiquette pour la partie droite
-- pré-condition : 
-- post-condition : 
-- Tests de la procédure :
procedure afficher(arbre : in T_AB; profondeur : in integer; ethiquette_gauche, etiquette_droite : in string(0..10))
```

##### Rafinage
```
R0 : “affiche un arbre”
R1 : Comment “affiche un arbre”  -- arbre : in  T_AB; profondeur : in integer; 
                                 -- etiquette_gauche : in string(0..10); 
                                 -- etiquette_droite : in string(0..10) 
  if(arbre = null) then raise arbre_exception; end if;
  afficher racine; 
  if(arbre.all.droite /= null )then 
    afficher sous arbre droit 
  end if;
  if(arbre.all.gauche /= null )then 
    afficher sous arbre gauche 
  end if;
R2 : Comment “afficher racine”  -- arbre : in  T_AB;        
  afficher_element(arbre.all.element);
  new_line;
R2 : Comment afficher sous arbres droite -- arbre : in  T_AB; profondeur : in integer; 
                                         -- etiquette_gauche : in string(0..10); 
                                         -- etiquette_droite : in string(0..10) 
  for i in 1..profondeur loop
    put(“   ”);
  end loop;
  put(etiquette_droite);
  put(“ : ”);
  afficher(arbre.all.droite, profondeur+1, etiquette_droite, etiquette_gauche)
R2 : Comment afficher sous arbres gauche -- arbre : in  T_AB; profondeur : in integer; 
                                         -- etiquette_gauche : in string(0..10); 
                                         -- etiquette_droite : in string(0..10) 
  for i in 1..profondeur loop
    put(“   ”);
  end loop;
  put(etiquette_gauche);
  put(“ : ”);
  afficher(arbre.all.gauche, profondeur+1, etiquette_droite, etiquette_gauche)

```


#### Supprimer élément

##### Spécification 
```ada
-- nom : supprimer
-- sémantique :  suprime un noeud de l’arbre 
-- paramètres :
  -- arbre : in  T_AB -- Arbre dont on veut suprimer un nœud
  -- element : in T_element -- Element à supprimer dans l’arbre
-- pré-condition : 
-- post-condition : 
-- Tests de la procédure :
procedure supprimer(arbre: in out T_AB;  element : in T_Element)
```

##### Raffinage 
```
R0 : suprimer un noeud de l’arbre 
R1 : comment “supprimer un noeud de l’arbre” -- arbre : in  T_AB; element : in T_element
  if(suprimer_rec(arbre, valeur) = false) then
    raise noeud_absent
  end if;
R2 : comment “supprimer récursivement le noeud et ses antécédents" aka "suprimer_rec"
          -- arbre : in  T_AB; element : in T_element
          -- return : boolean
  if(arbre=null) then
    return false;
  end if;
  if(arbre.all.gauche /= null and then arbre.all.gauche.all.element = valeur) then
    arbre.all.gauche:=null;
    return true;
  end if;
  if(arbre.all.droit /= null and then arbre.all.droit.all.element = valeur) then
    arbre.all.droit:=null;
    return true;
  end if;
  res := supprimer_rec(arbre.all.droit,valeur)
  if(not res) then 
    res := supprimer_rec(arbre.all.gauche, valeur);
  end if;
  return res;
```
#### Get Sous Arbre Droit 

```ada
--Nom : get_SA_droit
--sémantique : retourne le sous-arbre gauche d’un noeud
--paramètres : arbre : T_AB
--retour : T_AB
--préconditions : arbre/=null
--postconditions : null
function get_SA_droit(abre : T_AB) return T_AB;
```

#### Get Sous Arbre Gauche
```ada
--Nom : get_SA_gauche
--sémantique : retourne le sous-arbre droit d’un noeud
--paramètres :
  -- arbre : T_AB
  -- retour : T_AB
--préconditions : arbre/=null
--postconditions :
function  get_SA_gauche (arbre: T_AB) return  T_AB;
```
  
#### Get Racine Élément

```ada
--Nom : get_racine_element
--sémantique : retourne le sous-arbre droit d’un noeud
--paramètres :
  -- arbre : T_AB
  -- retour : T_AB
--préconditions : arbre/=null
--postconditions :
function  get_racine_element (arbre: T_AB) return  T_Element;
```

### Fonctions et procédures de ``T_Persone`` : 

#### Afficher

```ada
--Nom : put
--sémantique : affiche les informations d’une personne
--paramètres : perso : in  T_personne
--préconditions : 
--postconditions : 
procedure put(p:T_Person);
```

#### Comparaison 

```ada
--Nom : "="
--sémantique : compare les identifiants des personnes
--paramètres :
  -- o1 : in T_Persone
  -- o2 : in T_Persone 
-- retour : boolean
--préconditions : 
  -- o1.id /= 0
  -- o2.id /= 0
--postconditions : null
function "="(o1, o2) return boolean;
```
#### Initialisation

```ada
--Nom : init
--sémantique : initialise personne avec un nom et prenom 
--paramètres :
-- persone : out T_Persone
--  nom : string
-- prenom : string
--préconditions : 
--postconditions : id/=0

```
#### Getter 
```ada
--Nom : get_id 
--sémantique : retourne l’id de la persone
--paramètres :
-- persone : in T_Persone
-- retour : integer
--préconditions : id/=0
--postconditions : 
function get_id(personne : in T_Personne) return integer;
```
```ada
--Nom : get_nom
--sémantique : retourne le nom de la persone
--paramètres :
-- persone : in T_Persone
-- retour : string
--préconditions : id/=0
--postconditions : 
function get_nom(personne : in T_Personne) return string;
```

```ada
--Nom : get_prenom
--sémantique : retourne le prenom de la persone
--paramètres :
-- persone : in T_Persone
-- retour : string
--préconditions : id/=0
--postconditions : 
function get_prenom(personne : in T_Personne) return string;
```

#### Getter 

```ada
--Nom : set_nom
--sémantique : attribuer une valeur au champ nom
--paramètres : personne :  in out T_personne
--        nom : in string
--préconditions : id/=0
--postconditions : personne.nom= nom
procedure set_nom(personne : in out T_personne ; nom : string);
```
```ada
 --Nom : set_prenom
--sémantique : attribuer une valeur au champ prenom
--paramètres : personne : T_personne
--        prenom : string
--préconditions : id/=0
--postconditions : personne.nom= nom
procedure set_prenom(personne : in out T_personne ; prenom : string);
```
```ada
-- Nom : nextid
--sémantique : renvoi un nouveau id unique
--préconditions : null
--postconditions : retourne l’id prochain
function nextid() return Integer;
```
```ada
--Nom : lastid
--sémantique : renvoi l’id dernièrement utiliser;
--préconditions : 
--postconditions : retourne l’id dernier
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc4NDYzNjI0NiwtNjEzMzE2MjU0LDIwMz
M4ODkwNzYsLTEwMzg5NzU4NzAsMTg4NzU5OTUxLC0xMzMzOTgw
NTkwLC0xOTQ0NDQ0NDgzLDE0ODM3MzgyMzAsLTEyNzgxMTQ1NS
w3ODY3MDUyMTFdfQ==
-->