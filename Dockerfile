FROM ubuntu:bionic

RUN apt-get update && apt-get install -y python3.7-venv python3.7-dev liblzma-dev libbz2-dev zlib1g-dev samtools python3-venv \
 && python3.7 -m venv ~/.virtualenvs/pysam

COPY requirements-pypa.txt /tmp/requirements-pypa.txt
RUN ~/.virtualenvs/pysam/bin/pip install --no-deps --require-hashes -r /tmp/requirements-pypa.txt \
 && rm /tmp/requirements-pypa.txt

COPY requirements.txt /tmp/requirements.txt
RUN ~/.virtualenvs/pysam/bin/pip install --no-deps --require-hashes -r /tmp/requirements.txt \
 && rm /tmp/requirements.txt

RUN ~/.virtualenvs/pysam/bin/python -c "str(__import__('pysam').FastqProxy())"
