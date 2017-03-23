Configuration WidgetConfig {

    Node localhost {

        WindowsFeature DSCService
        {
            Name = "DSC-Service"
            Ensure = "Present"
        }

        File WidgetDir
        {
            Type    = "Directory"
            DestinationPath = "C:\WidgetInit"
            Ensure = "Present"
        }

    }
}

WidgetConfig -Output "$ModulePathLib\WidgetInit"