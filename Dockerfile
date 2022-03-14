FROM maven

ENV NODE_VERSION=14.7.0
ENV JIBAMBE_WORKSPACE_DIR=/ide/workspace
ENV JIBAMBE_IDE_DIR="$JIBAMBE_WORKSPACE_DIR/jibambe-ide"
#ENV JIBAMBE_IDE_SRC_DIR="$JIBAMBE_IDE_DIR/src"
ENV JIBAMBE_IDE_SCRIPTS_DIR="$JIBAMBE_IDE_DIR/scripts"
ENV JIBAMBE_IDE_EAR_ARCHETYPE_DIR="$JIBAMBE_IDE_DIR/jibambe-ear-archetype"
ENV JIBAMBE_IDE_EJB_ARCHETYPE_DIR="$JIBAMBE_IDE_DIR/jibambe-ejb-archetype"
ENV JIBAMBE_IDE_WAR_ARCHETYPE_DIR="$JIBAMBE_IDE_DIR/jibambe-war-archetype"
#RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

RUN node --version
RUN npm --version

# Create jibambe-ide directories
RUN mkdir -p $JIBAMBE_WORKSPACE_DIR
RUN mkdir $JIBAMBE_IDE_DIR
#RUN mkdir $JIBAMBE_IDE_SRC_DIR
RUN mkdir $JIBAMBE_IDE_SCRIPTS_DIR

# Copy src directory and pom.xml in current directory into container
COPY pom.xml $JIBAMBE_IDE_DIR
COPY jibambe-ear-archetype $JIBAMBE_IDE_EAR_ARCHETYPE_DIR
COPY jibambe-ejb-archetype $JIBAMBE_IDE_EJB_ARCHETYPE_DIR
COPY jibambe-war-archetype $JIBAMBE_IDE_WAR_ARCHETYPE_DIR
#COPY src $JIBAMBE_IDE_SRC_DIR

# Build and install jibambe-ide archetype
WORKDIR $JIBAMBE_IDE_DIR
RUN mvn install

# Copy jibambe-ide scripts into container
COPY scripts/ide-create.sh $JIBAMBE_IDE_SCRIPTS_DIR
COPY scripts/ide-deploy.sh $JIBAMBE_IDE_SCRIPTS_DIR

# Set scripts permissions
RUN chmod 755 -R $JIBAMBE_IDE_SCRIPTS_DIR

# Build and install jibambe-ide archetype
#RUN  mvn dependency:get -DgroupId=org.wildfly.archetype -DartifactId=wildfly-jakartaee-ear-archetype -Dversion=26.0.0.Final -Dpackaging=jar -Dclassifier=sources -DremoteRepositories=https://mvnrepository.com/repos/central 

CMD tail -f /dev/null
