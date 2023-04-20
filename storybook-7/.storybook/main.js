
module.exports = {
  stories: ["./stories/*.stories.tsx"],
  addons: ["@storybook/addon-links", "@storybook/addon-essentials"],
  framework: {
    name: "@storybook/react-vite",
    options: {}
  },
  refs: {
    'My Design System': {
      title: 'Storybook 6Design System',
      url: '/storybook-6',
      expanded: false, // Optional, true by default
    },
  },
};