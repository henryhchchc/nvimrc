local function git_signs_on_attach(bufnr)
  local gs = package.loaded.gitsigns
  local function bufnmap(key, func, desc) vim.keymap.set("n", key, func, { buffer = bufnr, desc = desc }) end

  bufnmap("<leader>ghs", gs.stage_hunk, "Git Stage Hunk")
  bufnmap("<leader>ghr", gs.reset_hunk, "Git Reset Hunk")
  bufnmap("<leader>ghS", gs.stage_buffer, "Git Stage Buffer")
  bufnmap("<leader>ghu", gs.undo_stage_hunk, "Git Undo Stage Hunk")
  bufnmap("<leader>ghR", gs.reset_buffer, "Git Reset Buffer")
  bufnmap("<leader>ghP", gs.preview_hunk, "Git Preview Hunk")
  bufnmap("<leader>ghd", gs.diffthis, "Git Diffthis")
  bufnmap("[h", gs.prev_hunk, "Git Previous Hunk")
  bufnmap("]h", gs.next_hunk, "Git Next Hunk")
  bufnmap("<leader>ghp", gs.preview_hunk_inline, "Git Preview Hunk Inline")
  bufnmap("<leader>ghb", function () gs.blame_line({ full = true }) end, "Git Blame Line")
end


require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  current_line_blame = true,
  numhl = true,
  word_diff = false,
  on_attach = git_signs_on_attach,
})
