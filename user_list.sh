#!/bin/bash

###########################################################
#  Author: Ameen
# 
# This script is used to integerate github using API to fetch detail of collaborator on a repo
# Other script can also be made in same way 
#
# usage : ./user_list.sh <repo_owner> <repo_name> 
# example: ./user_list.sh Ameenrehman AWS-CICD
#
# user has to provide two argument while running the script , also the repo should be public then only the script will work 
# Also export your github username and token in environment before running the script 
##############################################################

username=$username
token=$token
api_url="https://api.github.com"
Repo_Owner=$1
Repo_Name=$2

#function to amke get request to the github 
function github_api_get {
    local endpoint="$1"  # here endpoint 1 is local from the argument passed in user_list_read
    local url="${api_url}/${endpoint}"

    curl -s -u "${username}:${token}" "$url"
}

#funciton to list user with read permision only in collaborators 
function user_list_read {
    local endpoint="repos/${Repo_Owner}/${Repo_Name}/collaborators"
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${Repo_Owner}/${Repo_Name}:"
        echo "$collaborators"
    fi
}

# Call the function to read user list
user_list_read



