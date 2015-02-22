module Common : sig
  val base_uri : string

  exception Invalid_href

  type mode = [ `album | `artist | `track ]

  val string_of_mode : mode -> string

  val check_href : mode -> string -> unit

  val read_uri : Uri.t -> (string -> 'a) -> 'a Lwt.t
end

module Search : sig
  val search_albums: string -> Album_t.search Lwt.t
  val search_artists: string -> Artist_t.search Lwt.t
  val search_tracks: string -> Track_t.search Lwt.t
end
