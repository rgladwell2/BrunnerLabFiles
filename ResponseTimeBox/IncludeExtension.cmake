###########################################################################
## $Id: IncludeExtension.cmake 4536 2013-08-05 14:30:13Z mellinger $
## Authors: Ryan Gladwell (gladwell@neurotechcenter.org)


if(WIN32)

SET( BCI2000_SIGSRC_FILES
   ${BCI2000_SIGSRC_FILES}
   ${BCI2000_EXTENSION_DIR}/ResponseTimeBox.cpp
   ${BCI2000_EXTENSION_DIR}/SerialPort.cpp
)

else()
  message("ResponseTimeBox: Only available on Windows")
endif()
