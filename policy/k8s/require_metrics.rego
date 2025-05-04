package k8s.guardrails
#package main
# True when at least one container in a Deployment
# exposes port 8080.
default allow = false

prometheus_port := 8080

allow {
  input.kind == "Deployment"
  some i
  some j
  input.spec.template.spec.containers[i].ports[j].containerPort == prometheus_port
}

# ---------- Conftest entry point ----------
# If `allow` is false, emit a deny result with a helpful message.
deny[msg] {
  not allow
  msg := sprintf(
    "Deployment %s must expose port %d for Prometheus metrics",
    [input.metadata.name, prometheus_port],
  )
}
