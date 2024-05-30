# qoala
Assignment Solutions
## Task1 : https://github.com/shivam3032gupta/qoala/tree/main/terraform/
## Task2:  https://github.com/shivam3032gupta/qoala/tree/main/kubernetes
## Task4:  https://github.com/shivam3032gupta/qoala/tree/main/Automation

## Task3: I have not worked with github action workflows but same can be done via jenkins and bitbucket  and argocd

Mentioning the approach below: 
- Create a jenkins job that polls scm every time a code is pushed or merged into it , build the application using mvn , node or whatever application type is.
- Create a dockerimage for the new application build and push new image to the ecr with new tag value equal to the build number of job. 
- A deploy job to update the image  tag in helm values file based on the build job number .
- Now since we are using argocd here and it is keeping sync with helm values file .. it will synchronize and start updating the application to newer version

