module.exports = {
  content: [
    "./**/*.js",
    "../lib/layouts/**/*.ex",
    "../lib/pages/**/*.ex",
    "../lib/components/**/*.ex",
    "../posts/**/*.md",
  ],
  plugins: [],
  theme: {
    extend: {
      fontFamily: {
        mono: ["Space Mono"],
      },
      typography: () => ({
        DEFAULT: {
          css: {
            "code::before": { content: "normal" },
            "code::after": { content: "normal" },
            ":where(code):not(:where(pre code, .not-prose code, .not-prose * code))":
              {
                "background-color": "var(--color-violet-200)",
                "border-radius": "var(--radius-md)",
                "padding-inline": "calc(var(--spacing) * 1)",
              },
            blockquote: { quotes: "none" },
          },
        },
        violet: {
          css: {
            "--tw-prose-body": "var(--color-slate-800)",
            "--tw-prose-headings": "var(--color-slate-900)",
            "--tw-prose-lead": "var(--color-slate-700)",
            "--tw-prose-links": "var(--color-slate-900)",
            "--tw-prose-bold": "var(--color-slate-900)",
            "--tw-prose-counters": "var(--color-slate-600)",
            "--tw-prose-bullets": "var(--color-slate-400)",
            "--tw-prose-hr": "var(--color-violet-300)",
            "--tw-prose-quotes": "var(--color-slate-900)",
            "--tw-prose-quote-borders": "var(--color-slate-300)",
            "--tw-prose-captions": "var(--color-slate-700)",
            "--tw-prose-code": "var(--color-slate-900)",
            "--tw-prose-pre-code": "var(--color-slate-100)",
            "--tw-prose-pre-bg": "var(--color-white)",
            "--tw-prose-th-borders": "var(--color-slate-300)",
            "--tw-prose-td-borders": "var(--color-slate-200)",
            "--tw-prose-invert-body": "var(--color-slate-200)",
            "--tw-prose-invert-headings": "var(--color-white)",
            "--tw-prose-invert-lead": "var(--color-slate-300)",
            "--tw-prose-invert-links": "var(--color-white)",
            "--tw-prose-invert-bold": "var(--color-white)",
            "--tw-prose-invert-counters": "var(--color-slate-400)",
            "--tw-prose-invert-bullets": "var(--color-slate-600)",
            "--tw-prose-invert-hr": "var(--color-slate-700)",
            "--tw-prose-invert-quotes": "var(--color-slate-100)",
            "--tw-prose-invert-quote-borders": "var(--color-slate-700)",
            "--tw-prose-invert-captions": "var(--color-slate-400)",
            "--tw-prose-invert-code": "var(--color-white)",
            "--tw-prose-invert-pre-code": "var(--color-slate-300)",
            "--tw-prose-invert-pre-bg": "var(--color-white)",
            "--tw-prose-invert-th-borders": "var(--color-slate-600)",
            "--tw-prose-invert-td-borders": "var(--color-slate-700)",
            pre: {
              "border-style": "var(--tw-border-style)",
              "border-width": "1px",
              "border-color": "var(--color-violet-300)",
            },
            ":where(code):not(:where(pre code, .not-prose code, .not-prose * code))":
              {
                "background-color": "var(--color-violet-200)",
                "border-radius": "var(--radius-md)",
                "padding-inline": "calc(var(--spacing) * 1)",
              },
            img: {
              "border-radius": "var(--radius-lg)",
              "border-style": "var(--tw-border-style)",
              "border-width": "1px",
              "border-color": "var(--color-violet-300)",
            },
          },
        },
      }),
    },
  },
};
