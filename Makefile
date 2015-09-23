#COMPILATEUR
CC=gcc

#NOM DE PROGRAMME
PROG=computePatchOpt

#FLAGS
CFLAGS= -std=c99 -Wall -Wextra -g 
FDFLAGS= -lm -lz 

#REPERTOIRES
SOURCE=src
OBJECT=obj
BIN=bin
INCLUDE=include
TEST=test
TEST_SOURCE=$(TEST)/src
TEST_OBJET=$(TEST)/obj

#TOUS LES FICHIERS .C
SRC=$(wildcard $(SOURCE)/*.c)
INC=$(wildcard $(INCLUDE)/*.h)

#TOUS LES FICHIERS .O
OBJ=$(SRC:$(SOURCE)/%.c=$(OBJECT)/%.o)
OBJwM=$(INC:$(INCLUDE)/%.h=$(OBJECT)/%.o) 

#TOUS LES FICHIERS TEST .C
T_SRC=$(wildcard $(TEST_SOURCE)/*.c)

#TOUS LES FICHIERS TEST .O
T_OBJ=$(T_SRC:$(TEST_SOURCE)/%.c=$(TEST_OBJET)/%.o)

#EXECTABLE TEST
T_EXE=$(T_OBJ:$(TEST_OBJET)/%.o=$(BIN)/%.exe)


#REGLES
$(PROG): $(OBJ) 
	$(CC) -o $(BIN)/$@ $^ $(CFLAGS) $(FDFLAGS)

$(OBJECT): 
	mkdir -p $@

$(OBJECT)/%.o: $(SOURCE)/%.c $(OBJECT) $(BIN) 
	$(CC) -o $@ -c $< -I $(INCLUDE) $(CFLAGS) $(FDFLAGS) 

$(BIN):
	mkdir -p $@


.PHONY: fichier
fichier:
	#@ echo "FICHIER"
	#@ echo $(SRC)
	#@ echo $(OBJwM)
	#@ echo $(INC)
	#@ echo "TEST"
	#@ echo $(T_SRC)
	@ echo $(T_OBJ)
	#@ echo $(T_EXE)

.PHONY: test
test: $(T_EXE)

$(BIN)/%.exe: $(TEST_OBJET)/%.o $(OBJwM) 
	$(CC) -o $@ $^ $(CFLAGS) $(FDFLAGS)

$(TEST_OBJET):
	mkdir -p $@

$(TEST_OBJET)/%.o: $(TEST_SOURCE)/%.c |$(TEST_OBJET) 
	$(CC) -o $@ -c $< $(CFLAGS) $(FDFLAGS)

.PHONY: clean
clean:
	rm -r -f $(OBJECT) $(BIN)/$(PROG) $(T_EXE) $(TEST_OBJET) $(BIN)

.PHONY: all
all: test $(PROG)

