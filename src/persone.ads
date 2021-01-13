with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Persone is
    type T_person is private;

    --Nom : init
    --sémantique : initialise personne avec un nom et prenom 
    --paramètres :
    --  persone : out T_Persone
    --  nom : string
    --  prenom : string
    --préconditions : 
    --postconditions : id/=0
    procedure init (persone : out T_person; nom,prenom : in unbounded_string);

    --Nom : get_id 
    --sémantique : retourne l’id de la persone
    --paramètres :
    --  persone : in T_Persone
    --  retour : integer
    --préconditions : id/=0
    --postconditions : 
    function get_id(personne : in T_Person) return integer;

    --Nom : get_nom
    --sémantique : retourne le nom de la persone
    --paramètres :
    --  persone : in T_Persone
    --  retour : string
    --préconditions : id/=0
    --postconditions : 
    function get_nom(personne : in T_Person) return unbounded_string;

    --Nom : get_prenom
    --sémantique : retourne le prenom de la persone
    --paramètres :
    --  persone : in T_Persone
    --  retour : string
    --préconditions : id/=0
    --postconditions : 
    function get_prenom(personne : in T_Person) return unbounded_string;

    --Nom : set_nom
    --sémantique : attribuer une valeur au champ nom
    --paramètres : personne :  in out T_personne
    --        nom : in string
    --préconditions : id/=0
    --postconditions : personne.nom= nom
    procedure set_nom(personne : in out T_person ; nom : unbounded_string);

    --Nom : set_prenom
    --sémantique : attribuer une valeur au champ prenom
    --paramètres : personne : T_personne
    --        prenom : string
    --préconditions : id/=0
    --postconditions : personne.nom= nom
    procedure set_prenom(personne : in out T_person ; prenom : unbounded_string);


    --Nom : put
    --sémantique : affiche les informations d’une personne
    --paramètres : perso : in  T_personne
    --préconditions : 
    --postconditions : 
    procedure put(p:T_Person);

    --Nom : "="
    --sémantique : compare les identifiants des personnes
    --paramètres :
    --  o1 : in T_Persone
    --  o2 : in T_Persone 
    --  retour : boolean
    --préconditions : 
    --  o1.id /= 0
    --  o2.id /= 0
    --postconditions : null
    function "="(o1, o2 : in T_Person) return boolean;

    function get_dummy (id: in integer) return T_person;

private
    id_counter : integer := 0;

    type T_person is record
       id:integer;
       nom:unbounded_string;
       prenom:unbounded_string;
    end record;

    -- Nom : nextid
    --sémantique : renvoi un nouveau id unique
    --préconditions : null
    --postconditions : retourne l’id prochain
    function next_id return Integer;
end Persone;