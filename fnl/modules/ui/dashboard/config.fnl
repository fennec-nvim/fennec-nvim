(import-macros {: fennec-package-count! : fennec-module-count!} :macros)
(local {: setup} (require :core.lib.setup))
(local {: autoload} (require :core.lib.autoload))

(local lazy (autoload :lazy))

;; TODO: better integration for startup-time and package-counter with lazy and alpha
;; only calculate startup-time after LazyVimStarted event 
(fn get-startup-time []
  (let [stats (lazy.stats)
        ms (/ (math.floor (+ (* stats.startuptime 100) 0.5)) 100)]
    `,ms))

(fn get-package-count []
  (let [stats (lazy.stats)
        loaded stats.loaded]
    `,loaded))

(local package-count (get-package-count))
(local startup-time (get-startup-time))
(local module-count 0)

(var footer-text
     (string.format "Fennec loaded %d packages across %d modules in  %dms"
                    package-count module-count startup-time))

;; setup alpha

(fn button [sc txt keybind keybind-opts]
  (let [sc- (: (sc:gsub "%s" "") :gsub :SPC :<leader>)
        opts {:position :center
              :shortcut sc
              :cursor 5
              :width 50
              :align_shortcut :right
              :hl :DashboardCenter
              :hl_shortcut :DashboardShortCut}]
    (when keybind
      (set opts.keymap
           [:n sc- keybind {:noremap true :silent true :nowait true}]))

    (fn on-press []
      (let [key (vim.api.nvim_replace_termcodes (or keybind (.. sc- :<Ignore>))
                                                true false true)]
        (vim.api.nvim_feedkeys key :t false)))

    {:type :button :val txt :on_press on-press : opts}))

(local sections
       {:header {:type :text
                 :val ["========   ======   ========   ========   ===============     ===============   ========  ========"
                       "\\\\ . . \\\\ /| . .\\\\  |\\ . . |\\ /| . . /|  //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //"
                       "||. . . \\\\||. . .|| ||. . .|| ||. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||"
                       "|| . . . \\|| . . || || . . || || . . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||"
                       "||. . . . \\|. . .|| ||. . .`==='. . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||"
                       "|| . . . . ` . . || || . . . . . . _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||"
                       "||. .|. . . . . .|| `-__________.-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||"
                       "|| . |\\. . . . _-||  \\_____    ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||"
                       "||. .| \\. . _-'  || //     \\.--||    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||"
                       "|| . |  \\.-'     || ||      `-_||    || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||"
                       "||. _|  |\\       || ||         `'    || ||         `'    || ||    `'         || ||   | \\  / |   ||"
                       "||-' |  | \\   .===' `===.         .==='.`===.         .==='.`===.         .===' /==. |  \\/  |   ||"
                       "||   |  |  \\=='   \\_|-_ `===. .==='   _-|-_ `===. .===' _-|-_   `===. .===' _-|/   `==  \\/  |   ||"
                       "||   |  |   \\   _-'    `-_  `='    _-'     `-_  `='  _-'     `-_    `='  _-'   `-_  /|  \\/  |   ||"
                       "||   |  |    `-'          `-__\\._-'           `-_|_-'           `-_./__-'         `' |. /|  |   ||"
                       "||.==\\  |                                                                             `' |  /==.||"
                       "=='   \\/                                    N E O V I M                                   \\/   `=="
                       "\\   _-'                                                                                    `-_   /"
                       " `''                                                                                          ``' "]
                 :opts {:position :center :hl :DashboardHeader}}
        :buttons {:type :group
                  :val [(button :L "  Reload last session"
                                ":Telescope find_files <CR>")
                        (button :A "  Open agenda" ":Telescope oldfiles<CR>")
                        (button :r "  Recently opened files"
                                ":Telescope oldfiles<CR>")
                        (button :p "  Open project" ":Telescope project<CR>")
                        (button :RET "  Jump to bookmark"
                                ":Telescope marks<CR>")
                        (button :P "  Open private configuration"
                                ":Telescope keymaps<CR>")
                        (button :h "  Open documentation"
                                ":Telescope keymaps<CR>")
                        (button :q "  Quit" ":qa!<CR>")]
                  :opts {:spacing 1}}
        :footer {:type :text
                 :val footer-text
                 :opts {:position :center :hl :DashboardFooter}}
        :icon {:type :button
               :val "ﯙ"
               :opts {:position :center :hl :Decorator}
               :on_press (fn []
                           (if (= (vim.fn.has :mac) 1)
                               (os.execute "open https://github.com/fennec-nvim/fennec-nvim")
                               (os.execute "xdg-open https://github.com/fennec-nvim/fennec-nvim")))}})

(setup :alpha {:layout [{:type :padding :val 4}
                        sections.header
                        {:type :padding :val 2}
                        sections.buttons
                        {:type :padding :val 2}
                        sections.footer
                        {:type :padding :val 1}
                        sections.icon]})
