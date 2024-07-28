FROM paperspace/gradient-base:pt211-tf215-cudatk120-py311-20240202
# Install gcloud CLI
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list &&  \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && apt-get update -y &&  \
    apt-get install google-cloud-sdk -y

# Install Cloud Storage FUSE to be able to mount GCS buckets
RUN export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s` && \
    echo "deb https://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
    sudo apt-get update -y && \
    sudo apt-get install -y fuse gcsfuse \
