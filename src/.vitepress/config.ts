import sidebar from '../projects/sidebar.json' assert { type: 'json'}

export default {
  lang: 'en-US',
  title: 'Home',
  description: 'Tobi\'s projects documentation',
  srcDir: 'projects',
  cleanUrls: true,
  themeConfig: {
    outline: [2, 3],
    sidebar,
    socialLinks: [
      { icon: 'github', link: 'https://github.com/this-is-tobi' }
    ]
  },
}