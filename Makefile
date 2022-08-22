#include .env

################################################################################
##                                   COMMANDS                                 ##
################################################################################

MAKE += --no-print-directory RECURSIVE=1

ifndef VERBOSE
COMPOSE := docker-compose 2>/dev/null
COMPOSE_BUILD := $(COMPOSE) build -q
else
COMPOSE := docker-compose
COMPOSE_BUILD := $(COMPOSE) build
endif


################################################################################
##                                   COLORS                                   ##
################################################################################

RES := \033[0m
MSG := \033[1;36m
ERR := \033[1;31m
SUC := \033[1;32m
WRN := \033[1;33m
NTE := \033[1;34m

################################################################################
##                                 AUXILIARY                                  ##
################################################################################

# Variable do allow is-empty and not-empty to work with ifdef/ifndef
export T := 1

define is-empty
$(strip $(if $(strip $1),,T))
endef

define not-empty
$(strip $(if $(strip $1),T))
endef

define message
printf "${MSG}%s${RES}\n" $(strip $1)
endef

define success
(printf "${SUC}%s${RES}\n" $(strip $1); exit 0)
endef

define warn
(printf "${WRN}%s${RES}\n" $(strip $1); exit 0)
endef

define failure
(printf "${ERR}%s${RES}\n" $(strip $1); exit 1)
endef

define note
(printf "${NTE}%s${RES}\n" $(strip $1); exit 0)
endef

wait-%:
	@sleep $*


################################################################################
##                                DOCKER BUILD                                ##
################################################################################


build:
	@$(call message,"Construindo imagem do feast")
	@$(COMPOSE_BUILD)


################################################################################
##                               LINT & FORMAT                                ##
################################################################################

isort:
	@$(call message,"Rodando isort")
	@$(COMPOSE) run -T --rm --entrypoint isort feast_ui .

black:
	@$(call message,"Rodando black")
	@$(COMPOSE) run -T --rm --entrypoint black feast_ui .

autoflake:
	@$(call message,"Rodando autoflake")
	@$(COMPOSE) run -T --rm --entrypoint autoflake feast_ui \
		--in-place --remove-all-unused-imports --remove-unused-variables \
		--ignore-init-module-imports --expand-star-imports --recursive \
		.

flake8:
	@$(call message,"Rodando flake8")
	@$(COMPOSE) run -T --rm --entrypoint flake8 feast_ui .

lint:
	@$(MAKE) flake8

format:
	@$(MAKE) black
	@$(MAKE) isort
	@$(MAKE) autoflake


################################################################################
##                                RUN FEAST                                   ##
################################################################################

serve:
	@$(call message,"Iniciando Feast")
	@$(COMPOSE) up 

################################################################################
##                               RUN TASKS                                    ##
################################################################################

apply:
	@$(MAKE) format
	@$(MAKE) lint
	@$(call message,"Aplicando Feast")
	@$(COMPOSE) run --rm feast_ui feast apply

start:
	@$(MAKE) build
	@$(MAKE) apply
	@$(MAKE) serve

stop:
	@$(call message,"Desligando tudo")
	@$(COMPOSE) down
