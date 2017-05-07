#
#  Version 1.0
#

CXX=g++
CXXFLAGS=-std=c++11 -m64
BUILD=build
BIN=bin
STATICLIB=staticlib
EXT=ext

SRC= cpluslogger/src
VERSION=1_0

all: clean directories demo staticlib

directories:
	mkdir -p $(BUILD)/$(BIN)
	mkdir -p $(BUILD)/$(STATICLIB)
	mkdir -p $(BUILD)/$(EXT)

demo: Logger.o demo.o
	$(CXX) $(CXXFLAGS) $(BUILD)/$(EXT)/demo.o $(BUILD)/$(EXT)/Logger.o -o $(BUILD)/$(BIN)/demo

Logger.o: $(SRC)/Logger.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/Logger.cpp -o $(BUILD)/$(EXT)/Logger.o

demo.o: $(SRC)/demo.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/demo.cpp -o $(BUILD)/$(EXT)/demo.o

staticlib: $(BUILD)/$(EXT)/Logger.o
	ar -rv $(BUILD)/$(STATICLIB)/cpluslogger_$(VERSION).a $(BUILD)/$(EXT)/Logger.o

clean:
	rm -rf build
