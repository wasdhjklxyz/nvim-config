return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    require("utils.sparkle").setup_highlights()
    local buttonhl = function(shortcut, text, command)
      local button = dashboard.button(shortcut, text, command)
      button.opts.hl_shortcut = "Conceal"
      return button
    end
    dashboard.section.buttons.val = {
      buttonhl("q", "Ĥ𝐇𝒽󰈈 󰈈𝓗ĦᕼĤ𝐇𝒽ℍĤ𝓗ĦᕼĤ𝐇𝓗ĦᕼнℍĤᕼнĦĤ𝐇𝒽ĦᕼĤ𝐇Ĥ𝓗ᕼнℍĤ𝓗ĦᕼнĤ𝐇𝒽", "<cmd>qa<cr>"),
      buttonhl("t", "▌║▌║║█║║▌▌║║▌▌▌║▌║▌▌║█║║▌▌▌║█║▌▌║▌║║▌█║▌▌║▌║│▌║▌", "<cmd>Neotree filesystem current<cr>"),
    }
    dashboard.section.header.val = {
      [[                                                           ]],
      [[                                                           ]],
      [[                              °                            ]],
      [[                                        ¸                  ]],
      [[                           :͓̽           ¤+                  ]],
      [[                =҉        =҉ +            °        ¸         ]],
      [[                       ¸    ¸        ¤  ° °                ]],
      [[              ¸       °               °°°  °°%°:͓̽ :͓̽         ]],
      [[                °   :͓̽°+        ¸     °×° ¤°°               ]],
      [[              ° + ¸¸°    °          °¤ °×%*  %             ]],
      [[      :͓̽     °    °¤°°=҉:͓̽         =҉    ¤¤   °          °     ]],
      [[      °°  ¸    °°    :͓̽ =҉:͓̽      °  :͓̽°:͓̽ :͓̽×+ ¸                ]],
      [[     =҉¸  ° ¸  °   :͓̽+°°×+°°    °¤ °:͓̽:͓̽=҉ ° ¤    :͓̽      +      ]],
      [[     °=҉   ¤      ¸=҉¤     * +:͓̽ * ° ¸  ¸=҉¸ =҉×:͓̽×:͓̽°:͓̽  =҉        ]],
      [[     °         °:͓̽ %¸:͓̽*=҉=҉¸°:͓̽ °  +*     ¸   ¸ *°  ° °°+      ]],
      [[  °                   + °:͓̽=҉+    * =҉   :͓̽×   =҉     °  ¸      ]],
      [[ :͓̽ :͓̽°             ¸  ¸  ¸   :͓̽:͓̽ +           ° °  :͓̽  °    :͓̽  ]],
      [[        °          :͓̽  °*¸°   × =҉          °   °            ]],
      [[                ° =҉   °=҉¸°   °° ¸              =҉ :͓̽         ]],
      [[          °         ×                                      ]],
      [[                 :͓̽°°                                       ]],
      [[               :͓̽         °                                 ]],
      [[             °                                             ]],
      [[                                                           ]],
      [[                                                           ]],
      [[                                                           ]],
    }
    vim.api.nvim_create_user_command("StopSparkle", function()
      stop_animation()
    end, {})
    require("alpha").setup(dashboard.opts)
  end,
}
