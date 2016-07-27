alexa-wol-proxy
===

A proxy for bypassing WOL network issues from a single Dockerfile. The request
is initiated from an AWS Lambda Function (such as alexa-wol-skill). The intended
use is for an Echo app to WOL a Steam Machine via the voice command,
  "Echo tell 'App-Name-In-AWS-Lambda' 'on'".

Setup:
  `npm run build-image-and-run` - Builds the Dockerfile with concatenated index.js
				  and runs a container with automatic restarts
				  across host system reboots

Notes:
  This project concatenates the program source into the Dockerfile to bypass the
  need for the actual source directory on the docker server at image build time.
  This allows the Dockerfile to be used even in scenarios where the accompanying
  repo may not be cloned for whatever reason.

Requires:
 `.env` file with environment variables for:
   - MAC
   - IP (optional)
   - PORT (optional)

KNOWN ISSUES:
  - build.sh script breaks if dependencies introduce newlines (such as comment
    boilerplate) because `sed` is not configured to account for this.
