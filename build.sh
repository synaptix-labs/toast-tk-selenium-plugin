if [ ${TRAVIS_PULL_REQUEST} = 'false' ] && [[ $TRAVIS_BRANCH = 'master'  ||  ${TRAVIS_BRANCH} = 'snapshot' ]]; then
      echo 'Checking Quality Gates against sonar'
      mvn help:effective-settings;
      mvn --batch-mode clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:3.0.1:sonar -Dsonar.host.url=${SONAR_URL} -Dsonar.login=${SONAR_LOGIN} -Dsonar.organization=${SONAR_ORGANIZATION} --settings ./settings.xml;
elif [ ${TRAVIS_PULL_REQUEST} != 'false' ]; then
      echo 'Build and analyze pull request'
      mvn --batch-mode clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:3.0.1:sonar -Dsonar.analysis.mode=issues -Dsonar.host.url=${SONAR_URL} -Dsonar.login=${SONAR_LOGIN} -Dsonar.organization=${SONAR_ORGANIZATION} -Dsonar.github.oauth=${SONAR_GITHUB_OAUTH} -Dsonar.github.repository=toast-tk/toast-tk-selenium-plugin -Dsonar.github.pullRequest=${TRAVIS_PULL_REQUEST};
fi