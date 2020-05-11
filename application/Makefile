BASE		= ..
OS 			:= $(shell uname)

LINKSTATIC 	= -static

TOOLS		= ./tools
SRC			= ./squeeze2raop
SQUEEZETINY	= ./squeezetiny

RAOP		= $(BASE)/RAOP-Player
VALGRIND	= $(BASE)/RAOP-Player/vendor/valgrind
MDNSSD		= $(BASE)/mDNS-SD
FETCHER		= $(BASE)/HTTP-Fetcher
TINYMDNS	= $(BASE)/TinySVCmDNS

DEFINES 	+= -DHAVE_STDINT_H -DRESAMPLE -DNDEBUG

vpath %.c $(TOOLS):$(SRC):$(RAOP)/src:$(SQUEEZETINY):$(MDNSSD):$(FETCHER)/src:$(TINYMDNS)

LIBRARY 		= $(OBJ)/alac_wrapper.o
LIBRARY_STATIC 	= $(LIBRARY) $(OBJ)/libfaad.a $(OBJ)/libsoxr.a $(OBJ)/libFLAC.a $(OBJ)/libmad.a 

INCLUDE = -I. -I/usr/include \
		  -I$(SQUEEZETINY) \
		  -I$(RAOP)/src \
                  -I$(RAOP)/vendor/curve25519/include \
		  -I$(TOOLS) \
		  -I$(SRC) -I$(SRC)/inc \
		  -I$(VALGRIND)/memcheck -I$(VALGRIND)/include \
		  -I/usr/local/include/upnp/ \
		  -I$(MDNSSD)\
		  -I$(BASE)/mpg123/src/libmpg123\
		  -I/usr/local/include/FLAC\
                  -I/usr/local/include/opus\
                  -I/usr/local/include/alac\
		  -I/usr/local/include\
		  -I$(BASE)/soxr/src\
		  -I$(FETCHER)/include\
		  -I$(TINYMDNS)\

DEPS	= $(SQUEEZETINY)/squeezedefs.h
		  
SOURCES = slimproto.c buffer.c stream.c utils.c pcm.c process.c resample.c \
		output.c decode.c output_pack.c output_raop.c  main.c util_common.c \
		raop_client.c rtsp_client.c aes.c aexcl_lib.c base64.c alac.c\
      	squeeze2raop.c util.c conf_util.c log_util.c \
		mdnssd-min.c \
		http_fetcher.c http_error_codes.c \
		mdns.c mdnsd.c vorbis.c opus.c sslsym.c
		
SOURCES_LIBS = mpg.c flac.c mad.c faad.c

CPP_SOURCES = alac_wrapper.cpp	
	
OBJECTS 		= $(patsubst %.c,$(OBJ)/%.o,$(SOURCES)) \
                          $(patsubst %.c,$(OBJ)/%.o,$(SOURCES_LIBS)) 

OBJECTS_STATIC 	= $(patsubst %.c,$(OBJ)/%.o,$(SOURCES)) $(patsubst %.c,$(OBJ)/%-static.o,$(SOURCES_LIBS)) 

all: $(EXECUTABLE) $(EXECUTABLE_STATIC)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) $(LIBRARY) $(LDFLAGS) -o $@

$(EXECUTABLE_STATIC): $(OBJECTS_STATIC)
	$(CC) $(OBJECTS_STATIC) $(LIBRARY_STATIC) $(LDFLAGS) $(LINKSTATIC) -o $@	

$(OBJECTS): $(DEPS) | bin $(OBJ)

$(OBJ):
	@mkdir -p $@
	
bin:	
	@mkdir -p bin

$(OBJ)/%.o : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(INCLUDE) $< -c -o $@

$(OBJ)/%-static.o : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -DLINKALL $(INCLUDE) $< -c -o $(OBJ)/$*-static.o	
	
clean:
	rm -f $(OBJECTS) $(OBJECTS_STATIC) $(EXECUTABLE) $(EXECUTABLE_STATIC)

