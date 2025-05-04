package k8s.guardrails_test      #  <-- note the _test suffix

import data.k8s.guardrails.allow # optional; could use full path each time

good_deployment := yaml.unmarshal(`apiVersion: apps/v1
kind: Deployment
metadata:
  name: good-app
spec:
  template:
    spec:
      containers:
        - name: good
          image: alpine
          ports:
            - containerPort: 8080
`)

bad_deployment := yaml.unmarshal(`apiVersion: apps/v1
kind: Deployment
metadata:
  name: bad-app
spec:
  template:
    spec:
      containers:
        - name: bad
          image: alpine
`)

test_deployment_with_metrics_allows {
  allow with input as good_deployment
}

test_deployment_without_metrics_denies {
  not allow with input as bad_deployment
}
