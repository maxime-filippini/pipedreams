(() => {
  // app.js
  document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll('span[data-math-style="display"]').forEach(function(el) {
      katex.render(el.textContent, el, { displayMode: true });
    });
    document.querySelectorAll('span[data-math-style="inline"]').forEach(function(el) {
      katex.render(el.textContent, el, { displayMode: false });
    });
  });
})();
