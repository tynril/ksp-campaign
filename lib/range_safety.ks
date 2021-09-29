// #include "0:/lib/lib.ks"

@LAZYGLOBAL OFF.

DECLARE GLOBAL FUNCTION range_safety {
    Core:Part:GetModule("ModuleRangeSafety"):DoAction("Range Safety", true).
}
