" let s:libpath = expand('%:p:h:h') . '/lib/'
" let s:ColorSchemesFile = s:libpath . 'colorschemes.vim'
"
" exec 'so ' . s:ColorSchemesFile

let s:schemesWithPaths = globpath(&rtp, 'colors/*.vim')
let s:schemes = split(s:schemesWithPaths)

let s:schemesNames = []
for scheme in s:schemes
  let fileName = split(scheme, '/')[-1]
  call add(s:schemesNames, split(fileName, '.vim')[0])
endfor

let s:Schemes = {
\  'name': 'my colorschemes',
\  'PreviewSchemeKey': '<space>',
\  'ToggleSchemes': '<c-t>',
\  'ApplyColorScheme': '<c-a>',
\  'open': 0
\ }

let g:Schemes = s:Schemes

function s:Schemes.SetColorScheme(theme)
  exec 'colorscheme ' . a:theme
endfunction

function s:Schemes.PreviewTheme()
  if(!self.IsPluginBuffer())
    return
  endif

  let themeName = getline('.')
  call self.SetColorScheme(themeName)
endfunction

function s:Schemes.IsPluginBuffer()
  return bufname('') =~# self.name
endfunction

function s:Schemes.Buffer()
  return '25vnew ' . self.name
endfunction

let s:currentScheme = g:colors_name

function s:Schemes.ToggleBox()
  if(!self.open)
    call self.OpenBox()
  else
    call self.CloseBox()
  endif
endfunction

function s:Schemes.OpenBox()
  let s:currentScheme = g:colors_name
  exec self.Buffer()

  setlocal noreadonly modifiable

  silent 1,$delete _
  silent! put = s:schemesNames
  silent 1,1delete _

  setlocal readonly nomodifiable

  exec 'nnoremap <buffer> <silent> ' . g:Schemes.PreviewSchemeKey . ' :call g:Schemes.PreviewTheme()<cr>'
  exec 'nnoremap <buffer> <silent> ' . g:Schemes.ApplyColorScheme . ' :call g:Schemes.SetAirline()<cr>'

  let self.open = 1
endfunction

function s:Schemes.SetAirline()
  exec 'AirlineTheme ' . getline('.')
endfunction

function s:Schemes.CloseBox()
  let self.open = 0

  call self.SetColorScheme(s:currentScheme)
  exec 'bd! ' . self.name
endfunction

exec 'nnoremap <silent> ' . g:Schemes.ToggleSchemes . ' :call g:Schemes.ToggleBox()<cr>'
