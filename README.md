# RoboChart textual editor [![wercker status](https://app.wercker.com/status/06bd33b926dc5acffc73ce5e381fe9ca/s/master "wercker status")](https://app.wercker.com/project/byKey/06bd33b926dc5acffc73ce5e381fe9ca)
This repository contains the plugins for the RoboChart textual editor

### Development platform requirements ###

* Eclipse 2021-12
* Sirius SE 6.5.1 and Xtext SDK 2.25.0 (can be found in the repository in http://download.eclipse.org/releases/2021-12 under Modeling).
* Maven
* Git

### Build (maven) ###

        1. mvn clean install

### Build (eclipse)  ###
        Note: not tested! (for now use maven build only)
        
        1. Right click circus.robocalc.robochart.textual/src/circus.robocalc.robochart.textual/GenerateRoboChart.mwe2
            1. select 'Run As' > 'MWE2 Workflow'

### Run (eclipse) ###

        1. Right click circus.robocalc.robochart.textual.parent
            1. select 'Run As'
            2. double click 'Eclipse Application'
        2. Select the new configuration
            1. click 'Run'
            
### Protocol for updating the tool ###

Whenever updating the tool, follow these steps:

        1. Perform regression testing
        2. Change the language reference manual
        3. Change the tool manual

If changes to documentations are not possible immediately, create issues indicating exactly what needs to be done.
