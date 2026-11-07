---
navTitle: Pro. Projects
title: Professional projects
description: Open source projects I worked on for the French government, from an AI platform to a Kubernetes PaaS.
sidebar: false
prev: false
next: false
outline: [2, 2]
pageClass: site-page projects-page
---

# Professional projects

As part of my job, I worked on several open source projects for the French government. The list below is not exhaustive.

## MIrAI

<div class="project-roles">
  <Badge type="info" text="Tech Lead" />
  <Badge type="info" text="Architect" />
</div>

MIrAI is an AI platform developed by the French government to make it easier to use and build applications based on artificial intelligence models. It provides several levels of services: the lower level serves models through APIs, while the upper level offers a catalog of ready-to-use applications, combining APIs and user interfaces, for features such as text extraction, document summarization, meeting summarization or chatbots.

### Stack

<div class="tech-grid">

- [GitHub Actions](https://github.com/features/actions) Continuous integration and delivery platform.
- [Helm](https://helm.sh/) Package manager for Kubernetes.
- [k6](https://k6.io/) Load testing tool.
- [Keycloak](https://www.keycloak.org/) Open source identity and access management.
- [Kubernetes](https://kubernetes.io/) Container orchestration system.
- [PostgreSQL](https://www.postgresql.org/) Relational database management system.
- [Qdrant](https://qdrant.tech/) Vector database and search engine.
- [Redis](https://redis.io/) In-memory data store, used as a database, cache and message broker.

</div>

### Kubernetes services

<div class="tech-grid">

- [CloudNativePG](https://cloudnative-pg.io/) Kubernetes operator running highly available PostgreSQL clusters.
- [Knative](https://knative.dev/) Platform to build, deploy and manage serverless workloads.
- [KServe](https://kserve.github.io/) Standardized platform for generative and predictive AI inference.
- [LiteLLM](https://www.litellm.ai/) AI gateway calling 100+ LLM APIs in the OpenAI format, with cost tracking, guardrails and load balancing.
- [NVIDIA GPU Operator](https://github.com/NVIDIA/gpu-operator) Manages GPU drivers and software in Kubernetes clusters.
- [Open WebUI](https://docs.openwebui.com/) Self-hosted AI platform with a chat interface and a built-in RAG engine.
- [vLLM](https://docs.vllm.ai/) Fast and easy-to-use library for LLM inference and serving.

</div>

[IA-Generative](https://github.com/IA-Generative){.project-source}

## Cloud π Native

<div class="project-roles">
  <Badge type="info" text="Product Owner" />
  <Badge type="info" text="Platform Engineer" />
  <Badge type="info" text="DevOps Engineer" />
  <Badge type="info" text="Developer" />
</div>

Cloud π Native, or CPiN, is a French government PaaS running on top of Kubernetes (vanilla, OpenShift or RKE). It provides a software factory and a DevSecOps orchestrator to build and operate high-quality digital services, primarily for teams producing public digital services.

The platform exposes a console that unifies access to a range of services, while keeping the whole system consistent by automatically creating resources such as access accounts, bots and Kubernetes resources. On top of this automatic provisioning, it keeps each project under control through the management of teams, permissions, quotas, and more.

::: tip Plugin architecture
The console is built around a core and plugin system: plugins connect additional services to its hooks to extend the platform's capabilities.
:::

### Stack

<div class="tech-grid">

- [Ansible](https://www.ansible.com/) Automation engine for infrastructure as code.
- [Docker](https://www.docker.com/) Platform to build and run containers.
- [GitHub Actions](https://github.com/features/actions) Continuous integration and delivery platform.
- [Helm](https://helm.sh/) Package manager for Kubernetes.
- [Kind](https://kind.sigs.k8s.io/) Runs local Kubernetes clusters in Docker containers.
- [Kubernetes](https://kubernetes.io/) Container orchestration system.
- [Node.js](https://nodejs.org/) Cross-platform JavaScript runtime.
- [Vue.js](https://vuejs.org/) Progressive JavaScript framework for user interfaces.

</div>

### Kubernetes services

<div class="tech-grid">

- [Argo CD](https://argo-cd.readthedocs.io/en/stable/) Declarative GitOps continuous delivery for Kubernetes.
- [Falco](https://falco.org/) Runtime security alerting on kernel events, enriched with container and Kubernetes metadata.
- [GitLab](https://about.gitlab.com/) DevSecOps platform to develop, secure and operate software.
- [Grafana](https://grafana.com/oss/grafana/) Dashboards to query, visualize and alert on data wherever it is stored.
- [Harbor](https://goharbor.io/) Container registry with access control, vulnerability scanning and image signing.
- [Keycloak](https://www.keycloak.org/) Identity and access management, with user federation and fine-grained authorization.
- [Kyverno](https://kyverno.io/) Kubernetes policy engine to validate, mutate, generate and clean up resources.
- [Loki](https://grafana.com/oss/loki/) Log aggregation system designed to be cost-effective and easy to operate.
- [Nexus](https://www.sonatype.com/products/sonatype-nexus-repository) Universal repository manager for build artifacts.
- [Prometheus](https://prometheus.io/) Monitoring and alerting toolkit built on a time series database.
- [SonarQube](https://www.sonarsource.com/products/sonarqube/) Continuous code quality and security analysis.
- [Vault](https://www.vaultproject.io/) Stores and controls access to tokens, passwords, certificates and encryption keys.
- [Velero](https://velero.io/) Backup, restore and migration of Kubernetes resources and persistent volumes.

</div>

[cloud-pi-native](https://github.com/cloud-pi-native){.project-source}

## Basegun

<div class="project-roles">
  <Badge type="info" text="DevOps Engineer" />
</div>

According to the French criminal investigation police, over 7,000 firearms are seized every year in France, 15 to 20% of which are misidentified or unidentified. These errors in the legal classification of weapons lead to:

- missing criminal prosecutions or, conversely, unjustified ones;
- an excessive use of firearms experts;
- the erroneous sale, by civilian gunsmiths, of weapons subject to authorization.

Basegun is an application designed for law enforcement agencies: taking a photo of a firearm is enough to get an identification, computed by an artificial intelligence model, that helps them in their procedures.

### Stack

<div class="tech-grid">

- [GitHub Actions](https://github.com/features/actions) Continuous integration and delivery platform.
- [Helm](https://helm.sh/) Package manager for Kubernetes.
- [Kubernetes](https://kubernetes.io/) Container orchestration system.

</div>

[dnum-mi/basegun](https://github.com/dnum-mi/basegun){.project-source}
