fx_version 'cerulean'
game 'gta5'

client_script {
    'client/*.lua',
}

server_script {
    '@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
    'server/*.lua',
}

shared_script {
    'config.lua'
}