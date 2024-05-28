;==============================================================================
; macros.inc - useful macros that increase readability
;==============================================================================

;==============================================================================
; smov - an automatically optimizing 'mov' instruction
;
; while the utility is incredibly helpful at times,
; the ultimate purpose is to have readable source code
; without sacrificing small, performant binaries.
; 
; It shoud be used where it makes sense, as it takes longer to assemble
; relative to a standard 'mov' instruction
;==============================================================================
%macro smov 2
    %if %2 == 0
        xor %1, %1
    %else
        mov %1, %2
    %endif
%endmacro
