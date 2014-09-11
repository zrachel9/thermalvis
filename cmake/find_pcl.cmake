find_package(PCL QUIET)
IF(PCL_FOUND)
	IF(CMAKE_SIZEOF_VOID_P EQUAL 8)
		STRING( FIND ${PCL_COMMON_LIBRARY} "32" APOSITION )
		IF (NOT "${APOSITION}" STREQUAL "-1")
			OPTION(USE_PCL "Build PCL-dependent functions." FALSE)
			MESSAGE(WARNING "This is a 64-bit build, and it looks like CMake actually found the 32-bit PCL libraries to link to! Therefore PCL has been excluded from the build.")
		ELSE()
			OPTION(USE_PCL "Build PCL-dependent functions." TRUE)
		ENDIF()
	ELSE()
		STRING( FIND ${PCL_COMMON_LIBRARY} "64" APOSITION ) 
		IF (NOT "${APOSITION}" STREQUAL "-1")
			OPTION(USE_PCL "Build PCL-dependent functions." FALSE)
			MESSAGE(WARNING "This is a 32-bit build, and it looks like CMake actually found the 64-bit PCL libraries to link to! Therefore PCL has been excluded from the build.")
		ELSE()
			OPTION(USE_PCL "Build PCL-dependent functions." TRUE)
		ENDIF()
	ENDIF()
ELSE()
	OPTION(USE_PCL "Build PCL-dependent functions." FALSE)
ENDIF()

IF(USE_PCL)
	FIND_PACKAGE( PCL COMPONENTS common io )
	IF(PCL_FOUND)
		MESSAGE(STATUS "PCL Found!")
		ADD_DEFINITIONS( -D_USE_PCL_ )
		INCLUDE_DIRECTORIES(${PCL_INCLUDE_DIRS})
		SET(ADDITIONAL_LIBRARIES ${ADDITIONAL_LIBRARIES} ${PCL_LIBRARIES})
	ELSE()
		MESSAGE(FATAL_ERROR "PCL not found! Much of the libraries can be built without PCL, however, so consider opting not to use it.")
	ENDIF()
	IF(CMAKE_SIZEOF_VOID_P EQUAL 8)
		STRING( FIND ${PCL_COMMON_LIBRARY} "32" APOSITION )
		IF (NOT "${APOSITION}" STREQUAL "-1")
			MESSAGE(WARNING "This is a 64-bit build, and it looks like CMake actually found the 32-bit PCL libraries to link to! This may cause compilation problems..")
		ENDIF()
	ELSE()
		STRING( FIND ${PCL_COMMON_LIBRARY} "64" APOSITION ) 
		IF (NOT "${APOSITION}" STREQUAL "-1")
			MESSAGE(WARNING "This is a 32-bit build, and it looks like CMake actually found the 64-bit PCL libraries to link to! This may cause compilation problems..")
		ENDIF()
	ENDIF()
ENDIF()