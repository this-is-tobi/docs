import { defineConfig } from 'vitepress'
import sidebar from '../projects/sidebar.json' assert { type: 'json'}

export default defineConfig({
  base: '/',
  lang: 'en-US',
  vite: {
    publicDir: '../public',
  },
  head: [
    ['link', { rel: "apple-touch-icon", sizes: "180x180", href: "/apple-touch-icon.png"}],
    ['link', { rel: "icon", type: "image/png", sizes: "32x32", href: "/favicon-32x32.png"}],
    ['link', { rel: "icon", type: "image/png", sizes: "16x16", href: "/favicon-16x16.png"}],
    ['link', { rel: "shortcut icon", href: "/favicon.ico"}],
    ['link', { rel: "manifest", href: "/site.webmanifest"}],
  ],
  title: 'Home',
  description: 'Tobi\'s projects documentation',
  srcDir: './projects',
  cleanUrls: false,
  themeConfig: {
    logo: '/android-chrome-512x512.png',
    outline: [2, 3],
    sidebar,
    socialLinks: [
      { icon: 'github', link: 'https://github.com/this-is-tobi' }
    ]
  },
})
