set -eo pipefail

mkdir -p /tmp/test-results

if [[ -n $KUBE_CONFIG ]]; then
  mkdir -p ~/.kube
  echo $KUBE_CONFIG | base64 --decode --ignore-garbage > ~/.kube/config
fi

if [[ -n $TF_VAR_access_key ]] && [[ -z $AWS_ACCESS_KEY_ID ]]; then
  export AWS_ACCESS_KEY_ID="$TF_VAR_access_key"
  export AWS_SECRET_ACCESS_KEY="$TF_VAR_secret_key"
fi

infra-query() {
  curl -Ls https://s3.amazonaws.com/gl-infra/infra.tfstate | jq $*
}

ecr-push() {
  eval $(aws ecr get-login --region ${AWS_DEFAULT_REGION:-us-east-1})
  docker tag $1 $2:build-$CIRCLE_BUILD_NUM
  docker push $2:build-$CIRCLE_BUILD_NUM
}

hub-push() {
  docker login -u gliderbot -p $DOCKER_PASS
  docker push $1
  if [[ -n $2 ]]; then
    docker tag $1 $1:${2}
    docker push $1:${2}
  fi
}

checksum-dir() {
  find $1 -type f -exec md5sum {} \; | sort -k 2 | checksum
}

checksum-file() {
  cat $1 | checksum
}

checksum-val() {
  echo "$1" | checksum
}

checksum() {
  md5sum | cut -d' ' -f1
}

dir-changed() {
  mkdir -p /.changed
  local checksumFile="/.changed/$(checksum-val $1)"
  local checksum="$(checksum-dir $1)"
  if [[ ! -f $checksumFile ]]; then
    return 0
  fi
  if [[ "$(cat $checksumFile)" != "$checksum" ]]; then
    return 0
  else
    return 1
  fi
}

changes-applied() {
  mkdir -p /.changed
  local checksumFile="/.changed/$(checksum-val $1)"
  checksum-dir $1 > $checksumFile
}

is-branch() {
  [[ "$CIRCLE_BRANCH" = "$1" ]]
}
