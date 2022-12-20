(fn autoload [name]
  "Similar to autoload from VimScript, replacement for require
  (for table modules) that loads the module when you first use it
  Load a module on demand and return a function that can be called to access the module.

  Accepts the following arguments:
  * `name`: a string representing the name of the module to be loaded

  Example:
  ```fennel
  (let [my_module (autoload \"my_module\")]
    (my_module.some_function \"some_arg\"))
  (assert (not= (autoload \"my_module\").some_function nil))
  ```"
  (let [res {:fennec/autoload-enabled? true :fennec/autoload-module false}]
    (fn ensure []
      (if (. res :fennec/autoload-module)
          (. res :fennec/autoload-module)
          (let [m (require name)]
            (tset res :fennec/autoload-module m)
            m)))

    (setmetatable res
                  {:__call (fn [t ...]
                             ((ensure) ...))
                   :__index (fn [t k]
                              (. (ensure) k))
                   :__newindex (fn [t k v]
                                 (tset (ensure) k v))})))

{: autoload}
