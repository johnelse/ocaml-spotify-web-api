open Lwt

let search mode query parse_fn =
  let uri = Uri.of_string
    (Printf.sprintf "%s/search?type=%s&q=%s"
      Common.base_uri (Common.string_of_mode mode) query)
  in
  Common.read_uri uri parse_fn

let search_albums query =
  search `album query Album_j.search_wrapper_of_string
  >|= (fun wrapper -> wrapper.Album_t.albums)

let search_artists query =
  search `artist query Artist_j.search_wrapper_of_string
  >|= (fun wrapper -> wrapper.Artist_t.artists)

let search_tracks query =
  search `track query Track_j.search_wrapper_of_string
  >|= (fun wrapper -> wrapper.Track_t.tracks)
