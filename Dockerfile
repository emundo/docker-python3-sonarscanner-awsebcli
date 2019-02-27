FROM openjdk:8

ENV PATH /home/emundo/.local/bin:$PATH

## emundo User
RUN addgroup --gid 1101 rancher && \
    # Für RancherOS brauchen wir diese Gruppe: http://rancher.com/docs/os/v1.1/en/system-services/custom-system-services/#creating-your-own-console
    addgroup --gid 999 aws && \
    # Für die AWS brauchen wir diese Gruppe
    useradd -ms /bin/bash emundo && \
    adduser emundo sudo && \
    # Das ist notwendig, damit das Image in RancherOS funktioniert
    usermod -aG 999 emundo && \
    # Das ist notwendig, damit das Image in RancherOS funktioniert
    usermod -aG 1101 emundo && \
    # Das ist notwendig, damit das Image lokal funktioniert
    usermod -aG root emundo

# python3
RUN apt-get update && apt-get install -y python3
#  sonar-scanner
RUN wget \
        "https://dl.bintray.com/sonarsource/SonarQube/org/sonarsource/scanner/cli/sonar-scanner-cli/3.3.0.1492/sonar-scanner-cli-3.3.0.1492.zip" \
        -O ./sonar-scanner.zip; \
    jar xf sonar-scanner.zip; \
    mv sonar-scanner-* sonar-scanner; \
    rm sonar-scanner.zip; \
    rm sonar-scanner/**/*.bat; \
    mv sonar-scanner/bin/* /usr/local/bin; \
    mv sonar-scanner/lib/* /usr/local/lib; \
    rm -rf sonar-scanner; \
    chmod +x /usr/local/bin/sonar-*

USER emundo
WORKDIR /home/emundo
# pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o /home/emundo/get-pip.py
RUN python3 /home/emundo/get-pip.py --user
# awsebcli
RUN pip install awsebcli --upgrade --user

