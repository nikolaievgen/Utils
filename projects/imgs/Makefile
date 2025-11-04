SHELL := /bin/bash
LINT_TARGET := src/
MYPY_TARGET := src/
DIR := .

.PHONY: all
all: format lint test

.PHONY: clean
clean:
	@rm -rf build dist
	@rm -rf `find . -type d -name __pycache__`
	@rm -f `find . -type f -name '*.py[co]'`
	@rm -rf `find . -type d -name .pytest_cache`
	@rm -rf `find . -type d -name .mypy_cache`
	@rm -rf *.egg-info
	@rm -f .make-*
	@rm -rf htmlcov
	@rm -f .coverage
	@rm -f .coverage.*


.PHONY: pip-clean
pip-clean:
	@pip freeze --disable-pip-version-check | grep -v '^-' | cut -d'=' -f1 | xargs pip uninstall -y
	@pip freeze --disable-pip-version-check | grep '^-e' | grep -io 'egg=[0-9a-z_.-]\+' | cut -d'=' -f2 | xargs pip uninstall -y


.make-check-poetry-installed:
	@if ! command -v poetry &> /dev/null; then \
		echo "You need install poetry first"; \
		exit 1; \
	fi
	@touch $@


.PHONY: devel
devel: pyproject.toml .make-check-poetry-installed
	poetry run pip install -U pip setuptools
	if ! poetry check --lock &> /dev/null; then \
		poetry lock; \
	fi
	poetry install


.PHONY: format
format: isort black


.PHONY: black
black:
	@black ${LINT_TARGET}


.PHONY: isort
isort:
	@isort ${LINT_TARGET}


.PHONY: lint
lint: isort-check black-check flake mypy


.PHONY: black-check
black-check:
	@python -m black --check --diff ${LINT_TARGET}


.PHONY: flake
flake:
	@python -m flake8 --statistics ${LINT_TARGET}


.PHONY: isort-check
isort-check:
	@python -m isort --check --diff ${LINT_TARGET}


.PHONY: mypy
mypy:
	@python -m mypy ${MYPY_TARGET}


.poetry-requirements:
	@poetry export -f requirements.txt --without-hashes | grep -Ev -- '(^#|^-|^setuptools)' | sed 's/ ;.*$$//g' | sed '/^$$/d'


.PHONY: requirements
requirements: pyproject.toml .make-check-poetry-installed
	@$(MAKE) -s .poetry-requirements


.PHONY: requirements-%.txt
requirements-%.txt: pyproject.toml .make-check-poetry-installed
	$(MAKE) -s .poetry-requirements > $@

test:
	@pytest -qs tests

.PHONY: dir-names
dir-names:
	python -m src.imgs.utils.dir_names $(DIR)
