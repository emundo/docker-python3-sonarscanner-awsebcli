
# docker python 3 sonar-scanner

openjdk-8 image with

- python3
- sonar-scanner 3.3.0.1492
- awsebcli

awsebcli will be installed in `emundo/.local/bin`

#### Build

`docker build ./`

#### Run / Test

`docker run -it <image-id>`

Available commands:

- `sonar-scanner`
- `eb`