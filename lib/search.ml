open Lwt

let search mode query parse_fn =
  let open Cohttp_lwt_unix_io in
  let uri = Uri.of_string
    (Printf.sprintf "%s/search?type=%s&q=%s"
      Common.base_uri (Common.string_of_mode mode) query)
  in
  Common.read_uri uri parse_fn

let search_albums query =
  search `album query Types_j.album_search_wrapper_of_string
  >|= (fun wrapper -> wrapper.Types_t.albums)

let search_artists query =
  search `artist query Types_j.artist_search_wrapper_of_string
  >|= (fun wrapper -> wrapper.Types_t.artists)

let search_tracks query =
  search `track query Types_j.track_search_wrapper_of_string
  >|= (fun wrapper -> wrapper.Types_t.tracks)
