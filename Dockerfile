FROM gitpod/workspace-full:latest

# Create some bash aliases for the maven archetypes of enRoute and resolving/indexing
USER gitpod
RUN echo 'alias project="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=project -DarchetypeVersion=7.0.0"' >> /home/gitpod/.bash_profile \
&& echo 'alias api="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=api -DarchetypeVersion=7.0.0"' >> /home/gitpod/.bash_profile \
&& echo 'alias rest="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=rest-component -DarchetypeVersion=7.0.0"' >> /home/gitpod/.bash_profile \
&& echo 'alias test="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=bundle-test -DarchetypeVersion=7.0.0"' >> /home/gitpod/.bash_profile \
&& echo 'alias ds="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=ds-component -DarchetypeVersion=7.0.0"' >> /home/gitpod/.bash_profile \
&& echo 'alias app="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=application -DarchetypeVersion=7.0.0"' >> /home/gitpod/.bash_profile \
&& echo 'alias projectbare="mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:generate -DarchetypeGroupId=org.osgi.enroute.archetype -DarchetypeArtifactId=project-bare -DarchetypeVersion=7.0.0"' >> /home/gitpod/.bash_profile \
&& echo 'alias run="java -jar "' >> /home/gitpod/.bash_profile \
&& echo 'alias debug="java -jar -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=y "' >> /home/gitpod/.bash_profile \
&& echo 'resolve(){ mvn -pl "$1" -am bnd-indexer:index bnd-indexer:index@test-index bnd-resolver:resolve package; }' >> /home/gitpod/.bashrc

# Give back control
USER root
