Petclinic is a [Spring Boot](https://spring.io/guides/gs/spring-boot) application built using [Maven](https://spring.io/guides/gs/maven/).
This document explains how to build ,test and run this application using maven , docker and Jenkins 

## Prerequsites
Here are the pre requsuites to build and run the application using Jenkins 

- Jenkins with agent that has docker and JDK11 installed to build and run the application 
- To run application locally , user's machine should have JDK11 installed  
- Artifactory set up with docker and maven registries

    **docker local repo** - This repo stores internal Docker images for distribution across your organization. Application's docker image which is built via Jenkins pipeline will be pushed this repo 
  
    **docker remote repo** - This repo will have integration with docker hub to pull docker public images . This requires docker hub account to avoid docker pull rate limit issues  
   
    **maven remote repository** - This repo serves as proxy to jcenter to pull the maven dependencies required to build the application

## Running petclinic locally
. You can build a jar file and run it from the command line (it should work just as well with Java 8, 11 or 17):


```
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
java -jar target/*.jar
```

You can then access petclinic here: http://localhost:8080/

<img width="1042" alt="petclinic-screenshot" src="https://cloud.githubusercontent.com/assets/838318/19727082/2aee6d6c-9b8e-11e6-81fe-e889a5ddfded.png">

Or you can run it from Maven directly using the Spring Boot Maven plugin. If you do this it will pick up changes that you make in the project immediately (changes to Java source files require a compile as well - most people use an IDE for this):

```
./mvnw spring-boot:run
```

> NOTE: Windows users should set `git config core.autocrlf true` to avoid format assertions failing the build (use `--global` to set that flag globally).



## Running petclinic application using Jenkins and docker :







