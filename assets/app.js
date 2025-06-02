// Wait until the DOM is fully parsed and KaTeX has loaded
document.addEventListener("DOMContentLoaded", function () {
  // Render all <span data-math-style="display">…</span> as display‐style math
  document
    .querySelectorAll('span[data-math-style="display"]')
    .forEach(function (el) {
      // el.textContent should be the TeX code, e.g. "x + 1 = 2"
      katex.render(el.textContent, el, { displayMode: true });
    });

  // Render all <span data-math-style="inline">…</span> as inline math
  document
    .querySelectorAll('span[data-math-style="inline"]')
    .forEach(function (el) {
      katex.render(el.textContent, el, { displayMode: false });
    });
});
