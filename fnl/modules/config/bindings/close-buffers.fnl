(import-macros {: map! : let!} :macros)
(local {: setup} (require :core.lib.setup))
(local {: autoload} (require :core.lib.autoload))
(local close-buffers (autoload :close_buffers))

(setup :close_buffers {;; Filetype to ignore when running deletions
                       :filetype_ignore []
                       ;; File name glob pattern to ignore when running deletions (e.g. '*.md')
                       :file_glob_ignore []
                       ;; File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
                       :file_regex_ignore []
                       ;; Types of deletion that should preserve the window layout
                       :preserve_window_layout [:this :nameless]
                       ;; Custom function to retrieve the next buffer when preserving window layout
                       :next_buffer_cmd nil})

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

(map! [n] :<leader>ba "<cmd>BDelete all<cr>" {:desc "Delete all buffers"})
(map! [n] :<leader>bd "<cmd>BDelete this<cr>" {:desc "Delete buffer"})
(map! [n] :<leader>bh "<cmd>BDelete! hidden<cr>"
      {:desc "Delete hidden buffers"})

(map! [n] :<leader>bo "<cmd>BDelete! other<cr>" {:desc "Delete other buffers"})
