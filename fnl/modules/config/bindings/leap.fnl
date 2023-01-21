(import-macros {: map! : let!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local leap (autoload :leap))
(local leap-ast (autoload :leap-ast))

(setup :leap {:opts {:case_sensitive false
                     :highlight_unlabeled_phase_one_targets true}})

(let! mapleader " ")
(leap.add_default_mappings)

(map! [nxo] :gs leap-ast.leap {:desc "leap AST"})

(setup :flit)
