## Introduction
Petclinic is a [Spring Boot](https://spring.io/guides/gs/spring-boot) application built using [Maven](https://spring.io/guides/gs/maven/).
This document explains how to build ,test and run this application using maven , docker and Jenkins 

### Prerequisites

Here are the pre requsuites to build and run the application using Jenkins 

- Jenkins with agent that has docker and JDK11 installed to build and run the application .It requires Docker Engine 17.05 as muti stage builds are used in this application
- To run application locally , user's machine should have JDK11 installed  
- Artifactory set up with below registries . For this demo krishnademo.jfrog.io instance will be used 

    **docker local repo** - This repo stores internal Docker images for distribution across your organization. Application's docker image which is built via Jenkins pipeline will be pushed this repo 
  
    **docker remote repo** - This repo will have integration with docker hub to pull docker public images . This requires docker hub account to avoid docker pull rate limit issues  
   
    **maven remote repository** - This repo serves as proxy to jcenter to pull the maven dependencies required to build this application


## Running petclinic application using maven, jenkins and docker :

Jenkinsfile contains the instructions on how to build , test and package the application . 

**Build**: 
Upon below command's successful execution , application is packaged as a jar under target directory . Since this application is built using spring 2.3 , a layered jar 
is generated which is required in creating more efffcient docker images . More info on layered jars can be here https://spring.io/blog/2020/08/14/creating-efficient-docker-images-with-spring-boot-2-3 . This layering jar approach is designed to separate code based on how likely it is to change between application builds. Library code is less likely to change between builds, so it is placed in its own layers to allow tooling to re-use the layers from cache. Application code is more likely to change between builds so it is isolated in a separate layer.

```
./mvnw clean package -DskipTests=true

```
**Test**:

Below commands runs the unit tests and generates the unit test reports under taget directory 

```
./mvnw test'
```

**Package**: 

Below commads builds the docker image according to the instrcutions given in dockerfile and the same is pushed to artifactory's docker registry 
```
  docker login -u ${username} -p ${password}  krishnademo.jfrog.io   ##username and password are the credentials for krishnademo.jfrog.io artifactory instance 
  docker build . -t krishnademo.jfrog.io/default-docker-local/krishna-pet-clinic && docker push krishnademo.jfrog.io/default-docker-local/krishna-pet-clinic

```

**Run**:

Below command pulls the docker image from artifactory's registry and runs the docker container which starts the application on port 8088
```
docker pull krishnademo.jfrog.io/default-docker-local/krishna-pet-clinic
docker run -d -p 8088:8088 krishnademo.jfrog.io/default-docker-local/krishna-pet-clinic

```
To test the application go to : http://{{ip_address}}:8088


### Running petclinic locally
. You can build a jar file and run it from the command line (it should work just as well with Java 8, 11 or 17):


```
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
java -jar target/*.jar
```

You can then access petclinic here: http://localhost:8080/

Or you can run it from Maven directly using the Spring Boot Maven plugin. If you do this it will pick up changes that you make in the project immediately (changes to Java source files require a compile as well - most people use an IDE for this):

```
./mvnw spring-boot:run
```

### References

https://spring.io/blog/2020/08/14/creating-efficient-docker-images-with-spring-boot-2-3

https://spring.io/blog/2020/01/27/creating-docker-images-with-spring-boot-2-3-0-m1

https://docs.docker.com/develop/develop-images/multistage-build/













