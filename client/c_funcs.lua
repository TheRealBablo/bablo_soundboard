SoundBoard = {
    distance = 5
};


function SoundBoard:Menu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
        title = 'Soundboard',
        align = 'right',
        elements = {
            { label = 'Ljud', action = 'sounds' },
            { label = ('distans: <span style="color:lightgreen">%s</span>'):format(self.distance), action = 'distance' },
            { label = 'Stoppa ljud', action = 'stopSound' },
        }
    }, function(data, menu)
        local action = data.current.action

        if action == 'sounds' then
            menu.close()

            self:soundList()
        elseif action == 'distance' then
            menu.close()

            AddTextEntry('NEWTEXT', 'Ange en distans (inget mer än 15)')
                DisplayOnscreenKeyboard(1, 'NEWTEXT', '', '5', '', '', '', 30)

                while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                    DisableAllControlActions(0)
                    Citizen.Wait(0)
                end
            
                local result = GetOnscreenKeyboardResult()

                if not tonumber(result) or tonumber(result) <= 0 or tonumber(result) > 15 then
                    return ESX.ShowNotification('felaktig siffra') 
                end

                self.distance = tonumber(result)
                self:Menu()
        elseif action == 'stopSound' then
            TriggerServerEvent('InteractSound_SV:stopSoundWithinDistance', self.distance)
        end

    end, function(data, menu)
        menu.close()
    end)
end

function SoundBoard:soundList()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sound', {
        title = 'Soundboard',
        align = 'right',
        elements = Config.Sounds
    }, function(data, menu)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', self.distance, data.current.sound, 0.4)
    end, function(data, menu)
        menu.close()
    end)
end
