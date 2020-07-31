#!/bin/bash

# meant to be run on a DNAnexus Cloud Workstation

sudo docker build --tag conpair:0.2-20200403 .
sudo docker save --output conpair.tar conpair:0.2-20200403
sudo chown dnanexus.dnanexus conpair.tar

# upload to project
dx upload --path "$DX_PROJECT_CONTEXT_ID:" conpair.tar
