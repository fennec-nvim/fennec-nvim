(module plugin.fugitive
  {autoload {util util}})

(util.nnoremap :gs "Git")
(util.nnoremap :gb "Git blame")
(util.nnoremap :gd "Gdiff")
(util.nnoremap :gp "Git push")
(util.nnoremap :gl "Git pull")
(util.nnoremap :gf "Git fetch")
(util.nnoremap :gcc "Git commit --verbose")
(util.nnoremap :gca "Git commit --all --verbose")
(util.nnoremap :gdl "diffget LOCAL")
(util.nnoremap :gdr "diffget REMOTE")
