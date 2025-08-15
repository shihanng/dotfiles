export default {
  defaultBrowser: "Firefox",
  rewrite: [],
  handlers: [
    {
      match: "samlsp.private.zscaler.com/auth/v2/*",
      browser: "Google Chrome",
    },
  ],
};
