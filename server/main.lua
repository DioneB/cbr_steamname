AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	deferrals.defer()
	local _source = source
		
	deferrals.update('Validando seu Nickname da Steam . . .')
	Citizen.Wait(100)
	
	local playerName = GetPlayerName(_source)
	local allowed    = true
	local reason     = nil
	
	if playerName == nil then
		playerName = 'unknown'
		reason = 'nome do jogador desconhecido, aguarde até tentar se conectar novamente'
		allowed = false
	end
	
	local nameLength = string.len(playerName)

	local count = 0
	for i in playerName:gmatch("[abcdefghijklmnopqrstuvwxyzåäöêABCDÊEFGHIJKLMNOPQRSTUVWXYZÅÄÖ0123456789 '_-]") do
		count = count + 1
	end
	if count ~= nameLength then
		if reason == nil then
			reason = 'Seu nome de jogador contém caracteres especiais que não são permitidos neste servidor.'
		end
		allowed = false
	end
	
	local spacesInName    = 0
	local spacesWithUpper = 0
	for word in string.gmatch(playerName, '%S+') do
	
		if string.match(word, '%u') then
			spacesWithUpper = spacesWithUpper + 1
		end
	
		spacesInName = spacesInName + 1
	end
	
	if allowed then
		deferrals.done()
	else
		deferrals.done('🚫Erro: Você não pode se conectar com seu Nick da Steam atual.\n📌Razão: ' .. reason .. '\n📬Info: Se você acredita que algo está errado, entre em contato com a equipe do CBR')
	end
end)
