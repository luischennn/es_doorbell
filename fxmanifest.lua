fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'ElmoScripting'
version '1.0 OX'
  
shared_scripts {
  '@ox_lib/init.lua',
  '@es_extended/imports.lua',
  'config.lua',
} 

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/server.lua',
}

client_scripts {
  'client/client.lua',
}

dependencies {
	'es_extended',
	'ox_lib'
}