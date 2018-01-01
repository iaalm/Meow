# Description:
#   Time occupation script between simon and mon
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
  getLeft = (user) ->
    day_time = 1000 * 86400
    now = new Date()
    d = robot.brain.get "TO:#{user}"
    if not d
      return 30
    d = new Date(d)
    if (now - d) / day_time > 30
    else
      return Math.ceil ((now - d) / day_time)

  setLeft = (user, left) ->
    d = new Date()
    if d.getHours() >= 4
      d.setDate(d.getDate() + 1)
    d.setDate(d.getDate() - left)
    d.setHours(4)
    d.setMinutes(0)
    d.setSeconds(0)
    d.setMilliseconds(0)
    robot.brain.set "TO:#{user}", d

      

  robot.respond /use ([0-9]+(\.[0-9]*)?)( h)?/i, (res) ->
    nHour = res.match[1]*2
    user = res.message.user.name
    left = getLeft user
    if left >= nHour
      res.reply "#{(left - nHour) / 2} hours left"
      left = left - nHour
    else
      res.reply "only #{left / 2} hours left" 
    setLeft user, left

  robot.respond /time left(( .*)?)/i, (res) ->
    user = if res.match[1] then res.match[1] else res.message.user.name
    left = getLeft user
    res.reply "#{left / 2} hours left"
