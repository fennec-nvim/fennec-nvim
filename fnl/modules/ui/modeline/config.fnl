(import-macros {: set! : vlua : autocmd! : packadd!} :macros)
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

(local components {})
(tset components :gutter {1 (fn []
                              git-icons.gutter)
                          :padding {:left 0 :right 0}
                          :color {:fg (. colors :base12)}
                          :cond nil})

(tset components :mode {1 (fn []
                            (.. " " modeline-icons.evil " "))
                        :padding {:left 0 :right 0}
                        :color []
                        :cond nil})

(tset components :buf-size
      {1 (fn []
           (filesize (. (vim.fn.wordcount) :bytes) {:round 1}))
       :color {:fg (. colors :base06)}})

(tset components :buf-modified
      {1 (fn []
           (var fg (. colors :base09))
           (var mod "")
           (when vim.bo.modified
             (set fg (. colors :base10))
             (set mod ""))
           (when (not vim.bo.modifiable)
             (set fg (. colors :base10))
             (set mod ""))
           (vim.cmd (.. "hi! lualine_filename_status gui=bold guifg=" fg))
           mod)
       :color :lualine_filename_status
       :cond (fn []
               (when (not= vim.bo.filetype :TelescopePrompt)
                 true))})

(tset components :dir {1 (fn []
                           (.. (vim.fn.expand "%:p:h:t") "/"))
                       :padding {:left 1 :right 0}
                       :color :lualine_filename_status})

(tset components :filename {1 :filename
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

(tset components :lsp {1 (fn [msg]
                           (var msg (or msg "LS Inactive"))
                           (local buf-clients (vim.lsp.buf_get_clients))
                           (if (= (next buf-clients) nil)
                               (when (or (= (type msg) :boolean) (= #msg 0))
                                 "LS Inactive")
                               msg)
                           (local buf-ft vim.bo.filetype)
                           (local buf-client-names {})
                           (each [_ client (pairs buf-clients)]
                             (when (and (not= client.name :null-ls)
                                        (not= client.name :copilot))
                               (table.insert buf-client-names client.name)))
                           ;; TODO: docstring for list-registered-providers-names
                           (lambda list-registered-providers-names [filetype]
                             "Doc string for list-registered-providers-names."
                             (local s (require :null-ls.sources))
                             (local available-sources
                                    (s.get_available filetype))
                             (local registered {})
                             (each [_ source (ipairs available-sources)]
                               (each [method (pairs source.methods)]
                                 (tset registered method
                                       (or (. registered method) {}))
                                 (table.insert (. registered method)
                                               source.name)))
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
                           (vim.list_extend buf-client-names
                                            supported-formatters)
                           (vim.list_extend buf-client-names supported-linters)
                           (local uniq-client-names
                                  (vim.fn.uniq buf-client-names))
                           (local language-servers
                                  (.. "[" (table.concat uniq-client-names ", ")
                                      "]"))
                           language-servers)
                       :color {:gui :bold}})

(tset components :spaces
      {1 (fn []
           (local shiftwidth (vim.api.nvim_buf_get_option 0 :shiftwidth))
           (.. modeline-icons.tab " " shiftwidth))})

(tset components :filetype {1 :filetype :cond nil :padding {:left 1 :right 1}})

(tset components :location [:location])

(tset components :progress {1 :progress
                            :fmt (fn []
                                   "%P")
                            ;; "%P/%L")
                            :color {}})

(set! laststatus 3)
(set! cmdheight 0)

;; lualine_a
;; [git-icons.gutter, mode, buffer size]

;; lualine_b
;; [save, dir/filename.ext] (dir is normal mode color, filename is fg. when not saved, dir and filename is base10)

;; lualine_c
;; [buffer position, buffer percentage]

;; lualine_x
;; [filetype]

;; lualine_y
;; [branch]

;; lualine_z
;; diagnostics

(setup :lualine
       {:sections {:lualine_a [components.gutter
                               components.mode
                               components.buf-size]
                   :lualine_b [components.buf-modified
                               components.dir
                               components.filename]
                   :lualine_c [components.location components.progress]
                   :lualine_x [components.lsp components.filetype]
                   :lualine_y [components.branch]
                   :lualine_z [components.diagnostics]}
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

;; modeline

;; (local modes {:n :RW
;;               :no :RO
;;               :v "**"
;;               :V "**"
;;               "\022" "**"
;;               :s :S
;;               :S :SL
;;               "\019" :SB
;;               :i "**"
;;               :ic "**"
;;               :R :RA
;;               :Rv :RV
;;               :c :VIEX
;;               :cv :VIEX
;;               :ce :EX
;;               :r :r
;;               :rm :r
;;               :r? :r
;;               :! "!"
;;               :t ""})

;; ;; by default these can be blank:

;; (fn get-filetype []
;;   (.. "%#NormalNC#" vim.bo.filetype))

;; (fn get-bufnr []
;;   (.. "%#Comment#" (vim.api.nvim_get_current_buf)))

;; (fn color []
;;   (let [mode (. (vim.api.nvim_get_mode) :mode)]
;;     (var mode-color "%#Normal#")
;;     (if (= mode :n) (set mode-color "%#StatusNormal#")
;;         (or (= mode :i) (= mode :ic)) (set mode-color "%#StatusInsert#")
;;         (or (or (= mode :v) (= mode :V)) (= mode "\022"))
;;         (set mode-color "%#StatusVisual#") (= mode :R)
;;         (set mode-color "%#StatusReplace#") (= mode :c)
;;         (set mode-color "%#StatusCommand#") (= mode :t)
;;         (set mode-color "%#StatusTerminal#"))
;;     mode-color))

;; (fn get-fileinfo []
;;   (var filename (or (and (= (vim.fn.expand "%") "") " fennec-nvim v0.0.1-dev")
;;                     (vim.fn.expand "%:t")))
;;   (when (not= filename " fennec-nvim ")
;;     (set filename (.. " " filename " ")))
;;   (.. "%#Normal#" filename "%#NormalNC#"))

;; ;; but overwrite them with conditional features if enabled

;; (fn get-git-status []
;;   (let [branch (or vim.b.gitsigns_status_dict {:head ""})
;;         is-head-empty (not= branch.head "")]
;;     (or (and is-head-empty (string.format "(λ • #%s) " (or branch.head "")))
;;         "")))

;; ;; get the number of entries of certain severity

;; (fn get-lsp-diagnostic [])
;; (when (not (rawget vim :lsp))
;;   (lua "return \"\""))

;; (fn get-severity [s]
;;   (length (vim.diagnostic.get 0 {:severity s})))

;; (local result
;;        {:errors (get-severity vim.diagnostic.severity.ERROR)
;;         :warnings (get-severity vim.diagnostic.severity.WARN)
;;         :info (get-severity vim.diagnostic.severity.INFO)
;;         :hints (get-severity vim.diagnostic.severity.HINT)})

;; (string.format " %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s "
;;                (or (. result :warnings) 0) (or (. result :errors) 0))

;; (fn get-searchcount []
;;   (when (= vim.v.hlsearch 0)
;;     (lua "return \"%#Normal# %l:%c \""))
;;   (local (ok count) (pcall vim.fn.searchcount {:recompute true}))
;;   (when (or (or (not ok) (= count.current nil)) (= count.total 0))
;;     (lua "return \"\""))
;;   (when (= count.incomplete 1)
;;     (lua "return \"?/?\""))
;;   (local too-many (: ">%d" :format count.maxcount))
;;   (local total (or (and (> count.total count.maxcount) too-many) count.total))
;;   (.. "%#Normal#" (: " %s matches " :format total)))

;; (global Statusline {})
;; (set Statusline.statusline
;;      (fn []
;;        (table.concat [(color)
;;                       (: (string.format " %s "
;;                                         (. modes
;;                                            (. (vim.api.nvim_get_mode) :mode)))
;;                          :upper)
;;                       (get-fileinfo)
;;                       (get-git-status)
;;                       (get-bufnr)
;;                       "%="
;;                       (get-lsp-diagnostic)
;;                       (get-filetype)
;;                       (get-searchcount)])))

;; (set! laststatus 3)
;; (set! cmdheight 0)
;; (set! statusline (.. "%!" (vlua Statusline.statusline)))

;; (fn load-incline []
;;   (do
;;     (local {: diagnostic-icons} (autoload :core.shared))
;;     (fn incline-diagnostic-label [props]
;;       (let [label {}]
;;         (each [severity icon (pairs diagnostic-icons)]
;;           (local n
;;                  (length (vim.diagnostic.get props.buf
;;                                              {:severity (. vim.diagnostic.severity
;;                                                            (string.upper severity))})))
;;           (when (> n 0)
;;             (table.insert label
;;                           {1 (.. icon " " n " ")
;;                            :group (.. :DiagnosticSign severity)})))
;;         (when (> (length label) 0)
;;           (table.insert label [" "]))
;;         label))

;;     (fn incline-git-diff [props]
;;       (let [icons {:removed "" :changed "" :added ""}
;;             labels {}
;;             signs (vim.api.nvim_buf_get_var props.buf :gitsigns_status_dict)]
;;         (each [name icon (pairs icons)]
;;           (when (and (tonumber (. signs name)) (> (. signs name) 0))
;;             (table.insert labels
;;                           {1 (.. icon " " (. signs name) " ")
;;                            :group (.. :Diff name)})))
;;         (when (> (length labels) 0)
;;           (table.insert labels [" "]))
;;         labels))

;;     (setup :incline {:render (fn [props]
;;                                (local filename
;;                                       (vim.fn.fnamemodify (vim.api.nvim_buf_get_name props.buf)
;;                                                           ":t"))
;;                                (local (ft-icon ft-color)
;;                                       ((. (autoload :nvim-web-devicons)
;;                                           :get_icon_color) filename))
;;                                (local modified
;;                                       (or (and (vim.api.nvim_buf_get_option props.buf
;;                                                                             :modified)
;;                                                "bold,italic")
;;                                           :bold))
;;                                (local buffer
;;                                       [[(incline-diagnostic-label props)]
;;                                        [(incline-git-diff props)]
;;                                        {1 ft-icon :guifg ft-color}
;;                                        [" "]
;;                                        {1 filename :gui modified}])
;;                                buffer)
;;                      :hide {:cursorline true :focused_win false :only_win true}
;;                      :ignore {:buftypes {}
;;                               :filetypes [:fugitiveblame
;;                                           :DiffviewFiles
;;                                           :DiffviewFileHistory
;;                                           :DiffviewFHOptionPanel
;;                                           :Outline
;;                                           :dashboard]
;;                               :floating_wins true
;;                               :unlisted_buffers false
;;                               :wintypes :special}
;;                      :highlight {:groups {:InclineNormal :NONE
;;                                           :InclineNormalNC :NONE}}
;;                      :window {:margin {:horizontal {:left 0 :right 1}
;;                                        :vertical {:bottom 0 :top 1}}
;;                               :options {:winblend 20
;;                                         :signcolumn :no
;;                                         :wrap false}
;;                               :padding {:left 2 :right 2}
;;                               :padding_char " "
;;                               :placement {:vertical :top :horizontal :right}
;;                               :width :fit
;;                               :winhighlight {:active {:EndOfBuffer :None
;;                                                       :Normal :InclineNormal
;;                                                       :Search :None}
;;                                              :inactive {:EndOfBuffer :None
;;                                                         :Normal :InclineNormalNC
;;                                                         :Search :None}}
;;                               :zindex 10}})))

;; (autocmd! [:BufAdd :TabEnter] * `(load-incline))
