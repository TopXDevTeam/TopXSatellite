fx_version 'cerulean'
games { 'gta5' }
lua54 "yes"

author 'TopX Team'

ui_page 'html/index.html'

files {
	'html/*'
}

client_scripts {
	'client.lua',
}

shared_scripts {
	'config.lua'
}

server_scripts {
	'server.lua'
}

escrow_ignore {
	'config.lua'
}
