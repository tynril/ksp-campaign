// We still need a manual list for the auto-completion.
// #include "./chute.ks"
// #include "./countdown.ks"
// #include "./find_parts.ks"
// #include "./target_altitude.ks"

@LAZYGLOBAL OFF.

// Find the list of library files to include automatically.
DECLARE LOCAL previousPath TO PATH().
CD("0:/lib").

DECLARE LOCAL libraryFiles TO "".
LIST FILES IN libraryFiles.

// Include all library files (but this one).
FOR libraryFile IN libraryFiles {
    IF libraryFile <> "lib.ks" {
        RUNPATH(libraryFile).
    }
}

// Restore our previous location.
CD(previousPath).
