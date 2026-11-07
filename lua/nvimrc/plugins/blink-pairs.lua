local options = {
  mappings = { enabled = true },
  highlights = {
    cmdline = false,
    groups = {
      "BlinkPairsRed", "BlinkPairsYellow", "BlinkPairsBlue", "BlinkPairsOrange",
      "BlinkPairsGreen", "BlinkPairsPurple", "BlinkPairsCyan",
    },
    matchparen = { enabled = false },
  },
}

local pairs = require("blink.pairs")
if pairs.library_available() then
  pairs.setup(options)
else
  local progress = require("fidget.progress").handle.create({
    title = "Downloading pairing library",
    lsp_client = { name = "blink.pairs" },
    cancellable = false,
  })
  -- blink.lib's download task does not propagate completion or errors.
  local native = require("blink.lib.native")
  local task = require("blink.lib.task")
  local temporary_path
  task.resolve()
      :map(function ()
        local plugin = vim.pack.get({ "blink.pairs" })[1]
        local platform = native.platform()
        local tag = assert(native.git_tag(plugin.path), "Blink Pairs requires a tagged release")
        local triple = assert(platform.triple, "Unsupported Blink Pairs platform")
        local path = native.library_path(plugin.path, "blink_pairs_parser", plugin.rev)
        temporary_path = path .. ".download." .. vim.fn.getpid()
        vim.fn.mkdir(vim.fs.dirname(path), "p")
        local url = "https://github.com/saghen/blink.pairs/releases/download/"
            .. tag .. "/" .. triple .. platform.lib_extension
        return task.new(function (resolve, reject)
          local job = vim.net.request(url, { outpath = temporary_path }, function (err)
            if err then
              reject(err)
            else
              resolve(path)
            end
          end)
          return function () job:close() end
        end)
      end)
      :timeout(60000)
      :schedule()
      :map(function (path)
        native.mv(temporary_path, path)
        pairs.setup(options)
        progress.message = "Ready"
        progress:finish()
      end)
      :catch(vim.schedule_wrap(function (err)
        if temporary_path then
          vim.fn.delete(temporary_path)
        end
        progress.message = "Failed"
        progress:finish()
        vim.notify("blink.pairs: " .. tostring(err), vim.log.levels.ERROR)
      end))
end
