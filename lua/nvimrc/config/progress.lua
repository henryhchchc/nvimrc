vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup("nvimrc_lsp_progress", {}),
  pattern = { "begin", "report", "end" },
  callback = function (event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    local params = event.data.params
    local value = params.value
    local done = value.kind == "end"
    local message = value.message or (done and "Done" or "Running")
    vim.api.nvim_echo({ { message } }, false, {
      id = string.format("lsp.%d.%s.%s", client.id, type(params.token), params.token),
      kind = "progress",
      source = client.name,
      title = client.name .. ": " .. (value.title or "Working"),
      status = done and "success" or "running",
      percent = done and 100 or value.percentage,
    })
  end,
})
