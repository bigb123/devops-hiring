# Django Polls App For DevOps Candidates

## WARNING

This is not a working project. It is suppose to present how will I solve the given problem rather than make it running.

## Junior section

- Dockerized via Dockerfile
- Kube manifests:

  ```
  kubectl create -f ./namespaces.yaml
  kubectl apply -f './deploy mandatory kubernetes components.yaml' # Suggest to not read it as it is ready solution from the internet
  kubectl apply -f './django app deploy.yaml'
  kubectl apply -f ./ingress.yaml

  For Horizontal pod autoscaling:
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

    (no, I'm not gonna describe how to set up minikube because I've never done that - I was going straight to the cloud).

- AWS diagram is on the bottom

## Extras

- http server answers with current date and time by default
- terraform is here

![AWS graph](spoton_diagram.drawio.svg)