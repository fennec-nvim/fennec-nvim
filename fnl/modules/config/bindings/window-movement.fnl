(import-macros {: map! : let!} :macros)
(local {: setup} (require :core.lib.setup))
(local {: autoload} (require :core.lib.autoload))

(local windex (autoload :windex))

(setup :windex {:default_keymaps false})

;; TODO: add maximized status with windex to modeline

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

;; I have <C-);> happed to <C-h> on my keyboard since terminals don't recognize <C-;> as an actual thing
(map! [n] :<C-l> #(windex.switch_window :left) {:desc "switch window left"})
(map! [n] :<C-j> #(windex.switch_window :down) {:desc "switch window down"})
(map! [n] :<C-k> #(windex.switch_window :up) {:desc "switch window up"})
(map! [n] :<C-h> #(windex.switch_window :right) {:desc "switch window right"})

;; Move focus)
(map! [n] :<leader>wl #(windex.switch_window :left)
      {:desc "switch window left"})

(map! [n] :<leader>wj #(windex.switch_window :down)
      {:desc "switch window down"})

(map! [n] :<leader>wk #(windex.switch_window :up) {:desc "switch window up"})
(map! [n] "<leader>w;" #(windex.switch_window :right)
      {:desc "switch window right"})

(map! [n] :<leader>wS #(windex.create_pane :horizontal)
      {:desc "split tmux pane"})

(map! [n] :<leader>wV #(windex.create_pane :vertical)
      {:desc "vsplit tmux pane"})

(map! [n] :<leader>wz windex.toggle_maximize {:desc "maximize window"})
