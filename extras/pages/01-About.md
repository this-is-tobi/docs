---
layout: page
title: About
sidebar: false
description: Thibault Colin, aka Tobi, tech lead and architect at the French Ministry of the Interior.
---

<script setup>
import { VPButton } from 'vitepress/theme'
</script>

<div class="about">
  <section class="about-hero">
    <img class="about-avatar" src="/avatar.jpg" alt="Tobi's avatar, a hooded figure" width="176" height="176">
    <div class="about-intro">
      <p class="about-eyebrow">Hi, I'm Tobi</p>
      <h1 class="about-name">Thibault Colin</h1>
      <p class="about-role">Tech Lead / Architect at the <a href="https://github.com/dnum-mi" target="_blank" rel="noreferrer">French Ministry of the Interior</a></p>
      <p class="about-bio">After digging into the world of JavaScript, a strange world appeared where robots were ubiquitous, they call it DevOps.</p>
      <p class="about-bio">I design and run platforms for the French government, from a Kubernetes PaaS to an AI platform, and spend my spare time building the tools I wish I had: documentation generators, Helm charts, CI workflows and command line companions.</p>
      <div class="about-actions">
        <VPButton tag="a" size="medium" theme="brand" text="GitHub" href="https://github.com/this-is-tobi" target="_blank" rel="noreferrer" />
        <VPButton tag="a" size="medium" theme="alt" text="Bluesky" href="https://bsky.app/profile/this-is-tobi.com" target="_blank" rel="noreferrer" />
        <VPButton tag="a" size="medium" theme="alt" text="this-is-tobi@proton.me" href="mailto:this-is-tobi@proton.me" target="_self" />
      </div>
    </div>
  </section>

  <nav class="about-cards" aria-label="Explore">
    <a class="about-card" href="/projects">
      <span class="about-card-title">Professional projects</span>
      <span class="about-card-text">MIrAI, Cloud π Native and Basegun: open source platforms built for the French government.</span>
    </a>
    <a class="about-card" href="/">
      <span class="about-card-title">Open source tools</span>
      <span class="about-card-text">The projects I maintain, from docpress to ohmlab, with their documentation.</span>
    </a>
    <a class="about-card" href="/contributions">
      <span class="about-card-title">Contributions</span>
      <span class="about-card-text">Pull requests merged into open source projects maintained by others.</span>
    </a>
    <a class="about-card" href="/contribute">
      <span class="about-card-title">Contribute</span>
      <span class="about-card-text">How to propose changes, report a vulnerability and reuse the code.</span>
    </a>
  </nav>
</div>
