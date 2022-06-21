let s:SchemeName = 'ayu'
let s:AirlineTheme = 'ayu'

let s:ChangeAirline = 0

exec 'colorscheme ' . s:SchemeName

if(s:ChangeAirline)
  if(exists(":AirlineTheme"))
    let g:airline_theme = s:AirlineTheme
  endif
endif
