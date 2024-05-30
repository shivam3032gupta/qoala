
# Kubernetes Deployment README

## Introduction
This task can be better done via using helm charts and values 
Helm provides us flexiblity of templating so that we dont have to type the deployment file completely
i have attached a helm chart  as well in the folder but here i am depicting the task via configuration yamls. 
Seperate yamls have been given in folder for deployment, service, hpa and pdb. 


##For the rolling update strategy  configuration is given in nginxDeployment.yaml
maxSurge:  Tells you how many additional new  pods can be created at the time of rolling update  above the desired replica .
maxUnavailable : this property tells us maximum number of pods that can be unavailable  during the update  . max pods that can be simultaneously removed from the service


##For ensuring High Availablity
HPA is configured in deployment to scale application based on cpu and memory utilization
Some more things can be implemented on deployment to ensure the high avaialblity : 
- pod anti affinity so that no two pods of a deployment gets schedules on same node or same zone 
- cluster autoscaler should always be there in kuberentes cluster to ensure pod can be scheduled by scaling up the infra in case of resource crunch
- spot termination handling should be there  in case if you are using spot instances in eks
- pod disruption budget should be implemented to protect node from draining to prevent downtime on application in case all the pods of a service are running on same node. 




