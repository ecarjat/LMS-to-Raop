cmake_minimum_required(VERSION 3.10)

# set the project name
project(LMS-to-Raop)

#define variables
set(CMAKE_VERBOSE_MAKEFILE TRUE)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")
set(TINY TinySVCmDNS)
set(MDNS mDNS-SD)
set(SQUEEZE2RAOP application/squeeze2raop)
set(SQUEEZETINY application/squeezetiny)
set(TOOLS application/tools)
set(RAOPPLAYER RAOP-Player)
set(VALGRIND ${RAOPPLAYER}/vendor/valgrind)
set(HTTPFETCHER HTTP-Fetcher)
set(CURVE25519 ${RAOPPLAYER}/vendor/curve25519)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wno-multichar -Wno-unused-but-set-variable -fPIC")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")


# add the executable
add_executable(squeeze2raop 
          ${SQUEEZETINY}/slimproto.c
		  ${SQUEEZETINY}/buffer.c
		  ${SQUEEZETINY}/stream.c
		  ${SQUEEZETINY}/utils.c
		  ${SQUEEZETINY}/pcm.c
		  ${SQUEEZETINY}/process.c
		  ${SQUEEZETINY}/resample.c
		  ${SQUEEZETINY}/output.c
		  ${SQUEEZETINY}/decode.c
		  ${SQUEEZETINY}/output_pack.c
		  ${SQUEEZETINY}/output_raop.c
		  ${SQUEEZETINY}/main.c
		  ${SQUEEZETINY}/util_common.c
		  ${SQUEEZETINY}/alac.c
		  ${SQUEEZETINY}/vorbis.c
		  ${SQUEEZETINY}/opus.c
		  ${SQUEEZETINY}/flac.c
		  ${SQUEEZETINY}/mpg.c
		  ${SQUEEZETINY}/mad.c
		  ${SQUEEZETINY}/faad.c
		  ${RAOPPLAYER}/src/raop_client.c
		  ${RAOPPLAYER}/src/rtsp_client.c
		  ${RAOPPLAYER}/src/aes.c
		  ${RAOPPLAYER}/src/aexcl_lib.c
		  ${RAOPPLAYER}/src/base64.c
		  ${RAOPPLAYER}/src/aes_ctr.c
		  ${RAOPPLAYER}/src/alac_wrapper.cpp
		  ${TOOLS}/log_util.c
		  ${TOOLS}/sslsym.c
		  ${SQUEEZE2RAOP}/squeeze2raop.c 
		  ${SQUEEZE2RAOP}/util.c 
		  ${SQUEEZE2RAOP}/conf_util.c
		  ${HTTPFETCHER}/src/http_fetcher.c
		  ${HTTPFETCHER}/src/http_error_codes.c
          )
		  
add_compile_definitions(HAVE_STDINT_H RESAMPLE NDEBUG LINKALL)

add_library(TinySVCmDNS ${TINY}/mdns.c ${TINY}/mdnsd.c)
target_link_libraries(squeeze2raop TinySVCmDNS )

add_library(mDNS-SD  ${MDNS}/mdnssd-min.c ${MDNS}/mdnssd.c)
target_link_libraries(squeeze2raop mDNS-SD  )


#Add threads
find_package (Threads REQUIRED)
target_link_libraries(squeeze2raop ${CMAKE_THREAD_LIBS_INIT})

#add UPNP
find_package(LibUpnp REQUIRED)
if(NOT UPNP_FOUND)
    message(ERROR "UPNP Not Found")
endif()

if (NOT UPNP_HAS_REUSEADDR)
    message(WARNING "\n !! It is strongly recommended to build libupnp with --enable-reuseaddr !!")
endif()
include_directories(${UPNP_INCLUDE_DIRS})
target_link_libraries(squeeze2raop ${UPNP_LIBRARIES})

#add OggVorbis
find_package(OggVorbis REQUIRED)
include_directories(${VORBIS_INCLUDE_DIR})
target_link_libraries(squeeze2raop ${OGGVORBIS_LIBRARIES})

#Add Opus
find_package(Opus REQUIRED)
include_directories(${OPUS_INCLUDE_DIRS})
target_link_libraries(squeeze2raop ${OPUS_LIBRARIES})

#Add OpenSSL
find_package(OpenSSL REQUIRED)
target_link_libraries(squeeze2raop OpenSSL::Crypto)

#Add Alac
find_package(Alac REQUIRED)
include_directories(${ALAC_INCLUDE_DIRS})
target_link_libraries(squeeze2raop ${ALAC_LIBRARIES})

#Add md
find_package(Md REQUIRED)
include_directories(${MD_INCLUDE_DIRS})
target_link_libraries(squeeze2raop ${MD_LIBRARIES})

#Add soxr
find_package(Soxr REQUIRED)
include_directories(${SOXR_INCLUDE_DIRS})
target_link_libraries(squeeze2raop ${SOXR_LIBRARIES})

#Add FLAC
find_package(Flac REQUIRED)
target_include_directories(squeeze2raop PUBLIC ${FLAC_INCLUDE_DIRS})
target_link_libraries(squeeze2raop ${FLAC_LIBRARIES})

#Add Mad
find_package(Mad REQUIRED)
include_directories(${MAD_INCLUDE_DIRS})
target_link_libraries(squeeze2raop ${MAD_LIBRARIES})

#Add Faad
find_package(Faad REQUIRED)
include_directories(${FAAD_INCLUDE_DIRS})
target_link_libraries(squeeze2raop ${FAAD_LIBRARIES})


#add_library(curve25519 STATIC IMPORTED)
#set_target_properties(curve25519 PROPERTIES IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/${CURVE25519}/source/build64/libcurve25519.a)
add_library(curve25519 	${CURVE25519}/source/curve25519_mehdi.c 
						${CURVE25519}/source/curve25519_order.c
						${CURVE25519}/source/curve25519_utils.c
						${CURVE25519}/source/curve25519_dh.c
						${CURVE25519}/source/ed25519_sign.c
						${CURVE25519}/source/ed25519_verify.c
						${CURVE25519}/source/sha512.c
						${CURVE25519}/source/custom_blind.c
)
target_include_directories (curve25519 PUBLIC "${CURVE25519}/include")
target_link_libraries(squeeze2raop curve25519)


target_include_directories (squeeze2raop PUBLIC "${CURVE25519}/include")
target_include_directories (squeeze2raop PUBLIC "${VALGRIND}/include")
target_include_directories (squeeze2raop PUBLIC "${VALGRIND}/memcheck")
target_include_directories (squeeze2raop PUBLIC "${SQUEEZE2RAOP}/inc")
target_include_directories (squeeze2raop PUBLIC "${RAOPPLAYER}/src")
target_include_directories (squeeze2raop PUBLIC "${SQUEEZETINY}")
target_include_directories (squeeze2raop PUBLIC "${SQUEEZETINY}")
target_include_directories (squeeze2raop PUBLIC "${TOOLS}")
target_include_directories (squeeze2raop PUBLIC "${TINY}")
target_include_directories (squeeze2raop PUBLIC "${MDNS}")
target_include_directories (squeeze2raop PUBLIC "${HTTPFETCHER}/include")




