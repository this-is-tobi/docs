---
layout: doc
---

# OSS Projects

As part of my professional activity, I have worked on a number of open source projects, which are listed below *(this is not necessarily an explicit list).*

## Cloud π Native 

<Badge type="info" text="Product Owner" />
<Badge type="info" text="Platform Engineer" />
<Badge type="info" text="DevOps Engineer" />
<Badge type="info" text="Developer" />

### Introduction

Cloud π Native *- CPiN -* is a French government PaaS running on top of Kubernetes (Vanilla, Openshift or RKE), it provides a software factory and DevSecOps orchestrator to produce and operate high-quality digital services for users (primarily targeting those producing public digital content).

The platform exposes a console that provides a unified interface to a range of services, while guaranteeing overall system consistency with the automatic creation of a number of resources, such as access accounts, bots and Kubernetes resources. In addition to automatic provisioning, it also guarantees control within the project through the management of teams, permissions, quotas, etc...

> The console is built around a core/plugin system that extends the platform's capabilities by connecting additional services to the hook system.

### Technologies

Main technologies I worked with on the project :

- [Ansible](https://ansible.com/) *- automation engine that enables infra as code.*
- [Docker](https://docker.com/) *- container orchestrator system.*
- [GitHub Actions](https://github.com/features/actions) *- continuous integration / continuous delivery platform.*
- [Helm](https://helm.sh/) *- package manager for kubernetes.*
- [Kind](https://kind.sigs.k8s.io/) *- tool for running local kubernetes clusters using docker.*
- [Kubernetes](https://kubernetes.io/) *- container orchestrator system.*
- [Nodejs](https://nodejs.org/) *- cross-platform javascript runtime environment.*
- [Vuejs](https://vuejs.org/) *- progressive javascript frontend framework.*

Main Kubernetes services I worked with on the project :

| Service                                                          | Description                                                                                                                                                                                                                                      |
| ---------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [Argo-cd](https://argo-cd.readthedocs.io/en/stable/)             | Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.                                                                                                                                                                        |
| [Falco](https://falco.org/)                                      | Cloud-native security tool designed for Linux systems. It employs custom rules on kernel events, which are enriched with container and Kubernetes metadata, to provide real-time alerts.                                                         |
| [Harbor](https://goharbor.io/)                                   | Open source registry that secures artifacts with policies and role-based access control, ensures images are scanned and free from vulnerabilities, and signs images as trusted.                                                                  |
| [Gitlab](https://about.gitlab.com/)                              | DevOps software package that can develop, secure, and operate software.                                                                                                                                                                          |
| [Grafana](https://grafana.com/oss/grafana/)                      | Query, visualize, alert on, and understand your data no matter where it’s stored. With Grafana you can create, explore, and share all of your data through beautiful, flexible dashboards.                                                       |
| [Keycloak](https://www.keycloak.org/)                            | Open Source Identity and Access Management. Add authentication to applications and secure services with minimum effort. Keycloak provides user federation, strong authentication, user management, fine-grained authorization, and more.         |
| [Kyvervo](https://kyverno.io/)                                   | Policy engine designed for Kubernetes. Kyverno policies can validate, mutate, generate, and cleanup Kubernetes resources, and verify image signatures and artifacts to help secure the software supply chain.                                    |
| [Loki](https://grafana.com/oss/loki/)                            | Easily collect, correlate, and visualize data with beautiful dashboards using Grafana — the open source data visualization and monitoring solution that drives informed decisions, enhances system performance, and streamlines troubleshooting. |
| [Nexus](https://sonatype.com/products/sonatype-nexus-repository) | Centralized, scalable universal repository management.                                                                                                                                                                                           |
| [Prometheus](https://prometheus.io/)                             | Prometheus is a free software application used for event monitoring and alerting. It records metrics in a time series database (allowing for high dimensionality) built using an HTTP pull model, with flexible queries and real-time alerting.  |
| [Sonarqube](https://sonarsource.com/products/sonarqube/)         | Self-managed, open source, automatic code review tool that systematically helps you deliver Clean Code.                                                                                                                                          |
| [Vault](https://vaultproject.io/)                                | Secure, store, and tightly control access to tokens, passwords, certificates, and encryption keys for protecting secrets and other sensitive data using a UI, CLI, or HTTP API.                                                                  |
| [Velero](https://velero.io/)                                     | Velero is an open source tool to safely backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.                                                                                          |

### Sources

All public sources of the project are available [here](https://github.com/cloud-pi-native).
