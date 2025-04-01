
open Camlimages
open Images

(* Function to extract RGB coefficients from an RGB24 image *)
let extract_rgb (image : Rgb24.t) =
  let width = image.Rgb24.width in
  let height = image.Rgb24.height in
  for y = 0 to height - 1 do
    for x = 0 to width - 1 do
      let r, g, b = (Rgb24.get image x y).r, (Rgb24.get image x y).g, (Rgb24.get image x y).b in
      Printf.printf "(%d, %d, %d) " r g b
    done;
    print_newline ()
  done

(* Load the JPEG image and convert it to RGB24 *)
let () =
  if Array.length Sys.argv <> 2 then
    Printf.eprintf "Usage: %s <image.jpeg>\n" Sys.argv.(0)
  else
    let filename = Sys.argv.(1) in
    match Images.load filename [] with
    | Images.Index8 img -> extract_rgb (Index8.to_rgb24 img)
    | Images.Index16 img -> extract_rgb (Index16.to_rgb24 img)
    | Images.Rgb24 img -> extract_rgb img
    (*| Images.Rgba32 img -> extract_rgb (Rgba32.to_rgb24 img)*)
    | Images.Rgba32 _ -> Printf.eprintf "Error: CMYK images are not supported.\n"
    | Images.Cmyk32 _ -> Printf.eprintf "Error: CMYK images are not supported.\n"