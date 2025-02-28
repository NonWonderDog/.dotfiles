; extends

; /*[[[cog
; ]]]*/
((comment) @injection.content
           (#match? @injection.content "^/\\*\\[\\[\\[cog")
           (#offset! @injection.content 1 0 0 -5)
           (#set! injection.language "python"))
