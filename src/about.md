---
layout: home
---
<script setup>
import {
  VPTeamPage,
  VPTeamPageTitle,
  VPTeamMembers
} from 'vitepress/theme'

const emailSvg = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" height="100%" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);"><path fill="currentColor" d="m20 8l-8 5l-8-5V6l8 5l8-5m0-2H4c-1.11 0-2 .89-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2Z"/></svg>'

const members = [
  {
    avatar: '/android-chrome-512x512.png',
    name: 'Thibault Colin',
    title: 'Typescript Developer / DevOps Architect',
    org: 'French Ministry of the Interior',
    orgLink: 'https://github.com/dnum-mi',
    desc: 'After digging into the world of javascript, a strange world appeared where robots were ubiquitous, they call it DevOps.',
    links: [
      { icon: 'github', link: 'https://github.com/this-is-tobi' },
      { icon: 'github', link: 'https://github.com/cloud-pi-native' },
      { icon: { svg: emailSvg }, link: 'mailto:this-is-tobi@proton.me' },
    ]
  },
]
</script>

<style>
.vp-doc .VPTeamMembers.medium.count-1 .container {
  margin: auto !important;
  max-width: 650px !important;
}

.vp-doc .VPTeamMembers.medium.count-1 .profile {
  background-color: color-mix(in srgb, var(--vp-c-bg-soft), transparent 70%) !important;
}
</style>

<VPTeamPage>
  <VPTeamMembers
    :members="members"
  />
</VPTeamPage>