@{
    AllNodes = 
    @(
        @{
            NodeName = 'MRHOMHUB02'
            Role = 'Base'
        },

        @{
            NodeName = 'MRHOMADS03'
            Role = 'Base','DomainController'
        }
    )
}