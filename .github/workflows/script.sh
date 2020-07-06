echo "Arg: $1"
echo "Arg: $2"
echo "Arg: $3"
echo "Arg: $4"
echo "Arg: $5"

token=$1
commit=$2
repository=$3
prNumber=$4
frombranch=$5
tobranch=$6

header="Authorization: token $token"
echo ">> $header"

response=$(curl -X POST -H "Authorization: token $token" https://github.com/rgsubh/l2-integration-tests --data '{"event_type": "K8sCreateSecretReleasesPR", "client_payload": {"action": "CreateSecret", "commit": "$commit", "repository":  "${{ github.repository }}", "prNumber": "${{ github.event.pull_request.number }}", "tobranch": "${{ github.event.pull_request.base.ref }}",  "frombranch": "${{ github.event.pull_request.head.ref }}" }}')
if [ "$response" == "" ]; then
    echo "Integration tests triggered successfully"
else
    echo "Triggering integration tests failed with: '$response'"
    exit 1
fi
