# Use this script -- or some tweaked version of it -- to push the code
# to shinyapps.io. Comment out the deployApp() call that you do NOT 
# want to run. This script requires having rsconnect installed, as well
# as having authenticated with a shinyapps.io 

library(rsconnect)

# Deploy MDE-based calculator
deployApp(appFiles = c("test-result-simulator.Rmd","styles.css", "logo-sm.png", "favicon.png", "tracking.html"),
          appName = "test-simulator",
          appTitle = "A/B Test Result Simulator")