local cmp = require "cmp"
local opts = require "plugins.configs.cmp"

opts.mapping["<C-p>"] = cmp.mapping.select_prev_item {}
opts.mapping["<C-n>"] = cmp.mapping.select_next_item {}
opts.mapping["<CR>"] = cmp.mapping.close {}
opts.mapping["<C-y>"] = cmp.mapping.confirm {
  behavior = cmp.ConfirmBehavior.Insert,
  select = true,
}
opts.mapping["<Tab>"] = cmp.mapping.close {}
opts.mapping["<S-Tab>"] = cmp.mapping.close {}

return opts
