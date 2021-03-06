register_command(timeremnant, 
    array(
        description: 'Power',
        permission: 'powers.timeremnant',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)
            }
            
            @player = player()

            @oldMobs = import(@player.'timeRemnant')
            if(is_array(@oldMobs)){
                foreach(@mob in @oldMobs){
                    try(entity_remove(@mob),continue())
                }
            }

            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@player)            
            @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
            @hero = yml_decode(@contents)
            @sig = @hero['sig']
            @val = @hero['val']

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('timeRemnant',1,@player)

            @mobUUIDs = spawn_mob('villager',1)
            export(@player.'timeRemnant',@mobUUIDs)
            set_timeout(50,closure(
                runas(~console,"/disguiseplayer ".@mobUUIDs[0].' player '.@player.' setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
            ))
            
        }
    )
)
