FROM openjdk:8-alpine
RUN apk add python3
RUN pip3 install awsebcli --upgrade --user
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
ENV PATH root/.local/bin:$PATH