const { outputFileSync } = require("fs-extra");
const { spawnSync } = require("child_process");

async function buildExternal() {
  // Direct write within the mounted volume works
  outputFileSync(
    "external/direct-write.txt",
    "Testing direct write permissions"
  );

  // cp from the app directory to the mounted volume works
  spawnSync("cp", ["-r", "build/.", "external"], { stdio: "inherit" });

  // yarn add fails with errors like:
  // Error: negotiator@npm:0.6.3: EPERM: operation not permitted, copyfile '/tmp/xfs-a37ca3f6/archive.zip' -> '/app/external/.cache/negotiator-npm-0.6.3-9d50e36171-8.zip-5b2207c423a44370.tmp'
  // This also occurs with TMPDIR=/app/tmp in the Dockerfile (but the error reflects the updated path)
  spawnSync("yarn", ["add", "zod"], { cwd: "external", stdio: "inherit" });
}

module.exports = buildExternal;
