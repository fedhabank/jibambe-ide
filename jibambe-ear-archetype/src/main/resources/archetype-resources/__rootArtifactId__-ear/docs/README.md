# Create custom archetype project
mvn archetype:generate \
    -DgroupId=com.fedhabank.enterprise \
    -DartifactId=helion-ide \
    -DarchetypeGroupId=org.apache.maven.archetypes \
    -DarchetypeArtifactId=maven-archetype-archetype
# Run custom archetype  
mvn archetype:generate                                  \
    -DarchetypeGroupId=com.fedhabank.enterprise                \
    -DarchetypeArtifactId=helion-ide          \
    -DarchetypeVersion=1.0-SNAPSHOT                \
    -DgroupId=com.fedhabank.enterprise                                \
    -DartifactId=helion-platforms
# Create jakartaee-ear project
mvn archetype:generate \
    -DgroupId=com.fedhabank.enterprise \
    -DartifactId=helion-platforms \
    -Dversion=1.0-SNAPSHOT \
    -DarchetypeGroupId=org.wildfly.archetype \
    -DarchetypeArtifactId=wildfly-jakartaee-ear-archetype \
    -DarchetypeVersion=26.0.0.Final


# Create jakartaee-webapp project
mvn archetype:generate \
    -DgroupId=com.fedhabank.enterprise \
    -DartifactId=helion-platform-web-admin \
    -Dversion=1.0-SNAPSHOT \
    -DarchetypeGroupId=org.wildfly.archetype \
    -DarchetypeArtifactId=wildfly-jakartaee-webapp-archetype \
    -DarchetypeVersion=26.0.0.Final