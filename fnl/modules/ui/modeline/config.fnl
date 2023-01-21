(import-macros {: set! : vlua : autocmd! : packadd!} :macros)
(local {: contains? : str? : table?} (require :core.lib))
(local {: setup} (require :core.lib.setup))
(local {: autoload} (require :core.lib.autoload))
(local {: blend-hex} (require :core.lib.color))
(local {: filesize} (require :core.lib.filesize))
(local {: git-icons : diagnostic-icons : modeline-icons} (require :core.shared))

(local base00 "#161616")
(local base06 "#ffffff")
(local colors {: base00
               :base01 (blend-hex base00 base06 0.085)
               :base02 (blend-hex base00 base06 0.18)
               :base03 (blend-hex base00 base06 0.3)
               :base04 (blend-hex base00 base06 0.82)
               :base05 (blend-hex base00 base06 0.95)
               : base06
               :base07 "#08bdba"
               :base08 "#3ddbd9"
               :base09 "#78a9ff"
               :base10 "#ee5396"
               :base11 "#33b1ff"
               :base12 "#ff7eb6"
               :base13 "#42be65"
               :base14 "#be95ff"
               :base15 "#82cfff"
               :blend "#131313"
               :none :NONE})

;; TODO: add better documentation for modeline module
;; TODO: fix flicker when opening Telescope buffers

(lambda buf-filetype? [filetypes]
  (assert (or (table? filetypes) (str? filetypes))
          "Argument to function `buf-filetype?` must be a list or a string.")
  (if (table? filetypes) (contains? filetypes vim.bo.filetype)
      (str? filetypes) (contains? [filetypes] vim.bo.filetype)))

(lambda buf-new-file? []
  (local filename (vim.fn.expand "%"))
  (and (not= filename "") (= vim.bo.buftype "")
       (= (vim.fn.filereadable filename) 0)))

(lambda buf-unnamed? []
  (= (vim.fn.expand "%") ""))

(local components {})
(tset components :gutter {1 (lambda []
                              git-icons.gutter)
                          :padding {:left 0 :right 0}
                          :color {:fg (. colors :base12)}
                          :cond nil})

(tset components :mode
      {1 (lambda []
           (.. " " modeline-icons.evil " "))
       :padding {:left 0 :right 0}
       :color []
       :cond #(not (buf-filetype? :alpha))})

(tset components :search-count
      {1 (lambda []
           (when (= vim.v.hlsearch 0)
             (lua "return \"\""))
           (local (ok count) (pcall vim.fn.searchcount {:recompute true}))
           (when (or (or (not ok) (= count.current nil)) (= count.total 0))
             (lua "return \"0/0\""))
           (when (= count.incomplete 1)
             (lua "return \"?/?\""))
           (local too-many (: ">%d" :format count.maxcount))
           (local total (or (and (> count.total count.maxcount) too-many)
                            count.total))
           (: "%s/%s" :format count.current total))
       :color {:fg (. colors :base00) :bg (. colors :base08)}
       :cond #(not (buf-filetype? [:alpha :TelescopePrompt]))})

(tset components :buf-size
      {1 (fn []
           (filesize (. (vim.fn.wordcount) :bytes) {:round 1}))
       :color {:fg (. colors :base06)}
       :cond #(not (buf-filetype? [:alpha :TelescopePrompt]))})

(tset components :buf-modified
      {1 (lambda []
           (var fg (. colors :base09))
           (var mod "")
           (when vim.bo.modified
             (set fg (. colors :base10))
             (set mod modeline-icons.save))
           (when (not vim.bo.modifiable)
             (set fg (. colors :base10))
             (set mod modeline-icons.lock))
           (when (buf-new-file?)
             (set fg (. colors :base07))
             (set mod modeline-icons.new-file))
           (when (buf-unnamed?)
             (set fg (. colors :base07))
             (set mod modeline-icons.checkbox-blank))
           (when (buf-filetype? :alpha)
             (set fg (. colors :base12))
             (set mod modeline-icons.evil))
           (vim.cmd (.. "hi! lualine_filename_status gui=bold guifg=" fg))
           mod)
       :color :lualine_filename_status
       :cond #(not (buf-filetype? :TelescopePrompt))})

(tset components :dir {1 (lambda []
                           (.. (vim.fn.expand "%:p:h:t") "/"))
                       :padding {:left 1 :right 0}
                       :color :lualine_filename_status})

(tset components :filename {1 :filename
                            :fmt (lambda [filename context]
                                   (if (buf-unnamed?) "" filename))
                            :file_status false
                            :color {:gui :bold}
                            :cond nil
                            :padding {:left 0 :right 0}
                            :color {:gui :bold}})

(tset components :branch
      {1 "b:gitsigns_head"
       :icon git-icons.branch
       :color {:gui :bold :fg (. colors :base09)}})

(lambda diff-source []
  (local gitsigns vim.b.gitsigns_status_dict)
  (when vim.b.gitsigns_status_dict
    {:added gitsigns.added
     :modified gitsigns.changed
     :removed gitsigns.removed}))

(tset components :diff {1 :diff
                        :source diff-source
                        :symbols {:added (.. git-icons.bold-added " ")
                                  :modified (.. git-icons.bold-modified " ")
                                  :removed (.. git-icons.bold-removed " ")}
                        :padding {:left 2 :right 1}})

(tset components :diagnostics
      {1 :diagnostics
       :sources [:nvim_diagnostic]
       :symbols {:error (.. diagnostic-icons.bold-error " ")
                 :warn (.. diagnostic-icons.bold-warning " ")
                 :info (.. diagnostic-icons.bold-info " ")
                 :hint (.. diagnostic-icons.bold-hint " ")}})

(tset components :lsp
      {1 (lambda [msg]
           (var msg (or msg "LS Inactive"))
           (local buf-clients (vim.lsp.buf_get_clients))
           (if (= (next buf-clients) nil)
               (when (or (= (type msg) :boolean) (= #msg 0))
                 "LS Inactive")
               msg)
           (local buf-ft vim.bo.filetype)
           (local buf-client-names {})
           (each [_ client (pairs buf-clients)]
             (when (and (not= client.name :null-ls) (not= client.name :copilot))
               (table.insert buf-client-names client.name)))
           ;; TODO: docstring for list-registered-providers-names
           (lambda list-registered-providers-names [filetype]
             "Doc string for list-registered-providers-names."
             (local s (require :null-ls.sources))
             (local available-sources (s.get_available filetype))
             (local registered {})
             (each [_ source (ipairs available-sources)]
               (each [method (pairs source.methods)]
                 (tset registered method (or (. registered method) {}))
                 (table.insert (. registered method) source.name)))
             registered)
           ;; TODO: docstring for list-registered
           (lambda list-registered [filetype method]
             (local registered-providers
                    (list-registered-providers-names filetype))
             (or (. registered-providers method) {}))
           (local supported-formatters
                  (list-registered buf-ft :NULL_LS_FORMATTING))
           (local supported-linters
                  (list-registered buf-ft :NULL_LS_DIAGNOSTICS))
           (vim.list_extend buf-client-names supported-formatters)
           (vim.list_extend buf-client-names supported-linters)
           (local uniq-client-names (vim.fn.uniq buf-client-names))
           (local language-servers
                  (.. "[" (table.concat uniq-client-names ", ") "]"))
           language-servers)
       :color {:gui :bold}
       :cond #(not (buf-filetype? [:alpha :TelescopePrompt]))})

(tset components :spaces
      {1 (lambda []
           (local shiftwidth (vim.api.nvim_buf_get_option 0 :shiftwidth))
           (.. modeline-icons.tab " " shiftwidth))})

(tset components :filetype
      {1 :filetype
       :fmt (lambda [filetype context]
              (set context.options.icons_enabled false)
              (if (buf-filetype? [:alpha])
                  (do
                    (set context.options.icons_enabled false)
                    "fennec v0.0.1-dev")
                  (do
                    (set context.options.icons_enabled true)
                    filetype)))
       :cond nil
       ;; :color {:fg (. colors :base14)}
       :padding {:left 1 :right 1}})

(tset components :location
      {1 :location :cond #(not (buf-filetype? [:alpha :TelescopePrompt]))})

(tset components :progress {1 :progress
                            :fmt (lambda []
                                   "%P")
                            ;; "%P/%L")
                            :cond #(not (buf-filetype? [:alpha
                                                        :TelescopePrompt]))
                            :color {}})

(set! laststatus 3)
(set! cmdheight 1)

;; TODO: figure out how to only show visual and visual-block mode
(tset components :showcmd
      {1 (. (require :noice) :api :status :command :get)
       :cond (. (require :noice) :api :status :command :has)
       :color {:fg (. colors :base14)}})

;; TODO: figure out how to show this on VimEnter or find better integration between lazy and alpha
(lambda get-startup-time []
  (let [stats ((. (require :lazy) :stats))
        ms (/ (math.floor (+ (* stats.startuptime 100) 0.5)) 100)]
    `,ms))

(tset components :lazy-stats {1 get-startup-time
                              :fmt (fn [output context]
                                     (.. " " output :ms))
                              :cond #(buf-filetype? :alpha)
                              :color []})

(setup :lualine
       {:sections {:lualine_a [components.gutter
                               components.mode
                               components.search-count
                               components.buf-size]
                   :lualine_b [components.buf-modified
                               components.dir
                               components.filename]
                   :lualine_c [components.location
                               components.progress
                               components.lazy-stats
                               components.showcmd]
                   :lualine_x [components.diagnostics components.lsp]
                   :lualine_y [components.filetype]
                   :lualine_z [components.branch]}
        :options {:component_separators {:left "" :right ""}
                  :section_separators {:left "" :right ""}
                  :theme {:normal {:a {:fg colors.base12 :bg colors.blend}
                                   :b {:bg colors.blend}
                                   :c {:bg colors.blend}}
                          :insert {:a {:fg colors.base14 :bg colors.blend}
                                   :b {:bg colors.blend}
                                   :c {:bg colors.blend}}
                          :visual {:a {:fg colors.base11 :bg colors.blend}
                                   :b {:bg colors.blend}
                                   :c {:bg colors.blend}}
                          :replace {:a {:fg colors.base09 :bg colors.blend}
                                    :b {:bg colors.blend}
                                    :c {:bg colors.blend}}
                          :command {:a {:fg colors.base10 :bg colors.blend}
                                    :b {:bg colors.blend}
                                    :c {:bg colors.blend}}
                          :inactive {:a {:fg colors.base06 :bg colors.blend}
                                     :b {:bg colors.blend}
                                     :c {:bg colors.blend}}}}})
