workspace "Azure Deployment Diagram" "Description" {
    model {
        cats = softwaresystem "CATS" "Description"
        loadBalancer = softwaresystem "Load Balancer" "Description"

        e1 = enterprise "South Central Zone"{
            catsAPI = softwaresystem "Cats API" "Desc"
            catsOnPrem = softwaresystem "Cats OnPrem" "desc"
            catsCron = softwaresystem "Cats Cron" "desc"
            catsALEF = softwaresystem "Cats ALEF" "desc"

            # relationships
            loadBalancer -> catsAPI "Description"
            loadBalancer -> catsOnPrem "Description"
            loadBalancer -> catsCron "Description"
            loadBalancer -> catsALEF "Description"
            
        }

        e2 = enterprise "Eastern Zone"{
            replica_catsAPI = softwaresystem "Replica CatsAPI" "a"
            replica_catsOnPrem = softwaresystem "Replica catsOnPrem" "a"
            replica_catsCron = softwaresystem "Replica catsCron" "a"
            replica_catsALEF = softwaresystem "Replica catsALEF" "a"

            # relationships
            catsAPI -> replica_catsAPI "Description"
            catsOnPrem -> replica_catsOnPrem "Description"
            catsCron -> replica_catsCron "Description"
            catsALEF -> replica_catsALEF "Description"
        }
        
        # Our Database and SSIS tools to communicate with client's Software        
        catsDB = softwaresystem "CATS DB" "MS SQL"
        replica_catsDB = softwaresystem "Replica of CATS DB" "MS SQL"
        ssis = softwaresystem "SSIS" "ETL"
        our_abs = softwaresystem "Our ABS" "desc"

        # Client's Softwares
        client_ABS = softwaresystem "Client ABS"
        kiteworks = softwaresystem "Kiteworks"
        client_DB = softwaresystem "Client DB"

        # Sharepoint and Logic App
        sharePoint_and_logicApp = softwaresystem  "SharePoint and Logic App" {
            docxLogicApp = container  "Logic App that creates Word File"
            toPdfLogicApp = container  "Logic App that converts to PDF"
            sharePoint = container  "SharePoint"

            catsAPI -> docxLogicApp " "
            catsAPI -> toPdfLogicApp " "
        }

        # Relationship of Replica CATS to Replica DB
        replica_catsAPI -> replica_catsDB " "

        # relationships of UI and Load Balancer
        cats -> loadBalancer "Description"

        # relationships of Our DB to Client's DB
        catsAPI -> catsDB " "
        client_ABS -> client_DB " "
        client_DB -> SSIS " "
        ssis -> catsDB "send data"
        client_ABS -> catsAPI "Real Time Read"
        catsAPI -> client_ABS "Real Time Write",

        catsDB -> kiteworks ""
        catsOnPrem -> our_ABS ""
        our_ABS -> kiteworks ""
        
    }

    views {
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }
    }
}