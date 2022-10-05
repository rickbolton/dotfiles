local status, nvimTree = pcall(require, "nvim-tree")
if (not status) then return end

nvimTree.setup()
