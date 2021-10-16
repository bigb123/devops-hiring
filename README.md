# Django Polls App For DevOps Candidates

## WARNING

This is not a working project. It is suppose to present how will I solve the given problem rather than make it running.

## The AWS architectural graph

Grab a coffee, kick back, relax and have a look for a big picture.

![AWS graph](spoton_diagram.drawio.svg)


## Junior section

- Dockerized via Dockerfile
- Kube manifests:

  - I've created a namespace per each environment (DEV, QA, PREPROD, PROD) - namespaces.yaml file
  - The file "nlb ingress.yaml" keeps Network Load Balancer ingress definition for DEV/QA/PREPROD. It comes from [AWS Blog](https://aws.amazon.com/blogs/opensource/network-load-balancer-nginx-ingress-controller-eks/) so probably not worth to dive into it as I didn't tweak anything there. 
  - In "django app deploy.yaml" are pods definitions
  - "environment ingresses.yaml" ingress definition per environment.

  ```
  kubectl create -f ./namespaces.yaml
  kubectl apply -f './nlb ingress.yaml' 
  kubectl apply -f './django app deploy.yaml'
  kubectl apply -f './environment ingresses.yaml'
  ```

  For Horizontal pod autoscaling:
  ```
  kubectl autoscale deployment django-prod --cpu-percent=50 --min=1 --max=10
  ```

## Mid section

- 12 factor app:
  - IV. Backing services - keep the DB out of the container
  - X. Dev/prod parity - keep the envs' DBs as similar as possible (it's actually possible in some limited range)
  - XI. Logs - stream logs from container to CloudWatch (probably done by default by EKS but worth to check)
  - III. Config - SECRET_KEY is an env var that sits in kube pod

## Senior section

- Local development process: 
  1. Make sure you have python 3 installed
  1. Develop the app in your IDE
  1. Run the app
- Running the application:
  - Install dependencies with `pip3 install -r requirements.txt`
  - Run the app with `./manage.py runserver` or `python3 ./manage.py runserver`
  - Web app is accessible at http://127.0.0.1:8000/

    (no, I'm not gonna describe how to set up minikube because I've never done that - I usually go straight to the cloud).

- AWS diagram is on the top

## Extras

- http server answers with current date and time by default
- terraform is here

