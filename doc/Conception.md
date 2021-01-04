# Conception du projet 

## Types de donées

### Arbre Binaire 

Nous allons avoir besoint d'un arbre binaire generique de donnés non trié afin de representer l'arbre genealogique

Pour ce faire il nous faut trois types :
- ``T_Element`` un type generique.
- ``T_AB`` Un pointeur vers une ``T_AB_Cell``
- ``T_AB_Cell`` Un record qui est une cellule d'arbre : 
```
- gauche : T_AB
- droite : T_AB
- valeur : T_Element
```


### Personnes 

Nous allons vouloir representer des individues. Pour ce faire on utilisera un type record ``T_Personne`` :
```
- Identifiant : integer
- nom : string(20)
- prenom : string(20)
... <Tout autre info sur un individu>
```

### Arbre Genealogique 

Nous allons vouloir faire un arbre généalogique. On peut se servir de l'arbre binaire precedement créé pour faire notre arbre genalogique.
On va avoir `` T_AG`` qui sera une instanciation de ``T_AB`` avec ``T_Element`` qui est ``T_Personne``


## Fonctions Et Procedures


### Fonctions et procedures de ``T_AB`` : 

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

#### Rafinage

### Fonctions et procedures de ``T_Persone`` : 


### Fonctions et procedures de ``T_AG`` : 
