with p_personne; use p_personne;
with p_arbre_binaire;
with p_linked_list;

package p_arbre_genealogique is
    
    package p_AB_Person is new p_arbre_binaire(T_Personne, "=", put);use p_AB_Person;
    type T_AG is new p_AB_Person.T_AB;

    package List_Personne is new p_linked_list(T_Personne, put); use List_Personne;
    type L_Personne is new List_Personne.T_linked_list;
    

    type E_Parent is (PERE,MERE);

    --Nom :ajout_parent
    --sémantique : ajouter un parent à un noeud donné
    --paramètres : 
    --  arbre : T_AG; 
    --  parent : E_Parent
    --  fils : Integer
    --  parent  : T_personne
    --préconditions : arbre /=null && fils > 0 && noeud est dans l'arbre
    --postconditions :  person apartient
    procedure ajout_parent(arbre : T_AG; parent : E_Parent; fils : in Integer; person : in T_Personne) with
    pre => not is_null(arbre) and then fils > 0;


    --Nom : nombre_ancetre
    --sémantique : retourne le compte des ancêtres d’un individue
    --paramètres :
    --  arbre : T_AG
    --  individu : Integer 
    --retour : integer
    --préconditions : arbre/=null && individu apartien a l'arbre 
    --postconditions : 
    function nombre_ancetres(arbre : in T_AG; individu : in Integer) return integer with 
    pre => not is_null(arbre);


    --Nom : get_ancetre_generation
    --sémantique : retourne la liste des ancêtres d’une certaine generation d’un individue
    --paramètres :
    --  arbre : T_AG
    --  individu : integer 
    --  generation : integer
    --retour : List<T_Personne>
    --préconditions : arbre/=null && individu apartien a l'arbre 
    --postconditions : 
    function get_ancetre_generation(arbre : in T_AG; individu, generation : in integer) return L_Personne with
    pre => not is_null(arbre);

    --nom : afficher
    --sémantique :  affiche un arbre genealogique  
    --paramètres :
    --  arbre : in  T_AG -- Arbre qu’on veut afficher
    --pré-condition : arbre initialisé
    --post-condition : 
    procedure afficher(arbre : in T_AG) with
    pre => not is_null(arbre);

    --nom : afficher
    --sémantique :  affiche un arbre genealogique  
    --paramètres :
    --  arbre : in  T_AG -- Arbre qu’on veut afficher
    --  id: in integer -- id du noeud a partir duquel on veut commencer 
    --pré-condition : arbre initialisé
    --post-condition : 
    procedure afficher(arbre : in T_AG; individu : in integer) with
    pre => not is_null(arbre);

    --Nom : get_un_parent
    --sémantique : retourne la liste des individus ayant un seul parent
    --paramètres :
    --  arbre : T_AG
    --retour : List<T_Personne>
    --préconditions : arbre/=null
    --postconditions : 
    function get_un_parent(arbre : in T_AG) return L_Personne with
    pre => not is_null(arbre);

    --Nom : get_deux_parent
    --sémantique : retourne la liste des individus ayant deux parents
    --paramètres :
    --  arbre : T_AB
    --retour : List<T_Personne>
    --préconditions : arbre/=null
    --postconditions : 
    function get_deux_parent(arbre : in T_AG) return L_Personne with
    pre => not is_null(arbre);

    --Nom : get_zero_parent
    --sémantique : retourne la liste des individus ayant aucun parents
    --paramètres :
    --  arbre : T_AG
    --retour : List<T_Personne>;
    --préconditions : arbre/=null
    --postconditions : 
    function get_zero_parent(arbre : in T_AG) return L_Personne with
    pre => not is_null(arbre);

    --Nom : get_succession_ancetre_generation
    --sémantique : retourne la liste des ancêtres d’un individue
    --paramètres :
    --  arbre : in T_AG
    --  individu : in T_Persone 
    --  generation :  in integer
    --retour : resultat_arbre : T_AB
    --préconditions : arbre/=null && individu appartient a arbre
    --postconditions :
    function get_succession_ancetre_generation(arbre : in T_AG; individu, generation : in integer) return T_AG with
    pre => not is_null(arbre);

    --Nom : get_descendant_generation
    --sémantique : retourne le descendant de n-ieme generation d’un individue
    --paramètres :
    --  arbre : T_AG
    --  personne : id 
    --  generation : integer
    --retour : T_Personne
    --préconditions : arbre/=null  && persone appartient a arbre
    --postconditions : 
    function  get_decendant_generation(arbre : in T_AG; persone : in integer; generation : integer) return T_Personne with
    pre => not is_null(arbre);

    --Nom :  get_sucession_decendant_generation
    --sémantique : --paramètres : retourne la liste des decendant  d’un individu
    --  arbre : T_AG
    --  persone : T_Persone 
    --  generation : integer
    --retour : List<T_Personne>
    --préconditions : arbre/=null  && persone appartient a arbre
    --postconditions : 
    function get_sucession_decendant_generation(arbre : in T_AG; persone : in integer; generation : integer) return L_Personne with
    pre => not is_null(arbre);

private
end p_arbre_genealogique;