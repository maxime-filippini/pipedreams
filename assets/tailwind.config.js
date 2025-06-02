module.exports = {
  content: [
    "./**/*.js",
    "../lib/layouts/**/*.ex",
    "../lib/pages/**/*.ex",
    "../lib/components/**/*.ex",
  ],
  plugins: [],
  theme: {
    extend: {
      fontFamily: {
        mono: ["Space Mono"],
      },
    },
  },
};
