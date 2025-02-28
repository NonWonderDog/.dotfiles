; extends

; /*[[[cog
; ]]]*/
((comment) @injection.content
           (#match? @injection.content "^/\\*\\[\\[\\[cog")
           (#offset! @injection.content 1 0 -1 -1)
           (#set! injection.language "python")
           )
