const SERVICE = "tmux-notify"
const NOTIFICATIONS = {
  "permission.asked": "Permissions requested",
  "session.idle": "Agent done",
}

export const TmuxNotifyPlugin = async ({ $, client }) => {
  const notify = async (eventType, message) => {
    const home = process.env.HOME
    if (!home) return

    const result = await $`${home}/bin/tmux-notify send ${message}`.quiet().nothrow()
    if (result.exitCode === 0) return

    await client.app.log({
      body: {
        service: SERVICE,
        level: "error",
        message: "Failed to send tmux notification",
        extra: {
          eventType,
          exitCode: result.exitCode,
          stderr: String(result.stderr).trim(),
        },
      },
    })
  }

  return {
    event: async ({ event }) => {
      const message = NOTIFICATIONS[event.type]
      if (!message) return

      await notify(event.type, message)
    },
  }
}
