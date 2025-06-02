return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "angularls",
      "cssls",
      "html",
      "jsonls",
      "lua_ls",
      "pylsp",
      "tailwindcss",
      "ts_ls",
      "hyprls",
      "eslint_d",
      "prettier",
    },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
