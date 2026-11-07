/**
 * Feeds the pointer position to the card spotlights (see tokens.css). A single listener
 * on the window covers every card, including those rendered after a navigation.
 */

const CARDS = '.VPHomeFeatures .VPFeature.link, .about-card, .DocpressContributions .card'

// The theme also runs on the server, and hot reload may evaluate this module again
if (typeof window !== 'undefined' && !(window as { tobiSpotlight?: boolean }).tobiSpotlight) {
  (window as { tobiSpotlight?: boolean }).tobiSpotlight = true

  window.addEventListener('pointermove', (event) => {
    if (event.pointerType !== 'mouse' || !(event.target instanceof Element)) {
      return
    }
    const card = event.target.closest<HTMLElement>(CARDS)
    if (!card) {
      return
    }
    const { left, top } = card.getBoundingClientRect()
    card.style.setProperty('--tobi-x', `${event.clientX - left}px`)
    card.style.setProperty('--tobi-y', `${event.clientY - top}px`)
  }, { passive: true })
}
