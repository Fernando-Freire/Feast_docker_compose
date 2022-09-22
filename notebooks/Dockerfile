# Use Python 3.10-slim
FROM python:3.10.4 AS base

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=off \
    POETRY_VERSION=1.1.13 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_CACHE_DIR=/usr/src/poetry_cache/ \
    JUPYTER_HOST="0.0.0.0" \
    JUPYTER_PORT="8888" \
    JUPYTER_GROUP="jovyan" \
    JUPYTER_USER="jovyan" \
    JUPYTER_HOME_DIR="/home/jovyan" \
    JUPYTER_NB_DIR="/usr/src/notebooks"

# Work directory inside container
WORKDIR ${JUPYTER_NB_DIR}

# Install Poetry
RUN pip install "poetry==$POETRY_VERSION"

# Install Packages
COPY pyproject.toml poetry.lock ./
#RUN poetry update
RUN poetry install  --no-interaction --no-ansi --no-root --no-dev 

# Add all notebooks to the container
ADD ./ ./


# Build arguments to set non-root user
ARG USER_ID=1000
ARG GROUP_ID=1000

# Create non-root user jovyan and give appropriate permissions
RUN groupadd -g ${GROUP_ID} ${JUPYTER_GROUP} \
  && useradd -u ${USER_ID} -g ${JUPYTER_GROUP} ${JUPYTER_USER} \
  && mkdir ${JUPYTER_HOME_DIR} \
  && chown ${USER_ID}:${GROUP_ID} ${JUPYTER_HOME_DIR} ${JUPYTER_NB_DIR}

# Set non-root user jovyan to run JupyterLab
USER ${USER_ID}:${GROUP_ID}

# Expose JupyterLab to outside the container
EXPOSE ${JUPYTER_PORT}

# By default, execute JupyterLab
CMD jupyter notebook --ip ${JUPYTER_HOST} --port ${JUPYTER_PORT} --no-browser --notebook-dir ${JUPYTER_NB_DIR}
