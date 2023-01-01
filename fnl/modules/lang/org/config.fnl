(local {: setup} (require :core.lib.setup))

(setup :headlines {:org {:headline_highlights false}})
(setup :org-bullets {:concealcursor true})
(setup :orgmode {:org_default_notes_file "~/org/refile.org"
                 :org_agenda_files ["~/org/**/*"]})

((. (require :orgmode) :setup_ts_grammar) {})
