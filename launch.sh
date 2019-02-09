# this step fails when action is not already running, but doesn't matter will continue
REPOS=$(basename `git rev-parse --show-toplevel`)
ABSPATH=$(pwd)
echo $ABSPATH
docker stop $REPOS
# this builds the image anew, but this is really fast if there are no changes
docker build --tag=$REPOS .
# this starts the image and maps the REPOS directory
docker run \
  --env=PASSWORD=foo `# some environmental vars` \
  --rm  `# make container ephemeral` \
  -d \
  --volume=$ABSPATH:/home/rstudio/$REPOS \
  --publish=8787:8787  `# port mapping, host left, cont right`\
  --name="$REPOS" \
  $REPOS `# the image`
