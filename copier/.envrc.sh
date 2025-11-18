# File that get the copier answers in a bash format
# source by envrc

export ORGANISATION_NAME="{{ organisation_name }}"
# Name used in env
export ORGANISATION_ENV_NAME="{{ organisation_name | replace('-', '_') | upper }}"
# Name used in path
export ORGANISATION_PATH_NAME="{{ organisation_name | replace('_', '-') | lower }}"
