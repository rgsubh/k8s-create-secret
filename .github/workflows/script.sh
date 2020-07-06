token=$1
commit=$2
repository=$3
prNumber=$4
frombranch=$5
tobranch=$6

getPayLoad() {
    cat <<EOF
{
    "event_type": "K8sCreateSecretReleasesPR", 
    "client_payload": 
    {
        "action": "CreateSecret", 
        "commit": "$commit", 
        "repository": "$repository", 
        "prNumber": "$prNumber", 
        "tobranch": "$tobranch", 
        "frombranch": "$frombranch"
    }
}
EOF
}

getHeader() {
    cat <<EOF
    Authorization: token $token
EOF
}

response=$(curl -H "$(getHeader)" -X POST --data "$(getPayLoad)" https://api.github.com/repos/rgsubh/l2-integration-tests/dispatches )

if [ "$response" == "" ]; then
    echo "Integration tests triggered successfully"
else
    echo "Triggering integration tests failed with: '$response'"
    exit 1
fi
