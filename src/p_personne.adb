with Ada.Strings; use Ada.Strings;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;


package body P_Personne is

    --Nom : init
    --sémantique : initialise personne avec un nom et prenom 
    --paramètres :
    --  persone : out T_Persone
    --  nom : string
    --  prenom : string
    --préconditions : 
    --postconditions : id/=0
    procedure init (persone : out T_Personne; nom,prenom : in unbounded_string)is

    begin
        persone.id := next_id;
        persone.nom := nom;
        persone.prenom := prenom;
    end init;

    --Nom : get_id 
    --sémantique : retourne l’id de la persone
    --paramètres :
    --  persone : in T_Persone
    --  retour : integer
    --préconditions : id/=0
    --postconditions : 
    function get_id(personne : in T_Personne) return integer is

    begin
        return personne.id;
    end get_id;

    --Nom : get_nom
    --sémantique : retourne le nom de la persone
    --paramètres :
    --  persone : in T_Persone
    --  retour : string
    --préconditions : id/=0
    --postconditions : 
    function get_nom(personne : in T_Personne) return unbounded_string is

    begin
        return personne.nom;
    end get_nom;

    --Nom : get_prenom
    --sémantique : retourne le prenom de la persone
    --paramètres :
    --  persone : in T_Persone
    --  retour : string
    --préconditions : id/=0
    --postconditions : 
    function get_prenom(personne : in T_Personne) return unbounded_string is

    begin
        return personne.prenom;
    end get_prenom;

    --Nom : set_nom
    --sémantique : attribuer une valeur au champ nom
    --paramètres : 
    --  personne :  in out T_personne
    --  nom : in string
    --préconditions : id/=0
    --postconditions : personne.nom= nom
    procedure set_nom(personne : in out T_Personne ; nom : unbounded_string) is
    begin 
        personne.nom := nom;
    end set_nom;

    --Nom : set_prenom
    --sémantique : attribuer une valeur au champ prenom
    --paramètres : personne : T_personne
    --        prenom : string
    --préconditions : id/=0
    --postconditions : personne.nom= nom
    procedure set_prenom(personne : in out T_Personne ; prenom : unbounded_string) is
    begin 
        personne.prenom := prenom;
    end set_prenom;

    -- Nom : nextid
    --sémantique : renvoi un nouveau id unique
    --préconditions : null
    --postconditions : retourne l’id prochain
    function next_id return Integer is
    begin
        id_counter := id_counter + 1;
        return id_counter;
    end next_id;

    --Nom : put
    --sémantique : affiche les informations d’une personne
    --paramètres : perso : in  T_personne
    --préconditions : 
    --postconditions : 
    procedure put(p: in T_Personne)is 
    begin
        put("[");
        put(trim(source=>To_Unbounded_String(integer'image(p.id)), Side=>Both));
        put("] ");
        put(p.nom);
        put(" ");
        put(p.prenom);
    end put;

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
    function "="(o1, o2 : in T_Personne) return boolean is
    begin
        return o1.id = o2.id;
    end "=";

    function get_dummy (id: in integer) return T_Personne is
        p : T_Personne;
    begin 
        p.id := id;
        return p;
    end get_dummy;

end P_Personne;