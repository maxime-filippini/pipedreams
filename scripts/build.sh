#!/usr/bin/env bash
set -e

IMAGE_NAME="pipedreams"
IMAGE_TAG="prod"
CONTAINER_NAME="pipedreams-container"
DOCKERFILE_DIR="."
HOST_PORT=42069
CONTAINER_PORT=8043

echo "=== Updating container '$CONTAINER_NAME' with image '$IMAGE_NAME:$IMAGE_TAG' ==="

if [ "$(docker ps -aq -f name=^/${CONTAINER_NAME}$)" ]; then
  echo "Stopping existing container '$CONTAINER_NAME'..."
  docker stop "$CONTAINER_NAME" >/dev/null

  echo "Removing container '$CONTAINER_NAME'..."
  docker rm "$CONTAINER_NAME" >/dev/null
else
  echo "No container named '$CONTAINER_NAME' found; skipping stop/remove."
fi

echo "Building image '$IMAGE_NAME:$IMAGE_TAG' from '$DOCKERFILE_DIR'..."
docker build -t "$IMAGE_NAME:$IMAGE_TAG" "$DOCKERFILE_DIR"

echo "Pruning unused images..."
docker image prune -f

echo "Starting new container '$CONTAINER_NAME' (mapping host port $HOST_PORT → container port $CONTAINER_PORT)..."
docker run -d \
  --name "$CONTAINER_NAME" \
  -p "$HOST_PORT":"$CONTAINER_PORT" \
  "$IMAGE_NAME:$IMAGE_TAG"

echo "✅ Container '$CONTAINER_NAME' is now running with image '$IMAGE_NAME:$IMAGE_TAG'."
