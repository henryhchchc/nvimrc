local nordColors = require("nvimrc.ui.nord").colors

local M = {}

local tabbyHl = {
    fill = "TabLineFill",
    head = { fg = nordColors.nord0, bg = nordColors.nord9, style = "bold" },
    tail = { fg = nordColors.nord0, bg = nordColors.nord9 },
    tab = { fg = nordColors.nord4, bg = nordColors.nord3 },
    win = { fg = nordColors.nord4, bg = nordColors.nord3 },
    current_tab = { fg = nordColors.nord0, bg = nordColors.nord7 },
}

--- @param tabbyLine TabbyLine
local function tabbyLineConfig(tabbyLine)
    local cwdName = vim.fs.basename(vim.fn.getcwd())
    vim.opt.titlestring = cwdName .. " - NVIM"
    local cwdHead = "  " .. cwdName .. " "
    local head = {
        { cwdHead, hl = tabbyHl.head },
        tabbyLine.sep("", tabbyHl.head, tabbyHl.fill),
    }

    local tabsSection = tabbyLine.tabs().foreach(function(tab)
        local tabHl = tab.is_current() and tabbyHl.current_tab or tabbyHl.tab
        local tabItem = {
            tabbyLine.sep("", tabHl, tabbyHl.fill),
            tab.is_current() and "" or "󰆣",
            tab.number(),
            tab.name(),
            tab.close_btn(""),
            tabbyLine.sep("", tabHl, tabbyHl.fill),
            hl = tabHl,
            margin = " ",
        }
        return tabItem
    end)

    local function windowsFilter(win) return not string.match(win.buf_name(), "NvimTree") end

    local activeTab = tabbyLine.api.get_current_tab()
    local windowsSection = tabbyLine.wins_in_tab(activeTab, windowsFilter).foreach(function(win)
        local winItem = {
            tabbyLine.sep("", tabbyHl.win, tabbyHl.fill),
            win.is_current() and "" or "",
            win.buf_name(),
            tabbyLine.sep("", tabbyHl.win, tabbyHl.fill),
            hl = tabbyHl.win,
            margin = " ",
        }
        return winItem
    end)

    local tail = {
        tabbyLine.sep("", tabbyHl.tail, tabbyHl.fill),
        { "  ", hl = tabbyHl.tail },
    }
    return {
        head,
        tabsSection,
        tabbyLine.spacer(),
        windowsSection,
        tail,
        hl = tabbyHl.fill,
    }
end

local function configure() require("tabby.tabline").set(tabbyLineConfig) end

--- @type LazyPluginSpec
M.pluginSpec = { "nanozuki/tabby.nvim", config = configure, event = "VeryLazy" }

return M
