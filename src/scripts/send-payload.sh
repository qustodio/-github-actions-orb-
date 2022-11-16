#!/bin/bash
OUTPUT=$(echo '{}' | jq '{
          "event_type": env.EVENT_TYPE,
          "client_payload": {
            "build_num": env.CIRCLE_BUILD_NUM,
            "branch": env.CIRCLE_BRANCH,
            "username": env.CIRCLE_USERNAME,
            "job": env.CIRCLE_JOB,
            "build_url": env.CIRCLE_BUILD_URL,
            "vcs_revision": env.CIRCLE_SHA1,
            "reponame": env.CIRCLE_PROJECT_REPONAME,
            "workflow_id": env.CIRCLE_WORKFLOW_ID,
            "pull_request": env.CI_PULL_REQUEST,
            "metadata": env.METADATA,
          }
        }' | curl -X POST -H "Content-Type:application/json" -H "Accept:application/vnd.github.v3+json" -H "Authorization: token $PRIVATE_GH_TOKEN" -d @- "https://api.github.com/repos/${REPO_NAME}/dispatches")

echo "$OUTPUT"

if [[ -z $OUTPUT ]]; then
    exit 0;
else 
    exit 1;
fi