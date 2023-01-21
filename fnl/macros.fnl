;; fennel-ls: macro-file

(local {: nil? : str? : ->str : begins-with? : all : crypt} (require :core.lib))

(fn car [xs]
  (. xs 1))

(lambda expr->str [expr]
  `(macrodebug ,expr nil))

(tset _G :fennec/pack [])
(tset _G :fennec/rock [])
(tset _G :fennec/modules [])

(lambda num? [x]
  (= :number (type x)))

(lambda bool? [x]
  (= :boolean (type x)))

(lambda fn? [x]
  (= :function (type x)))

(lambda tbl? [x]
  (= :table (type x)))

(lambda ->bool [x]
  (if x true false))

(lambda keys [t]
  (let [result []]
    (when t
      (each [k _ (pairs t)]
        (table.insert result k)))
    result))

(lambda empty? [xs]
  "Check if given table is empty"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (= 0 (length xs)))

(lambda first [xs]
  "Get the first element in a list"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (. xs 1))

(lambda second [xs]
  "Get the second element in a list"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (. xs 2))

(lambda last [xs]
  "Get the last element in a list"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (. xs (length xs)))

(lambda count [xs]
  "Count the number of items in a table"
  (if (tbl? xs)
      (let [maxn (table.maxn xs)]
        (if (= 0 maxn)
            (table.maxn (keys xs))
            maxn))
      (not xs)
      0
      (length xs)))

(lambda any? [pred xs]
  (accumulate [any? false _ v (ipairs xs) :until any?]
    (pred v)))

(lambda all? [pred xs]
  (not (any? #(not (pred $)) xs)))

(lambda contains? [xs x]
  (any? #(= $ x) xs))

(lambda flatten [x ?levels]
  (assert (tbl? x) "expected tbl for x")
  (assert (or (nil? ?levels) (num? ?levels))
          "expected number or nil for levels")
  (if (or (nil? ?levels) (> ?levels 0))
      (accumulate [output [] _ v (ipairs x)]
        (if (tbl? v)
            (icollect [_ v (ipairs (flatten v
                                            (if (nil? ?levels) nil
                                                (- ?levels 1)))) :into output]
              v)
            (doto output (table.insert v))))
      x))

(lambda djb2 [str]
  "Implementation of the hash function djb2.
  Extracted the implementation from <https://theartincode.stanis.me/008-djb2/>."
  (let [bytes (icollect [char (str:gmatch ".")]
                (string.byte char))
        hash (accumulate [hash 5381 _ byte (ipairs bytes)]
               (+ byte hash (bit.lshift hash 5)))]
    (bit.tohex hash)))

(lambda gensym-checksum [x ?options]
  "Generates a new symbol from the checksum of the object passed as a parameter
  after it is casted into an string using the `view` function.
  You can also pass a prefix or a suffix into the options optional table.
  This function depends on the djb2 hash function."
  (let [options (or ?options {})
        prefix (or options.prefix "")
        suffix (or options.suffix "")]
    (sym (.. prefix (djb2 (view x)) suffix))))

(lambda fn? [x]
  "Checks if `x` is a function definition.
  Cannot check if a symbol is a function in compile time."
  (and (list? x)
       (or (= `fn (first x)) (= `hashfn (first x)) (= `lambda (first x))
           (= `partial (first x)))))

(lambda quoted? [x]
  "Check if `x` is a list that begins with `quote`."
  (and (list? x) (= `quote (first x))))

(lambda quoted->fn [expr]
  "Converts an expression like `(quote (+ 1 1))` into `(fn [] (+ 1 1))`."
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (second expr)]
    `(fn []
       ,non-quoted)))

(lambda quoted->str [expr]
  "Converts a quoted expression like `(quote (+ 1 1))` into an string with its shorthand form."
  (assert-compile (quoted? expr) "expected quoted expression for expr" expr)
  (let [non-quoted (second expr)]
    (.. "'" (view non-quoted))))

(lambda expand-exprs [exprs]
  "Converts a list of expressions into either an expression - if only one
  expression is in the list - or a do-expression containing the expressions."
  (if (> (length exprs) 1)
      `(do
         ,(unpack exprs))
      (first exprs)))

(lambda vlua [x]
  "Return a symbol mapped to `v:lua.%s()` where `%s` is the symbol."
  (assert-compile (sym? x) "expected symbol for x" x)
  (string.format "v:lua.%s()" (->str x)))

(lambda colorscheme [scheme]
  "Set a colorscheme using the vim.api.nvim_cmd API.
  Accepts the following arguements:
  scheme -> a symbol.
  Example of use:
  ```fennel
  (colorscheme carbon)
  ```"
  (assert-compile (sym? scheme) "expected symbol for name" scheme)
  (let [scheme (->str scheme)]
    `(vim.api.nvim_cmd {:cmd :colorscheme :args [,scheme]} {})))

(lambda custom-set-face! [name attributes colors]
  "Sets a highlight group globally using the vim.api.nvim_set_hl API.
  Accepts the following arguments:
  name -> a string.
  attributes -> a list of boolean attributes:
    - bold
    - italic
    - reverse
    - inverse
    - standout
    - underline
    - underlineline
    - undercurl
    - underdot
    - underdash
    - strikethrough
    - default
  colors -> a table of colors:
    - fg
    - bg
    - ctermfg
    - ctermbg
  Example of use:
  ```fennel
  (custom-set-face! Error [:bold] {:fg \"#ff0000\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_set_hl 0 \"Error\" {:fg \"#ff0000\"
                                    :bold true})
  ```"
  (assert-compile (str? name) "expected string for name" name)
  (assert-compile (table? attributes) "expected table for attributes"
                  attributes)
  (assert-compile (table? colors) "expected colors for colors" colors)
  (let [definition (collect [_ attr (ipairs attributes) &into colors]
                     (->str attr)
                     true)]
    `(vim.api.nvim_set_hl 0 ,name ,definition)))

(lambda set! [name ?value]
  "Set a vim option using the vim.opt.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                  (quoted->fn value)
                  value)
        name (if (and (nil? ?value) (begins-with? :no name))
                 (name:match "^no(.+)$")
                 name)
        exprs (if (fn? value) [`(tset _G
                                      ,(->str (gensym-checksum value
                                                               {:prefix "__"}))
                                      ,value)] [])
        value (if (fn? value)
                  (vlua (gensym-checksum value {:prefix "__"}))
                  value)
        exprs (doto exprs
                (table.insert (match (name:sub -1)
                                "+" `(: (. vim.opt ,(name:sub 1 -2)) :append
                                        ,value)
                                "-" `(: (. vim.opt ,(name:sub 1 -2)) :remove
                                        ,value)
                                "^" `(: (. vim.opt ,(name:sub 1 -2)) :prepend
                                        ,value)
                                _ `(tset vim.opt ,name ,value))))]
    (expand-exprs exprs)))

(lambda local-set! [name ?value]
  "Set a vim option using the vim.opt_local.<name> API.
  Accepts the following arguments:
  name -> must be a symbol.
          - If it ends with '+' it appends to the current value.
          - If it ends with '-' it removes from the current value.
          - If it ends with with '^' it prepends to the current value.
  value -> anything.
           - If it is not specified, whether the name begins with 'no' is used
             as a boolean value.
           - If it is a quoted expression or a function it becomes
             v:lua.<symbol>()."
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        value (if (nil? ?value)
                  (not (begins-with? :no name))
                  ?value)
        value (if (quoted? value)
                  (quoted->fn value)
                  value)
        name (if (and (nil? ?value) (begins-with? :no name))
                 (name:match "^no(.+)$")
                 name)
        exprs (if (fn? value) [`(tset _G
                                      ,(->str (gensym-checksum value
                                                               {:prefix "__"}))
                                      ,value)] [])
        value (if (fn? value)
                  (vlua (gensym-checksum value {:prefix "__"}))
                  value)
        exprs (doto exprs
                (table.insert (match (name:sub -1)
                                "+" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :append ,value)
                                "-" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :remove ,value)
                                "^" `(: (. vim.opt_local ,(name:sub 1 -2))
                                        :prepend ,value)
                                _ `(tset vim.opt_local ,name ,value))))]
    (expand-exprs exprs)))

(lambda shared-command! [api-function name command ?options]
  (assert-compile (sym? api-function) "expected symbol for api-function"
                  api-function)
  (assert-compile (sym? name) "expected symbol for name" name)
  (assert-compile (or (str? command) (sym? command) (fn? command)
                      (quoted? command))
                  "expected string, symbol, function or quoted expression for command"
                  command)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? command) (quoted->str command)
                                (str? command) command
                                (view command))))
                    options)
        command (if (quoted? command) (quoted->fn command) command)]
    `(,api-function ,name ,command ,options)))

(lambda command! [name command ?options]
  "Create a new user command using the vim.api.nvim_create_user_command API.

  Accepts the following arguments:
  name -> must be a symbol.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (command! Salute '(print \"Hello World\")
            {:bang true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_user_command \"Salute\" (fn [] (print \"Hello World\"))
                                    {:bang true
                                     :desc \"This is a description\"})
  ```"
  (shared-command! `vim.api.nvim_create_user_command name command ?options))

(lambda local-command! [name command ?options]
  "Create a new user command using the vim.api.nvim_buf_create_user_command API.

  Accepts the following arguments:
  name -> must be a symbol.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (local-command! Salute '(print \"Hello World\")
                  {:bang true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_buf_create_user_command \"Salute\" (fn [] (print \"Hello World\"))
                                        {:bang true
                                         :desc \"This is a description\"})
  ```"
  (shared-command! `vim.api.nvim_buf_create_user_command name command ?options))

(lambda autocmd! [event pattern command ?options]
  "Create an autocommand using the nvim_create_autocmd API.

  Accepts the following arguments:
  event -> can be either a symbol or a list of symbols.
  pattern -> can be either a symbol or a list of symbols. If it's <buffer> the
             buffer option is set to 0. If the buffer option is set this value
             is ignored.
  command -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (autocmd! VimEnter *.py '(print \"Hello World\")
            {:once true :group \"custom\" :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_create_autocmd :VimEnter
                               {:pattern \"*.py\"
                                :callback (fn [] (print \"Hello World\"))
                                :once true
                                :group \"custom\"
                                :desc \"This is a description\"})
  ```"
  (assert-compile (or (sym? event) (and (tbl? event) (all? #(sym? $) event))
                      "expected symbol or list of symbols for event" event))
  (assert-compile (or (sym? pattern)
                      (and (tbl? pattern) (all? #(sym? $) pattern))
                      "expected symbol or list of symbols for pattern" pattern))
  (assert-compile (or (str? command) (sym? command) (fn? command)
                      (quoted? command))
                  "expected string, symbol, function or quoted expression for command"
                  command)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [event (if (and (tbl? event) (not (sym? event)))
                  (icollect [_ v (ipairs event)]
                    (->str v))
                  (->str event))
        pattern (if (and (tbl? pattern) (not (sym? pattern)))
                    (icollect [_ v (ipairs pattern)]
                      (->str v))
                    (->str pattern))
        options (or ?options {})
        options (if (nil? options.buffer)
                    (if (= :<buffer> pattern)
                        (doto options (tset :buffer 0))
                        (doto options (tset :pattern pattern)))
                    options)
        options (if (str? command)
                    (doto options (tset :command command))
                    (doto options
                      (tset :callback
                            (if (quoted? command)
                                (quoted->fn command)
                                command))))
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? command) (quoted->str command)
                                (str? command) command
                                (view command))))
                    options)]
    `(vim.api.nvim_create_autocmd ,event ,options)))

(lambda augroup! [name ...]
  "Create an augroup using the nvim_create_augroup API.
  Accepts either a name or a name and a list of autocmd statements.

  Example of use:
  ```fennel
  (augroup! a-nice-group
    (autocmd! Filetype *.py '(print \"Hello World\"))
    (autocmd! Filetype *.sh '(print \"Hello World\")))
  ```
  That compiles to:
  ```fennel
  (do
    (vim.api.nvim_create_augroup \"a-nice-group\" {:clear false})
    (autocmd! Filetype *.py '(print \"Hello World\") {:group \"a-nice-group\"})
    (autocmd! Filetype *.sh '(print \"Hello World\") {:group \"a-nice-group\"}))
  ```"
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (assert-compile (all? #(and (list? $)
                              (or (= `clear! (first $)) (= `autocmd! (first $))))
                        [...])
                  "expected autocmd exprs for body" ...)
  (expand-exprs (let [name (->str name)]
                  (icollect [_ expr (ipairs [...]) :into [`(vim.api.nvim_create_augroup ,name
                                                                                        {:clear false})]]
                    (if (= `autocmd! (first expr))
                        (let [[_ event pattern command ?options] expr
                              options (or ?options {})
                              options (doto options (tset :group name))]
                          `(autocmd! ,event ,pattern ,command ,options))
                        (let [[_ ?options] expr]
                          `(clear! ,name ,?options)))))))

(lambda clear! [name ?options]
  "Clears an augroup using the nvim_clear_autocmds API.

  Example of use:
  ```fennel
  (clear! some-group)
  ```
  That compiles to:
  ```fennel
  (vim.api.nvim_clear_autocmds {:group \"some-group\"})
  ```"
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [name (->str name)
        options (or ?options {})
        options (doto options (tset :group name))]
    `(vim.api.nvim_clear_autocmds ,options)))

(lambda pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options.
  Additional to those options are some use-package-isms and custom keys:
  :defer to defer loading a plugin until a file is loaded 
  :call-setup to call require(%s).setup()
  :fennec-module to call require(module.%s.config)"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (match k
                    :call-setup (values :config
                                        (string.format "require(\"%s\").setup()"
                                                       (->str v)))
                    :fennec-module (values :config
                                           (string.format "require(\"modules.%s.config\")"
                                                          (->str v)))
                    :defer (values :setup
                                   (let [package (->str v)]
                                     `(lambda []
                                        (vim.api.nvim_create_autocmd [:BufRead
                                                                      :BufWinEnter
                                                                      :BufNewFile]
                                                                     {:group (vim.api.nvim_create_augroup ,package
                                                                                                          {})
                                                                      :callback (fn []
                                                                                  (if (not= vim.fn.expand
                                                                                            "%"
                                                                                            "")
                                                                                      (vim.defer_fn (fn []
                                                                                                      ((. (require :packer)
                                                                                                          :loader) ,package)
                                                                                                      (if (= ,package
                                                                                                             :nvim-lspconfig)
                                                                                                          (vim.cmd "silent! do FileType")))
                                                                                                    0)))}))))
                    _ (values k v)))]
    (doto options (tset 1 identifier))))

(lambda rock [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})]
    (doto options (tset 1 identifier))))

(lambda use-package! [identifier ?options]
  "Declares a plugin with its options. This macro adds it to the fennec/pack
  global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.fennec/pack (pack identifier ?options)))

(lambda rock! [identifier ?options]
  "Declares a rock with its options. This macro adds it to the fennec/rock
  global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options))
      (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.fennec/rock (rock identifier ?options)))

(lambda unpack! []
  "Initializes the plugin manager with the plugins previously declared and
  their respective options."
  (let [packs (icollect [_ v (ipairs _G.fennec/pack)]
                v)
        rocks (icollect [_ v (ipairs _G.fennec/rock)]
                `(use_rocks ,v))
        plugin_spec [(unpack (icollect [_ v (ipairs packs) &into rocks]
                               v))]]
    `((. (require :lazy) :setup) ,plugin_spec)))

(lambda packadd! [package]
  "Loads a package using the vim.api.nvim_cmd API.
  Accepts the following arguements:
  package -> a symbol.
  Example of use:
  ```fennel
  (packadd! packer.nvim)
  ```"
  (assert-compile (sym? package) "expected symbol for package" package)
  (let [package (->str package)]
    `(vim.api.nvim_cmd {:cmd :packadd :args [,package]} {})))

(lambda map! [[modes] lhs rhs ?options]
  "Add a new mapping using the vim.keymap.set API.

  Accepts the following arguments:
  modes -> is a sequence containing a symbol, each character of the symbol is
           a mode.
  lhs -> must be an string.
  rhs -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (map! [nv] \"<leader>lr\" vim.lsp.references
        {:silent true :buffer 0 :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.keymap.set [:n :v] \"<leader>lr\" vim.lsp.references
                  {:silent true
                   :buffer 0
                   :desc \"This is a description\"})
  ```"
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (sym? rhs) (fn? rhs) (quoted? rhs))
                  "expected string, symbol, function or quoted expression for rhs"
                  rhs)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [modes (icollect [char (string.gmatch (->str modes) ".")]
                char)
        options (or ?options {})
        options (if (nil? options.desc)
                    (doto options
                      (tset :desc
                            (if (quoted? rhs) (quoted->str rhs)
                                (str? rhs) rhs
                                (view rhs))))
                    options)
        rhs (if (quoted? rhs) (quoted->fn rhs) rhs)]
    `((. (require :legendary) :keymap) {1 ,lhs
                                        2 ,rhs
                                        :mode ,modes
                                        :opts ,options})))

(lambda buf-map! [[modes] lhs rhs ?options]
  "Add a new mapping using the vim.keymap.set API.
  Sets by default the buffer option.

  Accepts the following arguments:
  modes -> is a sequence containing a symbol, each character of the symbol is
           a mode.
  lhs -> must be an string.
  rhs -> can be an string, a symbol, a function or a quoted expression.
  options -> a table of options. Optional. If the :desc option is not specified
             it will be inferred.

  Example of use:
  ```fennel
  (map! [nv] \"<leader>lr\" vim.lsp.references
        {:silent true :desc \"This is a description\"})
  ```
  That compiles to:
  ```fennel
  (vim.keymap.set [:n :v] \"<leader>lr\" vim.lsp.references
                  {:silent true
                   :buffer 0
                   :desc \"This is a description\"})
  ```"
  (assert-compile (sym? modes) "expected symbol for modes" modes)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (sym? rhs) (fn? rhs) (quoted? rhs))
                  "expected string, symbol, function or quoted expression for rhs"
                  rhs)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [options (or ?options {})
        options (doto options (tset :buffer 0))]
    (map! [modes] lhs rhs options)))

(lambda let-with-scope! [[scope] name value]
  (assert-compile (or (str? scope) (sym? scope))
                  "expected string or symbol for scope" scope)
  (assert-compile (or (= :b (->str scope)) (= :w (->str scope))
                      (= :t (->str scope)) (= :g (->str scope)))
                  "expected scope to be either b, w, t or g" scope)
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)
        scope (->str scope)]
    `(tset ,(match scope
              :b `vim.b
              :w `vim.w
              :t `vim.t
              :g `vim.g) ,name ,value)))

(lambda let-global! [name value]
  (assert-compile (or (str? name) (sym? name))
                  "expected string or symbol for name" name)
  (let [name (->str name)]
    `(tset vim.g ,name ,value)))

(lambda let! [...]
  "Set a vim variable using the vim.<scope>.name API.
  Accepts the following arguments:
  [scope] -> optional. Can be either [g], [w], [t] or [b]. It's either a symbol
             or a string surrounded by square brackets.
  name -> either a symbol or a string.
  value -> anything.
  Example of use:
  ```fennel
  (let! hello :world)
  (let! [w] hello :world)
  ```
  That compiles to:
  ```fennel
  (tset vim.g :hello :world)
  (tset vim.w :hello :world)
  ```"
  (match [...]
    [[scope] name value] (let-with-scope! [scope] name value)
    [name value] (let-global! name value)
    _ (error "expected let! to have at least two arguments: name value")))

(lambda sh [...]
  "simple macro to run shell commands inside fennel"
  `(let [str# ,(accumulate [str# "" _ v# (ipairs [...])]
                 (if (in-scope? v#) `(.. ,str# " " ,v#)
                     (or (list? v#) (sym? v#)) (.. str# " " (tostring v#))
                     (= (type v#) :string) (.. str# " " (string.format "%q" v#))))
         fd# (io.popen str#)
         d# (fd#:read :*a)]
     (fd#:close)
     (string.sub d# 1 (- (length d#) 1))))

(lambda fennec! [...]
  "Recreation of the `doom!` macro for fennec
  See modules.fnl for usage
  Accepts the following arguments:
  value -> anything.
  Example of use:
  ```fennel
  (fennec! :category
          module
          (module +with +flags
          :anothercategory
          anothermodule
          (module +with +more +flags)
  ```"
  (var moduletag nil)
  (var registry {})

  (fn register-module [name]
    (if (str? name)
        (set moduletag name)
        (if (sym? name)
            (let [name (->str name)
                  include-path (.. :fnl.modules. moduletag "." name)
                  config-path (.. :modules. moduletag "." name :.config)]
              (tset registry name
                    {:include-paths [include-path] :config-paths [config-path]}))
            (let [modulename (->str (first name))
                  include-path (.. :fnl.modules. moduletag "." modulename)
                  config-path (.. :modules. moduletag "." modulename :.config)
                  [_ & flags] name]
              (var includes [include-path])
              (var configs [config-path])
              (each [_ v (ipairs flags)]
                (let [flagmodule (.. modulename "." (->str v))
                      flag-include-path (.. include-path "." (->str v))
                      flag-config-path (.. :modules. moduletag "." flagmodule
                                           :.config)]
                  (table.insert includes flag-include-path)
                  (table.insert configs flag-config-path)
                  (tset registry flagmodule {})))
              (tset registry modulename
                    {:include-paths includes :config-paths configs})))))

  (fn register-modules [...]
    (each [_ mod (ipairs [...])]
      (register-module mod))
    registry)

  (let [modules (register-modules ...)]
    (tset _G :fennec/modules modules)
    `(do
       (tset _G :fennec/modules ,modules)
       (. _G :fennec/modules))))

(lambda fennec-init-modules! []
  "Initializes fennec's module system.
  ```fennel
  (fennec-init-modules!)
  ```"
  (fn init-module [module-name module-def]
    (icollect [_ include-path (ipairs (or module-def.include-paths []))]
      `(include ,include-path)))

  (fn init-modules [registry]
    (icollect [module-name module-def (pairs registry)]
      (init-module module-name module-def)))

  (let [inits (init-modules _G.fennec/modules)]
    (expand-exprs inits)))

(lambda fennec-compile-modules! []
  "Compiles and caches module files.
  ```fennel
  (fennec-compile-modules!)
  ```"
  (fn compile-module [module-name module-decl]
    (icollect [_ config-path (ipairs (or module-decl.config-paths []))]
      `,(pcall require config-path)))

  (fn compile-modules [registry]
    (icollect [module-name module-def (pairs registry)]
      (compile-module module-name module-def)))

  (let [source (compile-modules _G.fennec/modules)]
    (expand-exprs [(unpack source)])))

;; (lambda fennec-module! [name]
;;   "By default modules should be loaded through use-package!. Of course, not every
;;   modules needs a package. Sometimes we just want to load `config.fnl`. In this 
;;   case, we can hack onto packer.nvim, give it a fake package, and ask it to load a 
;;   config file.
;;   Example of use:
;;   ```fennel
;;   (fennec-module! tools.tree-sitter)
;;   ```"
;;   (assert-compile (sym? name) "expected symbol for name" name)
;;   (let [name (->str name)]
;;     `(require (string.format "modules.%s.config" ,name))))

(lambda fennec-module! [name]
  "By default modules should be loaded through use-package!. Of course, not every
  modules needs a package. Sometimes we just want to load `config.fnl`. In this 
  case, we can hack onto packer.nvim, give it a fake package, and ask it to load a 
  config file.
  Example of use:
  ```fennel
  (fennec-module! tools.tree-sitter)
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        hash (djb2 name)]
    (table.insert _G.fennec/pack
                  (pack (.. :fennec. hash) {:fennec-module name}))))

(lambda fennec-module-p! [name config]
  "Checks if a module is enabled
  Accepts the following arguements:
  name -> a symbol.
  Example of use:
  ```fennel
  (fennec-module-p! tree-sitter)
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)
        module-exists (not= nil (. _G.fennec/modules name))]
    (when module-exists
      `,config)))

(lambda fennec-module-ensure! [name]
  "Ensure a module is enabled
  Accepts the following arguements:
  name -> a symbol.
  Example of use:
  ```fennel
  (fennec-module-ensure! tools.tree-sitter)
  ```"
  (assert-compile (sym? name) "expected symbol for name" name)
  (when (not (contains? _G.fennec/modules name))
    (let [msg (.. "One of your installed modules depends on " (->str name)
                  ". Please enable it")]
      `(vim.notify ,msg vim.log.levels.WARN))))

(lambda fennec-package-count! []
  "Return number of installed packages"
  (let [package-length (length _G.fennec/pack)]
    `,package-length))

(lambda fennec-module-count! []
  "Return number of installed modules"
  (let [module-length (length _G.fennec/modules)]
    `,module-length))

{: contains?
 : any?
 : str?
 : empty?
 : bool?
 : second
 : expr->str
 : vlua
 : colorscheme
 : custom-set-face!
 : set!
 : local-set!
 : command!
 : local-command!
 : autocmd!
 : augroup!
 : clear!
 : pack
 : rock
 : use-package!
 : rock!
 : unpack!
 : packadd!
 : map!
 : buf-map!
 : let!
 : sh
 : fennec!
 : fennec-module!
 : fennec-module-p!
 : fennec-module-ensure!
 : fennec-init-modules!
 : fennec-compile-modules!
 : fennec-package-count!
 : fennec-module-count!}
