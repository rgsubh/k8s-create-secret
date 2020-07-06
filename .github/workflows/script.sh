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

getHeader(){
    cat <<EOF
    Authorization: token $token
EOF
}

header="Authorization: token $token"
echo ">> $header"
echo "<><><> "$(getPayLoad)""
echo ">>> "$(getHeader)""

response=$(curl -X POST -H "$(getHeader)" "https://github.com/rgsubh/l2-integration-tests" --data "$(getPayLoad)")
