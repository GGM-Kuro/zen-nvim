vim.filetype.add({
  pattern = {
    [".*/templates/.*%.html"] = "htmldjango",
    [".*%.djhtml"] = "htmldjango",
  },
})

