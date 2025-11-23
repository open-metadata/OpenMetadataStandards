// Mermaid diagram zoom functionality
document.addEventListener('DOMContentLoaded', function() {
  // Wait for Mermaid diagrams to be rendered
  const observer = new MutationObserver(function(mutations) {
    initMermaidZoom();
  });

  // Observe the document for Mermaid diagram additions
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });

  // Initial setup
  initMermaidZoom();
});

function initMermaidZoom() {
  const mermaidDiagrams = document.querySelectorAll('.mermaid:not(.zoom-enabled)');

  mermaidDiagrams.forEach(function(diagram) {
    // Mark as zoom-enabled to avoid duplicate handlers
    diagram.classList.add('zoom-enabled');

    // Add click handler
    diagram.addEventListener('click', function(e) {
      e.stopPropagation();
      toggleZoom(this);
    });

    // Add keyboard handler for ESC key when zoomed
    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
        const zoomedDiagram = document.querySelector('.mermaid.zoomed');
        if (zoomedDiagram) {
          toggleZoom(zoomedDiagram);
        }
      }
    });
  });
}

function toggleZoom(diagram) {
  if (diagram.classList.contains('zoomed')) {
    // Zoom out
    diagram.classList.remove('zoomed');
    document.body.style.overflow = '';
  } else {
    // Zoom in
    diagram.classList.add('zoomed');
    document.body.style.overflow = 'hidden';

    // Click outside to close
    diagram.addEventListener('click', function closeZoom(e) {
      if (e.target === diagram) {
        toggleZoom(diagram);
        diagram.removeEventListener('click', closeZoom);
      }
    });
  }
}
