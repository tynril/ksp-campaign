// We still need a manual list for the auto-completion.
// #include "0:/lib/chute.ks"
// #include "0:/lib/countdown.ks"
// #include "0:/lib/find_parts.ks"
// #include "0:/lib/math.ks"
// #include "0:/lib/range_safety.ks"
// #include "0:/lib/target_altitude.ks"

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
