val base_uri : string

exception Invalid_href

type mode = [ `album | `artist | `track ]

val string_of_mode : mode -> string

val check_href : mode -> string -> unit

val read_uri : Uri.t -> (string -> 'a) -> 'a Lwt.t
