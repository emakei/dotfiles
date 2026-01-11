-- Установка опций по умолчанию
vim.opt.number = true -- Показать номера строк
vim.opt.relativenumber = true -- Относительные номера строк

-- Установка клавиши <leader>
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Настройка раскладки клавиш (mapping)
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })

-- Включение подсветки синтаксиса
vim.cmd('syntax on')
