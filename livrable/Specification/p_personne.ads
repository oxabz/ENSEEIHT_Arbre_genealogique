with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package P_Personne is
    type T_Personne is private;

    --Nom : init
    --sémantique : initialise personne avec un nom et prenom 
    --paramètres :
    --  persone : out T_Persone
    --  nom : string
    --  prenom : string
    --préconditions : 
    --postconditions : person.id>0
    procedure init (persone : out T_Personne; nom,prenom : in unbounded_string) with 
    post => get_id(persone) > 0 ;

    --Nom : get_id 
    --sémantique : retourne l’id de la persone
    --paramètres :
    --  persone : in T_Persone
    --  retour : integer
    --préconditions : 
    --postconditions : return > 0
    function get_id(personne : in T_Personne) return integer with 
    post => get_id'result > 0 ;

    --Nom : get_nom
    --sémantique : retourne le nom de la persone
    --paramètres :
    --  persone : in T_Persone
    --  retour : string
    --préconditions : id/=0
    --postconditions : 
    function get_nom(personne : in T_Personne) return unbounded_string  with 
    pre => get_id(personne) > 0;

    --Nom : get_prenom
    --sémantique : retourne le prenom de la persone
    --paramètres :
    --  persone : in T_Persone
    --  retour : string
    --préconditions : id/=0
    --postconditions : 
    function get_prenom(personne : in T_Personne) return unbounded_string with 
    pre => get_id(personne) > 0;

    --Nom : set_nom
    --sémantique : attribuer une valeur au champ nom
    --paramètres : personne :  in out T_personne
    --        nom : in string
    --préconditions : id/=0
    --postconditions : personne.nom= nom
    procedure set_nom(personne : in out T_Personne ; nom : unbounded_string)with 
    pre => get_id(personne) > 0;

    --Nom : set_prenom
    --sémantique : attribuer une valeur au champ prenom
    --paramètres : personne : T_personne
    --        prenom : string
    --préconditions : id/=0
    --postconditions : personne.nom= nom
    procedure set_prenom(personne : in out T_Personne ; prenom : unbounded_string)with 
    pre => get_id(personne) > 0;


    --Nom : put
    --sémantique : affiche les informations d’une personne
    --paramètres : perso : in  T_personne
    --préconditions : 
    --postconditions : 
    procedure put(p:T_Personne);

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
    function "="(o1, o2 : in T_Personne) return boolean with 
    pre => get_id(o1) > 0 and get_id(o2) > 0;

    function get_dummy (id: in integer) return T_Personne;

private
    id_counter : integer := 0;

    type T_Personne is record
       id:integer;
       nom:unbounded_string;
       prenom:unbounded_string;
    end record;

    -- Nom : nextid
    --sémantique : renvoi un nouveau id unique
    --préconditions : null
    --postconditions : retourne l’id prochain
    function next_id return Integer;
end P_Personne;