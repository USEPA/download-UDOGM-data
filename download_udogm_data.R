#
#
#
#
#       the purpose is to downoald the udogm data from:
#       https://oilgas.ogm.utah.gov/oilgasweb/data-center/dc-main.xhtml
#
#
#
#
#

# system.time({

library(tidyverse)
library(lubridate)
library(readr)

udogm_data_pull <- function(url, file){
    temp <- tempfile()
    download.file(url, temp)
    data <- read.csv(unz(temp, file),
                     stringsAsFactors = F,
                     # na.strings = 'NULL',
                     colClasses = 'character')
    unlink(temp)
    as_tibble(data)
    Sys.sleep(20)    # downloads keep timing out, may be getting throttled
}

##  the file on the UDOGM server had a weird character that doesn't allow the full download of the data.  use the csv method until the isue is resolved
wells <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Wells.zip',
                         "Wells.csv")

# wells <- read.csv("wells.csv", stringsAsFactors = F, colClasses = 'character')

wells_history <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/WellHistory.zip',
                                 'WellHistory.csv')

production <- do.call('rbind',

                      list(

    udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Production1984To1998.zip',
                    'Production1984To1998.csv'),

    udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Production1999To2008.zip',
                    'Production1999To2008.csv'),

    udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Production2009To2014.zip',
                    'Production2009To2014.csv'),

    udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Production2015To2019.zip',
                    'Production2015To2019.csv'),

    udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Production2020To2024.zip',
                    'Production2020To2024.csv')
                      )
                            )


disposition <- do.call('rbind',

                        list(

          udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Disposition1984To1998.zip',
                          'Disposition1984To1998.csv'),

          udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Disposition1999To2008.zip',
                          'Disposition1999To2008.csv'),

          udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Disposition2009To2014.zip',
                          'Disposition2009To2014.csv'),

          udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Disposition2015To2019.zip',
                          'Disposition2015To2019.csv'),

          udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Disposition2020To2024.zip',
                          'Disposition2020To2024.csv')
      )
)

entities <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Entities.zip',
                                 'Entities.csv')

fields <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Fields.zip',
                            'Fields.csv')

operators <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/Operators.zip',
                          'Operators.csv')

producing_zones <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/ProducingZones.zip',
                             'ProducingZones.csv')

plant_summary <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/PlantSummary.zip',
                                   'PlantSummary.csv')

plant_prod <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/PlantProd.zip',
                                 'PlantProd.csv')

plant_well_alloc <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/PlantWellAlloc.zip',
                              'PlantWellAlloc.csv')

plant_location <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/PlantLocation.zip',
                                    'PlantLocation.csv')

plant_operators <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/PlantOperators.zip',
                                  'PlantOperators.csv')

lat_long_coordinates <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/LatLongCoordinates.zip',
                                   'LatLongCoordinates.csv')

utm_coordinates <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/UTMCoordinates.zip',
                                        'UTMCoordinates.csv')

uic_project_injection_vols <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/UICProjectVols.zip',
                                   'UICProjectVols.csv')

uic_disposal_vols <- udogm_data_pull('https://oilgas.ogm.utah.gov/pub/Database/UICWDWVols.zip',
                                    'UICWDWVols.csv')

# })
#
# current_file_name <- paste('udogm as of', Sys.Date(), sep = '_')
# dput(current_file_name, 'current_file_name')
#
# save(list = ls(),
#      file = current_file_name)

#####
## tables output as csv

dir.create("./dataOut")
setwd("./dataOut")

write_csv(disposition, paste('disposition',
                              Sys.Date(), '.csv', sep = ""))
write_csv(entities, paste('entities',
                              Sys.Date(), '.csv', sep = ""))
write_csv(fields, paste('fields',
                              Sys.Date(), '.csv', sep = ""))
write_csv(lat_long_coordinates, paste('lat_long_coordinates',
                              Sys.Date(), '.csv', sep = ""))
write_csv(operators, paste('operators',
                              Sys.Date(), '.csv', sep = ""))
write_csv(plant_location, paste('plant_location',
                              Sys.Date(), '.csv', sep = ""))
write_csv(plant_operators, paste('plant_operators',
                              Sys.Date(), '.csv', sep = ""))
write_csv(plant_prod, paste('plant_prod',
                              Sys.Date(), '.csv', sep = ""))
write_csv(plant_summary, paste('plant_summary',
                              Sys.Date(), '.csv', sep = ""))
write_csv(plant_well_alloc, paste('plant_well_alloc',
                              Sys.Date(), '.csv', sep = ""))
write_csv(producing_zones, paste('producing_zones',
                              Sys.Date(), '.csv', sep = ""))
write_csv(production, paste('production',
                              Sys.Date(), '.csv', sep = ""))
write_csv(uic_disposal_vols, paste('uic_disposal_vols',
                              Sys.Date(), '.csv', sep = ""))
write_csv(uic_project_injection_vols, paste('uic_project_injection_vols',
                              Sys.Date(), '.csv', sep = ""))
write_csv(utm_coordinates, paste('utm_coordinates',
                              Sys.Date(), '.csv', sep = ""))
write_csv(wells, paste('wells',
                              Sys.Date(), '.csv', sep = ""))
write_csv(wells_history, paste('wells_history',
                              Sys.Date(), '.csv', sep = ""))
