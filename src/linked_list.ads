generic
  type T is private;
  with procedure afficher (X: in T);
package linked_list is
  type T_linked_list_cell is private;
  type T_linked_list is access T_linked_list_cell;


  procedure init(list : out T_linked_list);
  function isEmpty(list : in T_linked_list)return boolean;
  function getHead(list : in T_linked_list) return T;
  procedure insertHead(list : in out T_linked_list; e : in T)with
    post=> getHead(list) = e;
  procedure put(list : in T_linked_list);
  function find(list : in T_linked_list; e :in T) return T_linked_list;
  procedure insertAfter(list : in out T_linked_list; d,e : in T)with
    post=> not isEmpty(find(list,e));
  procedure insertBefore(list : in out T_linked_list; d,e : in T)with
    post=> not isEmpty(find(list,e));
  procedure remove(list : in out T_linked_list; e :in T)with
    post=> isEmpty(find(list,e));
  private
  type T_linked_list_cell is record
    value: T;
    next: T_linked_list;
  end record;
end linked_list;
