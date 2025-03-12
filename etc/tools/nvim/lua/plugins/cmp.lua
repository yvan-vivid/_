local sources = {
  { name = "nvim_lsp" },
  { name = "luasnip" },
  { name = "buffer" },
  { name = "nvim_lua" },
  { name = "path" },
  { name = "codeium" },
}

local function opts()
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  local mapping = cmp.mapping

  local function confirm_replace(select)
    cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = select }
  end

  local function confirm_default(select)
    cmp.mapping.confirm { select = select }
  end

  local function confirm_modal(fallback)
    if cmp.visible() and cmp.get_active_entry() then
      print "Confirm intended"
      confirm_replace(false)
    else
      print "Confirm fallback"
      fallback()
    end
  end

  local function selection_forward(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end

  local function selection_backward(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end

  return {
    preselect = cmp.PreselectMode.None,
    completion = { completeopt = "menu,menuone,noselect" },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = {
      ["<C-p>"] = mapping.select_prev_item(),
      ["<C-n>"] = mapping.select_next_item(),
      ["<C-d>"] = mapping.scroll_docs(-4),
      ["<C-f>"] = mapping.scroll_docs(4),
      ["<C-Space>"] = mapping.complete(),
      ["<C-e>"] = mapping.close(),
      ["<CR>"] = mapping {
        i = confirm_modal,
        s = confirm_default(true),
        c = confirm_replace(true),
      },
      ["<Tab>"] = mapping(selection_forward, { "i", "s" }),
      ["<S-Tab>"] = mapping(selection_backward, { "i", "s" }),
    },

    sources = sources,
  }
end

return {
  "hrsh7th/nvim-cmp",
  opts = opts,
}
