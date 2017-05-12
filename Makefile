#
#  Version 1.0
#
PROJECT=cpluslogger
VERSION=1.0

CXX=g++
CXXFLAGS=-std=c++11 -m64

BUILD=build
BIN=bin
LIB=lib
EXT=ext

SRC= $(PROJECT)/src
TARGETSHARED = $(PROJECT).so.1.0
TARGETSTATIC = $(PROJECT).$(VERSION).a

all: directories demo shared static

directories:
	mkdir -p $(BUILD)/$(BIN)
	mkdir -p $(BUILD)/$(LIB)
	mkdir -p $(BUILD)/$(EXT)

demo: Logger.o demo.o
	$(CXX) $(CXXFLAGS) $(BUILD)/$(EXT)/demo.o $(BUILD)/$(EXT)/Logger.o -o $(BUILD)/$(BIN)/demo$(PROJECT).$(VERSION)

Logger.o: $(SRC)/Logger.cpp
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/Logger.cpp -o $(BUILD)/$(EXT)/Logger.o

demo.o: $(SRC)/demo.cpp
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/demo.cpp -o $(BUILD)/$(EXT)/demo.o

static: $(BUILD)/$(EXT)/Logger.o
	ar -rv $(BUILD)/$(LIB)/lib$(TARGETSTATIC) $(BUILD)/$(EXT)/Logger.o

shared: Logger.o
	$(CXX) $(CXXFLAGS) $(LDLIBSOPTIONS) -Wall -shared -Wl,-soname, $(BUILD)/$(EXT)/Logger.o -o $(BUILD)/$(LIB)/lib$(TARGETSHARED)

clean:
	rm -rf build
