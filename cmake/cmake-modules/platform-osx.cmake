 #find_package ( OpenGL REQUIRED )
 set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu99 -D__APPLE__ -D__MACH__ -DMACOSX -DHAVE_MEMMOVE -D_FORTIFY_SOURCE=0 " )
 set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__APPLE__ -D__MACH__ -DMACOSX" )
 set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++" )