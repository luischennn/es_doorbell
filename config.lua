Config = {}

-- // Translations //

Config.Bell = "BELL"
Config.YouRang = "You rang the bell"
Config.SomeoneRang = "Someone rang the bell"
Config.Ring = "[E] - Ring"
Config.targetRing = 'Ring'
Config.Wait1 = "Wait another "
Config.Wait2 = " seconds"

-- activate if u wanna use ox_target
Config.target = true

-- // SETTINGS //

-- Put here the time the player needs to wait before he can ring again (in seconds)
Config.WaitingTime = 30

-- // BELLS //


Config.Bells = {

    {
        coords = vec3(433.6991, -985.7689, 30.7095),
        job = 'police',
        label = 'Poliisi'
    },

    {
        coords = vec3(297.9773, -587.2928, 43.2609),
        job = 'ambulance',
        label = 'Ensihoito'
    }           

}
