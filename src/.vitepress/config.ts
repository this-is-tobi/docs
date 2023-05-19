import sidebar from '../projects/sidebar.json' assert { type: 'json'}

export default {
  lang: 'en-US',
  title: 'Home',
  description: 'Simple docs generator',
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