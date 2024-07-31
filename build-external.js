const { spawnSync } = require("child_process");

async function buildExternal() {
  spawnSync("cp", ["-r", "build/.", "external"], { stdio: "inherit" });
  spawnSync("yarn", ["add", "zod"], { cwd: "external", stdio: "inherit" });
}

module.exports = buildExternal;
