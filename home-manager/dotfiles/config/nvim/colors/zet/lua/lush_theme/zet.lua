local lush = require('lush')
local hsl = lush.hsl

local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    Normal       { fg = hsl("#00e963"), bg = hsl("#000000") },
    NormalNC     { fg = hsl("#00c753"), bg = hsl("#000000") },
    Cursor       { fg = hsl("#000000"), bg = hsl("#00ff63") },
    Visual       { bg = hsl("#005500") },
    ColorColumn  { bg = hsl("#001100") },
    CursorLine   { bg = hsl("#001100") },
    CursorColumn { bg = hsl("#001100") },
    LineNr       { fg = hsl("#008800"), bg = hsl("#000000") },
    CursorLineNr { fg = hsl("#ffffff"), bg = hsl("#001100") },

    StatusLine     { fg = hsl("#000000"), bg = hsl("#00ff63"), gui = "bold" },
    StatusLineNC   { fg = hsl("#00b000"), bg = hsl("#004400") },
    VertSplit      { fg = hsl("#00ff63"), bg = hsl("#000000") },
    WinSeparator   { fg = hsl("#00ff63"), bg = hsl("#000000") },

    Pmenu        { fg = hsl("#00ff63"), bg = hsl("#002200") },
    PmenuSel     { fg = hsl("#000000"), bg = hsl("#00ff63") },
    PmenuSbar    { bg = hsl("#004400") },
    PmenuThumb   { bg = hsl("#00ff63") },

    Comment      { fg = hsl("#007700"), gui = "italic" },
    Todo         { fg = hsl("#ffffff"), bg = hsl("#005500"), gui = "bold" },

    Constant     { fg = hsl("#00ffa9") },
    String       { fg = hsl("#00ffa9") },
    Character    { fg = hsl("#00ffa9") },
    Number       { fg = hsl("#00ff63") },
    Boolean      { fg = hsl("#00ff63") },
    Float        { fg = hsl("#00ff63") },

    Function     { fg = hsl("#00ff63") },
    Identifier   { fg = hsl("#00ff63") },
    Statement    { fg = hsl("#00e963") },
    Keyword      { fg = hsl("#00e963") },
    Operator     { fg = hsl("#00e963") },
    Type         { fg = hsl("#00ff63") },
    PreProc      { fg = hsl("#00d500") },
    Special      { fg = hsl("#00ffcc") },
    Underlined   { fg = hsl("#00ffcc"), gui = "underline" },

    MatchParen   { fg = hsl("#ffffff"), bg = hsl("#005500"), gui = "bold" },
    Search       { fg = hsl("#000000"), bg = hsl("#00ff63"), gui = "bold" },
    IncSearch    { fg = hsl("#000000"), bg = hsl("#00ffcc"), gui = "bold" },

    EndOfBuffer  { fg = hsl("#002200") },
    Whitespace   { fg = hsl("#004400") },
    Conceal      { fg = hsl("#006600") },

    DiagnosticError { fg = hsl("#ff0000") },
    DiagnosticWarn  { fg = hsl("#ffff00") },
    DiagnosticInfo  { fg = hsl("#00a088") },
    DiagnosticHint  { fg = hsl("#00ffcc") },

    DiffAdd      { fg = hsl("#00ff63"), bg = hsl("#001100") },
    DiffDelete   { fg = hsl("#ff0000"), bg = hsl("#110000") },
    DiffChange   { fg = hsl("#ffff00"), bg = hsl("#111100") },
    DiffText     { fg = hsl("#ffffff"), bg = hsl("#333300") },
}
end)
return theme
