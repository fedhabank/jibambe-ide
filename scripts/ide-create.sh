#!/bin/sh

# 1. Get the name and group of the project
while getopts n:g: flag
do
    case "${flag}" in
        n) name=${OPTARG};;
        g) group=${OPTARG};;
    esac
done

# 2. Change into workspace folders
cd $JIBAMBE_WORKSPACE_DIR

# 3. Run helion-ide archetype  
mvn --batch-mode archetype:generate \
    -DarchetypeGroupId=com.fedhabank.jibambe \
    -DarchetypeArtifactId=jibambe-ear-archetype  \
    -DarchetypeVersion=1.0-SNAPSHOT \
    -DgroupId=com.$group \
    -DartifactId=$name
# mvn --batch-mode archetype:generate \
#     -DarchetypeGroupId=org.wildfly.archetype \
#     -DarchetypeArtifactId=wildfly-jakartaee-ear-archetype \
#     -DarchetypeVersion=26.0.0.Final \
#     -DgroupId=$group \
#     -DartifactId=$name

init_webapp () {
    local tempDir="$1/temp"
    echo "This is webapp location $1 $tempDir $2"
    # Make dir $1/temp
    mkdir -p $tempDir
    # Clone the repo in directory $1/temp
    git clone $2 $tempDir
    # copy contents of $1/temp into $1
    cp -r "$tempDir/"* "$1"
    # Delete $1/temp
    rm -rf $tempDir
    # Change into directory
    cd $1
    # Run NPM install
    npm clean-install
}

init_webapp "$JIBAMBE_WORKSPACE_DIR/$name/$name-web" "https://github.com/fedhbank/helion-app.git"
#init_webapp "$JIBAMBE_WORKSPACE_DIR/$name/$name-web-admin" "https://github.com/fedhbank/helion-app-admin.git"
#init_webapp "$JIBAMBE_WORKSPACE_DIR/$name/$name-web-express" "https://github.com/fedhbank/helion-app-express.git"

# 4. Change into web folders
#cd "$JIBAMBE_WORKSPACE_DIR/$name/$name-web"

# 5. Create ReactJs app
#npx create-react-app . --template typescript