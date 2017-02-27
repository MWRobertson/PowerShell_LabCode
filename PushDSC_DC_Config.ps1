Configuration DCConfig {
    node localhost{
        WindowsFeature DSCService
        {
            Name = "DSC-Service"
            Ensure = "Present"
        }
    }
}

DCConfif -Output ".\DSCConfigs"